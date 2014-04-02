#!/bin/bash
set -eu

bundle install --path "${HOME}/bundles/${JOB_NAME}"

COMPONENTS="firewall nat lb"

for COMPONENT in $COMPONENTS; do
  echo "Executing component: ${COMPONENT}"

  bundle exec vcloud-net-spinner \
    -u ${vcloud_user} -p ${vcloud_pass} \
    -o 0e7t-infrastructure-services \
    -U 21731a8d-b690-456c-8f84-eb09f9b5768c \
    -i "interfaces.yaml" \
    -c ${COMPONENT} \
    -r "${COMPONENT}.rb" \
    https://myvdc.carrenza.net/api
done

logger -p INFO -t jenkins "DEPLOYMENT: ${JOB_NAME} ${BUILD_NUMBER} (${BUILD_URL})"
