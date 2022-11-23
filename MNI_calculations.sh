#! /bin/bash
# This script concatenates the MNI maps and calculates the lGLM and vb CVR maps at a group level using ants
module load ants/latest
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008' 'sub-009')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

# Create empty variable to store the paths to the MNI maps
MNI_lGLM_cvr=()
MNI_lGLM_delay=()
MNI_vb_cvr=()
MNI_vb_delay=()

# Create lightbox png of vb, lGLM CVR and delay map for each subject and each session
for sub in ${SBJ_LIST[@]}
do
    for ses in ${SES_LIST[@]}
    do

        echo "Creating MNI_maps lists for session ${sub} ${ses}"
        # Add the path to the MNI map to the MNI_maps variable
        MNI_lGLM_cvr+=(${prj_dir}/std_lGLM_${sub}_${ses}.nii.gz)
        MNI_lGLM_delay+=(${prj_dir}/std_delay_lGLM_${sub}_${ses}.nii.gz)
        MNI_vb_cvr+=(${prj_dir}/std_vb_${sub}_${ses}.nii.gz)
        MNI_vb_delay+=(${prj_dir}/std_delay_vb_${sub}_${ses}.nii.gz)

        
    done
done

echo "Concatenating lGLM cvr MNI maps"
echo ${MNI_lGLM_cvr[@]}
fslmerge -t ${prj_dir}/MNI_all_lGLM_cvr.nii.gz ${MNI_lGLM_cvr[@]}
fslmaths ${prj_dir}/MNI_all_lGLM_cvr.nii.gz -Tmean ${prj_dir}/MNI_all_lGLM_cvr_mean.nii.gz

echo "Concatenating lGLM delay MNI maps"
echo ${MNI_lGLM_delay[@]}
fslmerge -t ${prj_dir}/MNI_all_lGLM_delay.nii.gz ${MNI_lGLM_delay[@]}
fslmaths ${prj_dir}/MNI_all_lGLM_delay.nii.gz -Tmean ${prj_dir}/MNI_all_lGLM_delay_mean.nii.gz

echo "Concatenating vb cvr MNI maps"
echo ${MNI_vb_cvr[@]}
fslmerge -t ${prj_dir}/MNI_all_vb_cvr.nii.gz ${MNI_vb_cvr[@]}
fslmaths ${prj_dir}/MNI_all_vb_cvr.nii.gz -Tmean ${prj_dir}/MNI_all_vb_cvr_mean.nii.gz

echo "Concatenating lGLM delay MNI maps"
echo ${MNI_vb_delay[@]}
fslmerge -t ${prj_dir}/MNI_all_vb_delay.nii.gz ${MNI_vb_delay[@]}
fslmaths ${prj_dir}/MNI_all_vb_delay.nii.gz -Tmean ${prj_dir}/MNI_all_vb_delay_mean.nii.gz