#!/bin/bash

if [ -z "$ETCD_URL" ]; then
    echo 'Must specify $ETCD_URL in environment'
    exit 1
fi

ETCD_AUTHDIR=${ETCD_AUTHDIR:-./ca}

. $(dirname $0)/resources/auth.sh

if [ -f "$CACERT" -a -f "$CERT" -a -f "$KEY" ]; then
    CURL_AUTH="--cacert $CACERT --cert $CERT --key $KEY"
else
    echo "Authentication files not found. Proceeding without."
fi

function get_etcd_value () {
    json=`curl $CURL_AUTH -s -L "$ETCD_URL/v2/keys/$2"`
    if [ $? -ne 0 ]; then echo "curl failed to connect to etcd at $ETCD_URL"; exit 1; fi
    val=`echo $json | jq -r .node.value`
    [ "$val" == "null" ] && val=""
    eval $1="$val"
}

get_etcd_value JENKINS_URL jenkins/url
if [ -z "$JENKINS_URL" ]; then
    echo "Unable to retrieve jenkins url from etcd."
    exit 1
fi

DISTRO=`lsb_release -irs | tr -d ' '`

get_etcd_value JENKINS_USERNAME jenkins/username
get_etcd_value JENKINS_PASSWORD jenkins/password

if [ -n "$JENKINS_USERNAME" -a -n "$JENKINS_PASSWORD" ]; then
    JENKINS_USERPASS="-username $JENKINS_USERNAME -password $JENKINS_PASSWORD"
else
    echo "User/pass not found. Using no Jenkins authentication"
fi

SWARM_LABELS="$SWARM_LABELS $DISTRO"

cmd="java -jar $HOME/swarm-client.jar -master "$JENKINS_URL" $JENKINS_USERPASS -labels '$SWARM_LABELS' $SWARM_OPTIONS"
echo $cmd
eval $cmd
