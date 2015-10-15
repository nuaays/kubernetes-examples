#!/bin/bash

set -e

mounts="${@}"

seq=0
for mnt in "${mounts[@]}"; do
  src=$(echo $mnt | awk -F':' '{ print $1 }')
  echo "$src *(rw,sync,no_subtree_check,fsid=$seq,no_root_squash)" >> /etc/exports
  seq=$(($seq + 1))
done

exec runsvdir /etc/sv
