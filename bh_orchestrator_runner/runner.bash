#!/bin/bash

GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY
GH_TOKEN=$GH_TOKEN
RUNNER_NAME=$RUNNER_NAME
WORK_DIRECTORY=$WORK_DIRECTORY
LABELS=$LABELS

RUNNER_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
RUNNER_NAME_RND="${RUNNER_NAME}-${RUNNER_SUFFIX}"

REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/repos/${GH_OWNER}/${GH_REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

cd /home/vscode/actions-runner

./config.sh --unattended --url https://github.com/${GH_OWNER}/${GH_REPOSITORY} --token ${REG_TOKEN} --name ${RUNNER_NAME_RND} --work ${WORK_DIRECTORY} --labels ${LABELS} 

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!