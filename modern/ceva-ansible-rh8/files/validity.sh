#!/bin/bash

echo "Output of 'ifconfig | grep inet6':"
ifconfig | grep inet6 | awk '{print $0 "\n"}'

echo ""
echo ""

echo "Output of 'cat /etc/resolv.conf':"
cat /etc/resolv.conf | awk '{print $0 "\n"}'

echo ""
echo ""

echo "Output of 'service eraagent status':"
service eraagent status | grep -i "active:" | awk '{print $0 "\n"}'

echo ""
echo ""

echo "Output of 'service gytpol-client status':"
service gytpol-client status | grep -i "active:" | awk '{print $0 "\n"}'

echo ""
echo ""

echo "Output of 'service swiagentd status':"
service swiagentd status | grep -i "active:" | awk '{print $0 "\n"}'

echo ""
echo ""

echo "Output of 'dmidecode | grep -i \"Product Name\"':"
dmidecode | grep -i "Product Name" | awk '{print $0 "\n"}'

echo ""
echo ""

# Check if the system is Ubuntu or Red Hat and execute the corresponding command
if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [ "$ID" == "ubuntu" ]; then
        echo "Output of 'openssl x509 -in $(find /usr/share/ca-certificates/extra/ -iname \"*ceva*.crt\" -type f | head -n 1) -noout -text | grep \"Not After\"':"
        openssl x509 -in $(find /usr/share/ca-certificates/extra/ -iname "*ceva*.crt" -type f | head -n 1) -noout -text | grep "Not After" | awk '{print $0 "\n"}'
    elif [ "$ID" == "rhel" ]; then
        echo "Output of 'openssl x509 -in $(find /etc/pki/ca-trust/source/anchors/ -iname \"*CEVA*.cer\" -o -iname \"*ceva*.crt\" -type f | head -n 1) -text -noout | grep \"Not After\"':"
        openssl x509 -in $(find /etc/pki/ca-trust/source/anchors/ -iname "*CEVA*.cer" -o -iname "*ceva*.crt" -type f | head -n 1) -text -noout | grep "Not After" | awk '{print $0 "\n"}'
    fi
fi
