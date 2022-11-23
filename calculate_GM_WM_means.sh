#! /bin/bash

# This script calculates the mean values for lGLM and vb CVR and delay maps using fslmaths and fslstats
module load fsl/6.0.3

prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps/
# Create a folder for the links
mkdir -p $prj_dir/mean_values/
# Move into the folder
cd $prj_dir/mean_values/ || exit
out_dir=$prj_dir/mean_values/

# Create txt files to store mean values
echo "lGLM CVR GM, lGLM CVR WM, VB CVR GM, VB CVR WM" > ${out_dir}cvr_GMWMmeans.csv
echo "lGLM Delay GM, lGLM Delay WM, VB Delay GM, VB Delay WM" > ${out_dir}delay_GMWMmeans.csv

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008' 'sub-009')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

# Create lightbox png of vb, lGLM CVR and delay map for each subject and each session
for sub in ${SBJ_LIST[@]}
do
    for ses in ${SES_LIST[@]}
    do

        # Path to the CSF (val=1), GM (val=2), WM (val=3)segmentation file 
        seg_filepath=/bcbl/home/public/PJMASK_2/preproc/derivatives/thesis/${sub}/ses-01/anat_preproc/${sub}_ses-01_acq-uni_T1w_seg2mref.nii.gz
        
        echo "Extracting GM and WM values and computing the mean for each for session ${sub} ${ses}"
        echo "${sub}_${ses}" >> ${out_dir}cvr_GMWMmeans.csv

        #CVR lGLM
        echo "lGLM CVR GM & WM mean values:"
        fslmaths ${seg_filepath} -thr 2 -uthr 2 -bin -mul ${prj_dir}${sub}_${ses}_cvr1_lGLM.nii ${out_dir}${sub}_${ses}_cvr1_lGLM_GM.nii
        fslstats ${out_dir}${sub}_${ses}_cvr1_lGLM_GM.nii -m >> ${out_dir}cvr_GMWMmeans.csv #mean value of GM 
        fslmaths ${seg_filepath} -thr 3 -uthr 3 -bin -mul ${prj_dir}${sub}_${ses}_cvr1_lGLM.nii ${out_dir}${sub}_${ses}_cvr1_lGLM_WM.nii
        fslstats ${out_dir}${sub}_${ses}_cvr1_lGLM_WM.nii -m >> ${out_dir}cvr_GMWMmeans.csv #mean value of WM 

        #CVR VB
        echo "VB CVR GM & WM means values:"
        fslmaths ${seg_filepath} -thr 2 -uthr 2 -bin -mul ${prj_dir}${sub}_${ses}_cvr1_vb.nii ${out_dir}${sub}_${ses}_cvr1_vb_GM.nii
        fslstats ${out_dir}${sub}_${ses}_cvr1_vb_GM.nii -m >> ${out_dir}cvr_GMWMmeans.csv #mean value of GM 
        fslmaths ${seg_filepath} -thr 3 -uthr 3 -bin -mul ${prj_dir}${sub}_${ses}_cvr1_vb.nii ${out_dir}${sub}_${ses}_cvr1_vb_WM.nii
        fslstats ${out_dir}${sub}_${ses}_cvr1_vb_WM.nii -m >> ${out_dir}cvr_GMWMmeans.csv #mean value of WM 

        echo "${sub}_${ses}" >> ${out_dir}delay_GMWMmeans.csv

        #Delay lGLM
        echo "lGLM delay GM & WM means values:" 
        fslmaths ${seg_filepath} -thr 2 -uthr 2 -bin -mul ${prj_dir}${sub}_${ses}_delay_lGLM.nii ${out_dir}${sub}_${ses}_delay_lGLM_GM.nii
        fslstats ${out_dir}${sub}_${ses}_delay_lGLM_GM.nii -m >> ${out_dir}delay_GMWMmeans.csv #mean value of GM 
        fslmaths ${seg_filepath} -thr 3 -uthr 3 -bin -mul ${prj_dir}${sub}_${ses}_delay_lGLM.nii ${out_dir}${sub}_${ses}_delay_lGLM_WM.nii
        fslstats ${out_dir}${sub}_${ses}_delay_lGLM_WM.nii -m >> ${out_dir}delay_GMWMmeans.csv #mean value of WM 

        #Delay VB
        echo "VB delay GM & WM means values:"
        fslmaths ${seg_filepath} -thr 2 -uthr 2 -bin -mul ${prj_dir}${sub}_${ses}_delay_vb.nii ${out_dir}${sub}_${ses}_delay_vb_GM.nii
        fslstats ${out_dir}${sub}_${ses}_delay_vb_GM.nii -m >> ${out_dir}delay_GMWMmeans.csv #mean value of GM 
        fslmaths ${seg_filepath} -thr 3 -uthr 3 -bin -mul ${prj_dir}${sub}_${ses}_delay_vb.nii ${out_dir}${sub}_${ses}_delay_vb_WM.nii
        fslstats ${out_dir}${sub}_${ses}_delay_vb_WM.nii -m >> ${out_dir}delay_GMWMmeans.csv #mean value of WM 
    done
done

echo "Done!"