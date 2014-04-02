#!/bin/bash
set -eu
bundle install --path "${HOME}/bundles/${JOB_NAME}"

${WORKSPACE}/vcloud/box/carrenza/generate_fogfile.sh
export FOG_RC=${WORKSPACE}/fog_cred.config

bundle exec vcloud-launch vcloud/box/carrenza/govuk_offsitebackups.yaml
logger -p INFO -t jenkins "DEPLOYMENT: ${JOB_NAME} ${BUILD_NUMBER}
(${BUILD_URL})"
bundle exec vcloud-configure-edge vcloud/net/carrenza/edge.yaml
logger -p INFO -t jenkins "Configuring ${BUILD_NUMBER}'s network settings..."
echo "Removing Fog file..."
rm fog_cred.config
