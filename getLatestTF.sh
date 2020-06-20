#!/bin/bash
# Expected Url Format as of 6/20/2020
# https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip

# Variables
os="_$(uname -s | awk '{print tolower($0)}')"
os_arch=$(uname -m)
tf_repo=https://releases.hashicorp.com/terraform
tf_ver=$(curl -s https://api.github.com/repos/hashicorp/terraform/tags | grep -v 'alpha\|beta\|rc' | grep name | head -n 1 | tr -d '",' | awk -F'v' '{print $2}')
tf_filename=terraform_

# Determine ARCH x86_64
if [ $os_arch == 'x86_64' ]
then
  arch="_amd64"
  echo $arch
fi

if [ $os_arch == 'i386' ]
then
  arch="_386"
  echo $arch
fi

# Variables after ARCH determination
tf_fn_suffix="$os$arch.zip"
tf_fn_latest="$tf_filename$tf_ver$tf_fn_suffix"
tf_url="$tf_repo/$tf_ver/$tf_fn_latest"

# Check variables
echo $os
echo $os_arch
echo $tf_repo
echo $tf_ver
echo $tf_filename
echo $arch
echo $tf_fn_suffix
echo $tf_fn_latest
echo $tf_url

# Download the file
sudo wget -4 $tf_url

# Unzip the file
sudo unzip $tf_fn_latest -d /usr/local/bin/

# Check to see if it installed
terraform --version
