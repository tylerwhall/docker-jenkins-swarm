#!/bin/sh -e

read -p "Client name: " name

mkdir -p $name
make ca.crt
cp ca.crt $name
make $name/client.crt

echo "Cert bundle created in `pwd`/$name"
