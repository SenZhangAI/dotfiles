#!/usr/bin/env bash

# https://docs.docker.com/config/daemon/

set -e

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cp $base_dir/condarc $HOME/.condarc

#清除缓存，更新索引
conda clean -i

# vim:sw=4
