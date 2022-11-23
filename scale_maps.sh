#! /bin/bash
# This script
module load afni/latest
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps
out_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed

#V_to_mmHg=71.2

mkdir -p $out_dir

# SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
# SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')
SBJ_LIST=('sub-004')
SES_LIST=('ses-05')


for sub in ${SBJ_LIST[@]}
do
    for ses in ${SES_LIST[@]}
    do
        echo "Scaling maps for ${sub} ${ses} by 1/71.2"
        3dcalc -a ${prj_dir}/${sub}_${ses}_cvr1_lGLM.nii -expr "a/71.2" -prefix ${out_dir}/${sub}_${ses}_cvr1_lGLM.nii -overwrite
        3dcalc -a ${prj_dir}/${sub}_${ses}_cvr1_vb.nii -expr "a/71.2" -prefix ${out_dir}/${sub}_${ses}_cvr1_vb.nii -overwrite
    done
done

