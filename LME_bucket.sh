#! /bin/bash

wdr=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed/LMEr

for map in cvr delay
do
    # Define n
    n=$(fslval ${wdr}/LMEr_${map}.nii.gz dim5)

    for ind in $(seq 0 $n)
    do
        name=$(3dinfo -label ${wdr}/LMEr_${map}.nii.gz[$ind])
        name="${name// /_}"
        3dbucket -prefix ${wdr}/LMEr_${map}_"${name}".nii.gz -overwrite ${wdr}/LMEr_${map}.nii.gz[$ind]
    done

    echo "Done $map LMEr map bucketting!"

done 

echo "Done!"


