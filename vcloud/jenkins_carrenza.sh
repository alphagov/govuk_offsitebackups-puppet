#!/bin/bash
set -eu
bundle install --path "${HOME}/bundles/${JOB_NAME}"

export VCLOUD_ORG="0e7t-infrastructure-services"
export VCLOUD_HOST="myvdc.carrenza.net"

RUBYOPT="-r ./vcloud/fog_credentials" bundle exec vcloud-launch vcloud/box/carrenza/govuk_offsitebackups.yaml
logger -p INFO -t jenkins "DEPLOYMENT: ${JOB_NAME} ${BUILD_NUMBER} (${BUILD_URL})"
RUBYOPT="-r ./vcloud/fog_credentials" bundle exec vcloud-configure-edge vcloud/net/carrenza/edge.yaml
logger -p INFO -t jenkins "Configuring ${BUILD_NUMBER}'s network settings..."
