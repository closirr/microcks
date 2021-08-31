#!/bin/bash

#HOSTNAME=$1
#VERSION=$2

#echo "Installing jq and docker-compose packages ..."
#apt-get update
#apt-get install -y jq docker docker-compose

echo "Generating certificates for '$HOSTNAME' ..."
mkdir keystore
docker run -v $PWD/keystore:/certs -e SERVER_HOSTNAMES="ec2-3-112-125-96.ap-northeast-1.compute.amazonaws.com" -it nmasse/mkcert:0.1
mv ./keystore/server.crt ./keystore/tls.crt
mv ./keystore/server.key ./keystore/tls.key
mv ./keystore/server.p12 ./keystore/microcks.p12

echo
echo "Microcks is now installed with self-signed certificates"
echo "------------------------------------------"
echo "Start it with: docker-compose -f docker-compose.yml up -d"
echo "Stop it with: docker-compose -f docker-compose.yml stop"
echo "Re-launch it with: docker-compose -f docker-compose.yml start"
echo "Clean everything with: docker-compose -f docker-compose.yml down"
echo "------------------------------------------"
echo "Go to https://$HOSTNAME:8080 - first login with admin/123"
echo "Having issues? Check you have changed docker-compose.yml to your platform"
echo
