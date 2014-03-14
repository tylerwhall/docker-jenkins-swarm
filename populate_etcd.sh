#!/bin/sh

. $(dirname $0)/resources/auth.sh

if [ -n "$CURL_OPTS" ]; then
    PROTO=https
else
    PROTO=http
fi

ETCD_URL=${ETCD_URL:-$PROTO://127.0.0.1:4001}

read -p "Jenkins URL: " url
read -p "Jenkins client username: " username
read -p "Jenkins client password: " password
set -ex
curl $CURL_OPTS $ETCD_URL/v2/keys/jenkins/url -XPUT -d value=$ur
curl $CURL_OPTS $ETCD_URL/v2/keys/jenkins/username -XPUT -d value=$username
curl $CURL_OPTS $ETCD_URL/v2/keys/jenkins/password -XPUT -d value=$password
