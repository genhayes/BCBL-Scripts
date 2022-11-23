#! /bin/bash
# This script
module load afni/latest

prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps
out_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed
means_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/means

#V_to_mmHg=71.2

mkdir -p $out_dir
mkdir -p $means_dir

# SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
# SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')
SBJ_LIST=('sub-004')
SES_LIST=('ses-05')


for sub in "${SBJ_LIST[@]}"
do
    for ses in "${SES_LIST[@]}"
    do
        mask_path=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/${sub}/${ses}/func_preproc/task-breathhold_rec-magnitude_echo-1_sbref_brain_mask.nii
        echo "Centering delay maps for ${sub} ${ses} using the mean of the delay map"
        # Calculate the mean of the delay map
        3dROIstats -mask ${mask_path} -quiet ${prj_dir}/${sub}_${ses}_delay_lGLM.nii > ${means_dir}/${sub}_${ses}_delay_lGLM_mean.txt
        # Subtract the mean from the delay map
        3dcalc -a ${prj_dir}/${sub}_${ses}_delay_lGLM.nii -b ${mask_path} -expr "b*(a-$(cat ${means_dir}/${sub}_${ses}_delay_lGLM_mean.txt))" -prefix ${out_dir}/${sub}_${ses}_delay_lGLM.nii -overwrite

        # Calculate the mean of the delay map
        3dROIstats -mask ${mask_path} -quiet ${prj_dir}/${sub}_${ses}_delay_vb.nii > ${means_dir}/${sub}_${ses}_delay_vb_mean.txt
        # Subtract the mean from the delay map
        3dcalc -a ${prj_dir}/${sub}_${ses}_delay_vb.nii -b ${mask_path} -expr "b*(a-$(cat ${means_dir}/${sub}_${ses}_delay_lGLM_mean.txt))" -prefix ${out_dir}/${sub}_${ses}_delay_vb.nii -overwrite
    done
done