ETCD_AUTHDIR=${ETCD_AUTHDIR:-./ca/client}

CACERT="$ETCD_AUTHDIR/ca.crt"
CERT="$ETCD_AUTHDIR/client.crt"
KEY="$ETCD_AUTHDIR/client.key"

if [ -f "$CACERT" ]; then
    CURL_OPTS="$CURL_OPTS --cacert $CACERT"
fi
if [ -f "$CERT" ]; then
    CURL_OPTS="$CURL_OPTS --cert $CERT"
fi
if [ -f "$KEY" ]; then
    CURL_OPTS="$CURL_OPTS --key $KEY"
fi
