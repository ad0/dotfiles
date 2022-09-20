#!/bin/bash

updates="$(checkupdates)"
if [[ $? == 0 ]]; then
    text="$(echo "$updates" | wc -l)"
    class="pending"
    percentage=100
    tooltip=$(echo "$updates" | sed -z 's/\n/\\n/g')
else
    num_updates=""
    class="uptodate"
    percentage=0
    tooltip="Up-to-date  "
fi

echo '{"text": "'$text'", "tooltip": "'${tooltip::-2}'", "class": "'$class'", "percentage":'$percentage'}'
