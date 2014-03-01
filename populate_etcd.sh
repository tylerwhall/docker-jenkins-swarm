#!/bin/sh

ETCD_URL=${ETCD_URL:-https://127.0.0.1:5001}

. $(dirname $0)/auth.sh

read -p "Jenkins URL: " url
read -p "Jenkins client username: " username
read -p "Jenkins client password: " password
set -ex
curl $CURL_OPTS $ETCD_URL/v2/keys/jenkins/url -XPUT -d value=$ur
curl $CURL_OPTS $ETCD_URL/v2/keys/jenkins/username -XPUT -d value=$username
curl $CURL_OPTS $ETCD_URL/v2/keys/jenkins/password -XPUT -d value=$password
