ETCD_AUTHDIR=${ETCD_AUTHDIR:-./ca/client}

CACERT="$ETCD_AUTHDIR/ca.crt"
CERT="$ETCD_AUTHDIR/client.crt"
KEY="$ETCD_AUTHDIR/client.key"
