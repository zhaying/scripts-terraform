#!/bin/bash
# Variables
os=$(uname -s | awk '{print tolower($0)}')
os_arch=$(uname -i)
tf_repo=https://releases.hashicorp.com/terraform/
tf_ver=$(curl -s https://api.github.com/repos/hashicorp/terraform/tags | grep name | head -n 1 | tr -d '",' | awk -F'v' '{print $2}')
tf_filename=terraform_
# Determine ARCH
if [ $os_arch == 'x86_64' ]
then
  arch="amd64"
fi
# Variables after ARCH determination
tf_fn_suffix="_$os_$arch.zip"
tf_fn_latest="$tf_filename$tf_ver$tf_fn_suffix"
tf_url="$tf_repo$tf_ver/$tf_fn_latest"
# Check variables
echo $os
echo $os_arch
echo $tf_fn_suffix
echo $tf_ver
echo $tf_url
echo $tf_fn_latest

# Download the file
sudo wget $tf_url
# Unzip the file
sudo unzip $tf_fn_latest -d /usr/local/bin/
# Check to see if it installed
terraform --version
