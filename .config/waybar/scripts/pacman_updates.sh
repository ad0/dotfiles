#!/bin/bash

updates="$(checkupdates)"
num_updates="$(echo -n "$updates" | wc -l)"
if [[ $num_updates == 0 ]]; then
    num_updates=""
    class="uptodate"
    percentage=0
else
    num_updates="$(echo "$updates" | wc -l)"
    class="pending"
    percentage=100
fi

tooltip=$(echo "$updates" | sed -z 's/\n/\\n/g')

echo '{"text": "'$num_updates'", "tooltip": "'${tooltip::-2}'", "class": "'$class'", "percentage":'$percentage'}'
