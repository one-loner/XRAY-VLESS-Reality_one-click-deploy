#!/bin/bash
if [ -z "$1" ]; then
    echo "This script change cloaking from whatsapp.com to site that you enter."
    echo "Usage $0 <Site to cloaking>"
    exit 1
fi
cp config.json config.json.default
cp install.sh install.sh.default
sed -i 's/"gist.github.com",//g' config.json
sed -i "s/github.com/$1/g" config.json
sed -i "s/github.com:443/$1:443/g" config.json
sed -i "s/github.com/$1/g" install.sh
echo "Done. Site to cloaking changed to $1. Original files saved with .default postfix."
