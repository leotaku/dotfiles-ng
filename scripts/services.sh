#!/usr/bin/env sh
output="$(systemctl list-units ${2} --state=failed | tail -n1 | cut -f 1 -d ' ')"
echo "${output}${1}"
