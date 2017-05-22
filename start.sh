#!/bin/sh

nohup node ./node-rest-proxy/rest-proxy.js &
/opt/eclipse/kura/bin/start_kura.sh
