#!/bin/bash
set -eu
bundle install --path "${HOME}/bundles/${JOB_NAME}"

RUBYOPT="-r ./vcloud/box/carrenza/fog_credentials" bundle exec vcloud-launch vcloud/box/carrenza/govuk_offsitebackups.yaml
logger -p INFO -t jenkins "DEPLOYMENT: ${JOB_NAME} ${BUILD_NUMBER}
(${BUILD_URL})"
bundle exec vcloud-configure-edge vcloud/net/carrenza/edge.yaml
logger -p INFO -t jenkins "Configuring ${BUILD_NUMBER}'s network settings..."
