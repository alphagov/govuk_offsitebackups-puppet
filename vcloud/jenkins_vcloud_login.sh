#!/bin/bash
set -eu

function cleanup {
  rm $FOG_RC
  unset FOG_RC
}

# Override default of ~/.fog and delete afterwards.
export FOG_RC=$(mktemp /tmp/vcloud_fog_rc.XXXXXXXXXX)
trap cleanup EXIT

unset FOG_CREDENTIAL
cat <<EOF >${FOG_RC}
default:
  vcloud_director_host: '${VCLOUD_HOST}'
  vcloud_director_username: '${VCLOUD_USER}@${VCLOUD_ORG}'
  vcloud_director_password: ''
EOF

# Never log token to STDOUT.
set +x
eval $(printenv VCLOUD_PASS | bundle exec vcloud-login)
