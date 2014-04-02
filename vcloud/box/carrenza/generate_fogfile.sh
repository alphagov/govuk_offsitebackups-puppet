cat <<EOF >fog_cred.config
default:
  vcloud_director_username: $VCLOUD_USER@0e7t-infrastructure-services
  vcloud_director_password: $VCLOUD_PASS
  vcloud_director_host: 'myvdc.carrenza.net'
EOF
