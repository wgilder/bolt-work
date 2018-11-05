#!/usr/bin/env bash

# Puppet Task Name: 
#  aws::create_instance

if [ -z "$PT_name" ] || [ -z "$PT_image_id" ] || [ -z "$PT_instance_type" ] || [ -z "$PT_key_name" ] || [ -z "$PT_security_groups" ]; then
  echo Required parameters: name, image_id, instance_type, key_name, security_groups
  exit 1
fi

if [ -z "$PT_region" ]; then
  if [ -z $AWS_REGION ]; then
    echo If \$AWS_REGION is not set, then the region parameter is required
    exit 1
  fi

  PT_region=$AWS_REGION
fi

if [ -n "$PT_ensure" ]; then
  _ENSURE="  ensure => $PT_ensure,"
fi

if [ -n "$PT_subnet" ]; then
  _SUBNET="  subnet => '$PT_subnet',"
fi

if [ -n "$PT_tags" ]; then
  _TAGS=$(echo $PT_tags | sed -e 's/;/","/g' -e 's/$/",/' -e 's/=/"=>"/g' -e 's/^/"/')
fi

/opt/puppetlabs/bin/puppet apply <<PUPPET_MANIFEST_HERE
ec2_instance { '$PT_name':
$_ENSURE
  region => '$PT_region',
  image_id => '$PT_image_id',
  instance_type => '$PT_instance_type',
  key_name => '$PT_key_name',
  security_groups => '$PT_security_groups',
$_SUBNET
  tags => {
    $_TAGS
  }
}
PUPPET_MANIFEST_HERE
