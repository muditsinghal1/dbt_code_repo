#!/bin/bash

env -0 | while IFS='=' read -r -d '' n v; do
    if [[ $n = GIT_RSA_KEY_* ]]
    then
      echo $v
      (umask  077 ; echo $v | tr " " "\n"| base64 -d > /tmp/$n.p8)
    fi
done

env -0 | while IFS='=' read -r -d '' n v; do
    if [[ $n = GIT_RSA_PASS_* ]]
    then
      (umask  077 ; echo $v | tr " " "\n"| base64 -d > /tmp/$n.txt)
    fi
done
