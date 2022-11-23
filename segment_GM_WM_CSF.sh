#! /bin/bash

wdr=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed
outdr=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed/ICC

mkdir -p ${outdr}

# Segment for only the GM, WM, and CSF in the ICC maps using the MNI152_T1_1mm_brain_seg_0.nii.gz, (1, 2, 3) for CSF, GM, and WM respectively.
fslmaths ${wdr}/ICC2_cvr_lGLM.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_0.nii.gz ${outdr}/ICC_cvr_lGLM_CSF.nii.gz 
fslmaths ${wdr}/ICC2_cvr_lGLM.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_1.nii.gz ${outdr}/ICC_cvr_lGLM_GM.nii.gz
fslmaths ${wdr}/ICC2_cvr_lGLM.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_2.nii.gz ${outdr}/ICC_cvr_lGLM_WM.nii.gz

fslmaths ${wdr}/ICC2_delay_lGLM.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_0.nii.gz ${outdr}/ICC_delay_lGLM_CSF.nii.gz 
fslmaths ${wdr}/ICC2_delay_lGLM.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_1.nii.gz ${outdr}/ICC_delay_lGLM_GM.nii.gz
fslmaths ${wdr}/ICC2_delay_lGLM.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_2.nii.gz ${outdr}/ICC_delay_lGLM_WM.nii.gz

fslmaths ${wdr}/ICC2_cvr_vb.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_0.nii.gz ${outdr}/ICC_cvr_vb_CSF.nii.gz
fslmaths ${wdr}/ICC2_cvr_vb.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_1.nii.gz ${outdr}/ICC_cvr_vb_GM.nii.gz
fslmaths ${wdr}/ICC2_cvr_vb.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_2.nii.gz ${outdr}/ICC_cvr_vb_WM.nii.gz

fslmaths ${wdr}/ICC2_delay_vb.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_0.nii.gz ${outdr}/ICC_delay_vb_CSF.nii.gz
fslmaths ${wdr}/ICC2_delay_vb.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_1.nii.gz ${outdr}/ICC_delay_vb_GM.nii.gz
fslmaths ${wdr}/ICC2_delay_vb.nii.gz -mul ${wdr}/MNI152_T1_1mm_brain_seg_2.nii.gz ${outdr}/ICC_delay_vb_WM.nii.gz

echo "Done!"