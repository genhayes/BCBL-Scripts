#! /bin/bash
# This script warps the lGLM and vb CVR maps to the MNI space using ants for all subjects and sessions
module load ants/latest
prj_dir025=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/025_links_to_all_maps/
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/
thesis_dir=/export/home/ghayes/public/PJMASK_2/preproc/derivatives/thesis/
mask_path=${thesis_dir}sub-001/ses-01/reg/MNI152_T1_1mm_brain_resamp_2.5mm.nii.gz 
out_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/025_MNI_maps_postprocessed

mkdir -p $out_dir

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

# Define transform variables
Interp_cvr='NearestNeighbor' #NearestNeighbor, Linear, Gaussian, MultiLabel, BSpline, CosineWindowedSinc, WelchWindowedSinc, HammingWindowedSinc, LanczosWindowedSinc, GenericLabel, GenericContinuous
Interp_delay='NearestNeighbor' #NearestNeighbor, Linear, Gaussian, MultiLabel, BSpline, CosineWindowedSinc, WelchWindowedSinc, HammingWindowedSinc, LanczosWindowedSinc, GenericLabel, GenericContinuous

# Create lightbox png of vb, lGLM CVR and delay map for each subject and each session
for sub in "${SBJ_LIST[@]}"
do
    for ses in "${SES_LIST[@]}"
    do
        echo "Transforming maps of session ${sub} ${ses} to MNI"
        antsApplyTransforms -d 3 -i ${prj_dir025}${sub}_${ses}_cvr1_lGLM.nii -r ${thesis_dir}sub-001/ses-01/reg/MNI152_T1_1mm_brain_resamp_2.5mm.nii.gz \
            -o ${out_dir}/std_lGLM_${sub}_${ses}.nii.gz -n ${Interp_cvr} \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_acq-uni_T1w2std1Warp.nii.gz \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_acq-uni_T1w2std0GenericAffine.mat \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_T2w2${sub-008}_ses-01_acq-uni_T1w0GenericAffine.mat \
            -t [${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_T2w2${sub}_sbref0GenericAffine.mat,1]

        antsApplyTransforms -d 3 -i ${prj_dir}${sub}_${ses}_cvr1_vb.nii -r ${thesis_dir}sub-001/ses-01/reg/MNI152_T1_1mm_brain_resamp_2.5mm.nii.gz \
            -o ${out_dir}/std_vb_${sub}_${ses}.nii.gz -n ${Interp_cvr} \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_acq-uni_T1w2std1Warp.nii.gz \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_acq-uni_T1w2std0GenericAffine.mat \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_T2w2${sub-008}_ses-01_acq-uni_T1w0GenericAffine.mat \
            -t [${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_T2w2${sub}_sbref0GenericAffine.mat,1]

        antsApplyTransforms -d 3 -i ${prj_dir025}${sub}_${ses}_delay_lGLM.nii -r ${thesis_dir}sub-001/ses-01/reg/MNI152_T1_1mm_brain_resamp_2.5mm.nii.gz \
            -o ${out_dir}/std_delay_lGLM_${sub}_${ses}.nii.gz -n ${Interp_delay} \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_acq-uni_T1w2std1Warp.nii.gz \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_acq-uni_T1w2std0GenericAffine.mat \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_T2w2${sub-008}_ses-01_acq-uni_T1w0GenericAffine.mat \
            -t [${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_T2w2${sub}_sbref0GenericAffine.mat,1]

        antsApplyTransforms -d 3 -i ${prj_dir}${sub}_${ses}_delay_vb.nii -r ${thesis_dir}sub-001/ses-01/reg/MNI152_T1_1mm_brain_resamp_2.5mm.nii.gz \
            -o ${out_dir}/std_delay_vb_${sub}_${ses}.nii.gz -n ${Interp_delay} \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_acq-uni_T1w2std1Warp.nii.gz \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_acq-uni_T1w2std0GenericAffine.mat \
            -t ${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_T2w2${sub-008}_ses-01_acq-uni_T1w0GenericAffine.mat \
            -t [${thesis_dir}${sub}/${ses}/reg/${sub}_ses-01_T2w2${sub}_sbref0GenericAffine.mat,1]
    done
done

echo "Done Transforming!"
