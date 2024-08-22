#!/bin/bash
if (($EUID !=0)); then
     echo Script must be run by root.
     exit
fi
echo "Updating and Upgrading software."
apt-get update
apt-get upgrade -y
echo "Installing requirements. "
apt-get install -y docker docker-compose curl qrencode
ip=$(curl http://ifconfig.me)
uuuid=$(cat /proc/sys/kernel/random/uuid)
cp config.json config.json.original
cp client_config.json client_config.json.original
sed -i "s/uuuuid/$uuuid/g" config.json
sed -i "s/uuuuid/$uuuid/g" client_config.json
sed -i "s/ipaddr/$ip/g" client_config.json

echo 'Files config.json and client_config.json is changed by your settings. Original files saved with .original postfix.'
sleep 5
docker-compose up -d
docker ps

link='vless://'$uuuid'@'$ip':443?type=tcp&security=reality&pbk=NWTvA5yoa70i6R5oNXCiJAGqMweNBXQY8tclhbmxbT0&fp=firefox&sni=whatsapp.com&sid=0ec74dd2&spx=%2F#Reality'

echo "Your client link and QR-code "
echo $link
qrencode -t ANSIUTF8 $link
echo ''
echo ''
echo ''
echo $link > links.txt
echo 'Link saved in file links.txt'
echo 'Client configuration in json format you can find in client_config.json'
