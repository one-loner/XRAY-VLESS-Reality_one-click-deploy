#!/bin/bash
if [ -z "$1" ]; then
    echo "This script change cloaking from whatsapp.com to site that you enter."
    echo "Usage $0 <Site to cloaking>"
    exit 1
fi
cp config.json config.json.default
cp install.sh install.sh.default
sed -i 's/"whatsapp.com",//g' config.json
sed -i "s/web.whatsapp.com/$1/g" config.json
sed -i "s/whatsapp.com:443/$1:443/g" config.json
sed -i "s/whatsapp.com/$1/g" install.sh
echo "Done. Site to cloaking changed to $1. Original files saved with .default postfix."
