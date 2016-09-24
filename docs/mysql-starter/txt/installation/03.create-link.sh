#!/bin/bash
# START === create symlink
export link_path=/opt/csitea/mysql-starter/sfw/mysql-starter.sh
export target_path=/opt/csitea/mysql-starter/mysql-starter.1.0.0.prd.ysg/sfw/bash/mysql-starter/mysql-starter.sh
mkdir -p `dirname $link_path`
unlink $link_path
ln -s "$target_path" "$link_path"
ls -la $link_path;
# STOP === create symlink

