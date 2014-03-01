#!/bin/sh

set -e

PUBLIC_IP=${PUBLIC_IP:-127.0.0.1}

. $(dirname $0)/auth.sh

if [ -f "$CERT" -a -f "$KEY" ]; then
    DOCKER_OPTS="-v $ETCD_AUTHDIR:/auth"
    ETCD_AUTH="-cert-file=/auth/client.crt -key-file=/auth/client.key"
    echo "Using server SSL"
    if [ -f "$CACERT" ]; then
        ETCD_AUTH="$ETCD_AUTH -ca-file=/auth/ca.crt"
        echo "Using client SSL"
    fi
else
    echo "Authentication files not found. Proceeding without."
fi

exec docker run -d -p 8001:8001 -p 5001:5001 $DOCKER_OPTS coreos/etcd -peer-addr ${PUBLIC_IP}:8001 -addr ${PUBLIC_IP}:5001 -name `hostname` $ETCD_AUTH
