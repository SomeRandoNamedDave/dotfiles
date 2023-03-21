#!/bin/sh

# this is being run as root so the usual variables can't be used here
# edit this to the absolute path to your cache folder
cache_path=/home/dave/.cache

n=$(pacman -Qqn --color never | wc -l)
m=$(pacman -Qqm --color never | wc -l)
[ -d ${cache_path}/fetch ] || mkdir -p ${cache_path}/fetch
echo "${n} ${m}" > ${cache_path}/fetch/pkg_stats
