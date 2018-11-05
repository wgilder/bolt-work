#!/usr/bin/env bash

ITER=0

for i in $(jq -r '.[].os' aws-config.json); do
  echo $ITER: $i
  ((++ITER))
done

read -p "Type of machine to create> " a

MIN_SIZE=$(echo "jq -r '.[$a].imagemin' aws-config.json" | bash)
AMI_ID=$(echo "jq -r '.[$a].ami' aws-config.json" | bash)

ITER=0
declare -a SIZES
while [ "$MIN_SIZE" != "null" ]; do
  echo $ITER: $MIN_SIZE
  SIZES[$ITER]=$MIN_SIZE
  ((++ITER))
  MIN_SIZE=$(echo "jq -r '.[\"$MIN_SIZE\"]' aws-sizes.json" | bash)
done

read -p "Size of machine> " a
AMI_SIZE=$(echo "t2.${SIZES[$a]}")

read -p "Region ($AWS_REGION)> " r
if [ -z "$r" ]; then
  AMI_REGION=$AWS_REGION
else
  AMI_REGION=$r
fi

read -p "Name> " AMI_NAME
read -p "Lifetime (1w)> " AMI_LIFETIME

if [ -z "$AMI_LIFETIME" ]; then
  AMI_LIFETIME="1w"
fi

read -p "Key name (wmg-mbp)> " AMI_KEY

if [ -z "$AMI_KEY" ]; then
  AMI_KEY=wmg-mbp
fi

read -p "Security group (ssh-only)> " AMI_SEC_GROUP

if [ -z "$AMI_SEC_GROUP" ]; then
  AMI_SEC_GROUP=ssh-only
fi

read -p "Subnet (tse-wmg-daybook-01)> " AMI_SUBNET

if [ -z "$AMI_SUBNET" ]; then
  AMI_SUBNET=tse-wmg-daybook-01
fi

read -p "Target machine url (ec2-18-184-134-92.eu-central-1.compute.amazonaws.com)> " BOLT_URL

if [ -z "$BOLT_URL" ]; then
  BOLT_URL=ec2-18-184-134-92.eu-central-1.compute.amazonaws.com
fi

echo bolt task run aws::create_instance --nodes=$BOLT_URL --run-as=root --modulepath=~/Bolt/bolt-work/ name="$AMI_NAME" ensure=running region=$AMI_REGION key_name=$AMI_KEY image_id=$AMI_ID instance_type=$AMI_SIZE security_groups=$AMI_SEC_GROUP subnet=$AMI_SUBNET tags="lifetime=$AMI_LIFETIME"
