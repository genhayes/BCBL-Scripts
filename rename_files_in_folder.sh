#!/usr/bin/env bash
MNI_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/025_MNI_maps_postprocessed
# This script will rename all files that don't contain the string "delay" to replace "std_" with "std_cvr_"
# This is because the delay maps are already named correctly
for file in "${MNI_dir}"/*; do
    if [[ ! "${file}" == *"delay"* ]]; then
        mv "${file}" "${file//std_/std_cvr_}"
    fi
done

echo "Done!"
