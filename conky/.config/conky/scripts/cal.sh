#!/bin/bash

LAR=$(date +%-d)

cal_data=$(ncal -bh)

# Count rows
rows=$(echo "$cal_data" | wc -l)

# Split into array
mapfile -t lines <<<"$cal_data"

if ((rows > 5)); then
  last=$(echo "${lines[-1]}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
  first="${lines[2]}"
  len=${#last}
  merged="${last}${first:len:-1}"
  echo "${lines[0]}"
  echo "${lines[1]}"
  echo "$merged"
  for ((i = 3; i < rows - 1; i++)); do
    echo "${lines[i]}"
  done
else
  printf "%s\n" "${lines[@]}" >/tmp/cal_fmt
fi
