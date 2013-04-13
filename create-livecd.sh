#!/bin/bash

# NOTE TO SELF: Must update sha512sums in build server after modifying this
# script!

if [ "x$(whoami)" != "xroot" ]; then
  echo "This script must be run as root!"
  exit 1
fi

pushd unity &>/dev/null

./build.sh -N Unity-for-Arch        \
           -V $(date '+%Y.%m.%d')   \
           -L UFA_$(date '+%Y%m%d') \
           -v

popd &>/dev/null
