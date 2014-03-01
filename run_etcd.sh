#!/bin/sh

PUBLIC_IP=${PUBLIC_IP:-127.0.0.1}
ETCD_AUTHDIR=${ETCD_AUTHDIR:-./ca}

CACERT="$ETCD_AUTHDIR/ca.crt"
CERT="$ETCD_AUTHDIR/client.crt"
KEY="$ETCD_AUTHDIR/client.key"

if [ -f "$CERT" -a -f "$KEY" ]; then
    ETCD_AUTH="-cert-file=$CERT -key-file=$KEY"
    echo "Using server SSL"
    if [ -f "$CACERT" ]; then
        ETCD_AUTH="$ETCD_AUTH -ca-file=$CACERT"
        echo "Using client SSL"
    fi
else
    echo "Authentication files not found. Proceeding without."
fi

exec docker run -d -p 8001:8001 -p 5001:5001 coreos/etcd -peer-addr ${PUBLIC_IP}:8001 -addr ${PUBLIC_IP}:5001 -name `hostname` $ETCD_AUTH
