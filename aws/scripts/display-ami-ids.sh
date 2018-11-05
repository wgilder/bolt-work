#!/usr/bin/env bash

while read i; do
  IFS='	' a=($i) # 	< TAB
  CMD=${a[1]}
  RESULT=$($CMD)
  echo $RESULT
  echo $CMD
#  echo ${a[0]}: $(${a[1]})
done <<AWS_RAW
centos-6	aws ec2 describe-images --filters 'Name=state,Values=available' 'Name=description,Values=CentOS Linux 6*ENA*' --query 'Images[*].{id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
centos-7	aws ec2 describe-images --filters 'Name=state,Values=available' 'Name=description,Values=CentOS Linux 7*ENA*' --query 'Images[*].{id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
rhel-5	aws ec2 describe-images --filters 'Name=owner-id,Values=309956199498' 'Name=state,Values=available' 'Name=name,Values=RHEL-5*' --query 'Images[*].{name:Name,id:ImageId,date:CreationDate}' | jq 'sort_by(.date)|last.id'
rhel-6	aws ec2 describe-images --filters 'Name=owner-id,Values=309956199498' 'Name=state,Values=available' 'Name=name,Values=RHEL-6*' --query 'Images[*].{name:Name,id:ImageId,date:CreationDate}' | jq 'sort_by(.date)|last.id'
rhel-7	aws ec2 describe-images --filters 'Name=owner-id,Values=309956199498' 'Name=state,Values=available' 'Name=name,Values=RHEL-7*' --query 'Images[*].{name:Name,id:ImageId,date:CreationDate}' | jq 'sort_by(.date)|last.id'
ubuntu-14	aws ec2 describe-images --filters 'Name=owner-id,Values=099720109477' 'Name=description,Values=*Ubuntu*14.04 LTS*' 'Name=state,Values=available' --query 'Images[*].{desc:Description,id:ImageId,date:CreationDate}' --output json | jq '[sort_by(.date)|.[]|select(.desc|test(".*(UNSUPPORTED|EKS|Minimal).*")|not)]|last.id'
ubuntu-16	aws ec2 describe-images --filters 'Name=owner-id,Values=099720109477' 'Name=description,Values=*Ubuntu*16.04 LTS*' 'Name=state,Values=available' --query 'Images[*].{desc:Description,id:ImageId,date:CreationDate}' --output json | jq '[sort_by(.date)|.[]|select(.desc|test(".*(UNSUPPORTED|EKS|Minimal).*")|not)]|last.id'
ubuntu-18	aws ec2 describe-images --filters 'Name=owner-id,Values=099720109477' 'Name=description,Values=*Ubuntu*18.04 LTS*' 'Name=state,Values=available' --query 'Images[*].{desc:Description,id:ImageId,date:CreationDate}' --output json | jq '[sort_by(.date)|.[]|select(.desc|test(".*(UNSUPPORTED|EKS|Minimal).*")|not)]|last.id'
sles-11	aws ec2 describe-images --filters 'Name=description,Values=SUSE Linux Enterprise Server 11*' 'Name=owner-id,Values=013907871322' --query 'Images[*].{desc:Description,id:ImageId,date:CreationDate}' | jq '[sort_by(.date)|.[]|select(.desc|test(".*(SAP|ECS|BYOS).*")|not)]|last.id'
sles-12	aws ec2 describe-images --filters 'Name=description,Values=SUSE Linux Enterprise Server 12*' 'Name=owner-id,Values=013907871322' --query 'Images[*].{desc:Description,id:ImageId,date:CreationDate}' | jq '[sort_by(.date)|.[]|select(.desc|test(".*(SAP|ECS|BYOS).*")|not)]|last.id'
sles-15	aws ec2 describe-images --filters 'Name=description,Values=SUSE Linux Enterprise Server 15*' 'Name=owner-id,Values=013907871322' --query 'Images[*].{desc:Description,id:ImageId,date:CreationDate}' | jq '[sort_by(.date)|.[]|select(.desc|test(".*(SAP|ECS|BYOS).*")|not)]|last.id'
windows-2003	aws ec2 describe-images --filter 'Name=description,Values=Microsoft Windows Server 2003 R2 SP2 Datacenter 64-bit Multi-Language Base AMI provided by Amazon' 'Name=state,Values=available' --query 'Images[*].{id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
windows-2008	aws ec2 describe-images --filters 'Name=description,Values=Microsoft Windows Server 2008 SP2 Datacenter 64-bit Locale English Base AMI provided by Amazon' 'Name=state,Values=available' --query 'Images[*].{id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
windows-2008r2	aws ec2 describe-images --filters 'Name=description,Values=Microsoft Windows Server 2008 R2 SP1 Datacenter 64-bit Locale English Base AMI provided by Amazon' 'Name=state,Values=available' --query 'Images[*].{id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
windows-2012	aws ec2 describe-images --filters 'Name=description,Values=Microsoft Windows Server 2012 RTM 64-bit Locale English Base AMI provided by Amazon' 'Name=state,Values=available' --query 'Images[*].{id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
windows-2012r2	aws ec2 describe-images --filters 'Name=description,Values=Microsoft Windows Server 2012 R2 RTM 64-bit Locale English AMI provided by Amazon' 'Name=state,Values=available' --query 'Images[*].{id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
windows-2016	aws ec2 describe-images --filters 'Name=description,Values=Microsoft Windows Server 2016 with Desktop Experience Locale English AMI provided by Amazon' 'Name=state,Values=available' --query 'Images[*].{id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
puppet-enterprise	aws ec2 describe-images --filters 'Name=description,Values=*Puppet Enterprise*BYOL*' 'Name=state,Values=available' --query 'Images[*].{desc:Description,id:ImageId,date:CreationDate}' --output json | jq 'sort_by(.date)|last.id'
AWS_RAW
