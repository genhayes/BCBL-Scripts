#!/usr/bin/env bash
module load afni/latest

model='vb' #lGLM

MNI_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed
mask_path=/export/home/ghayes/public/PJMASK_2/preproc/derivatives/thesis/sub-001/ses-01/reg/MNI152_T1_1mm_brain_mask.nii.gz

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

echo "Starting LME analysis for ${model}"

for inmap in cvr delay
do
	# Compute ICC
	rm ../ICC2_${inmap}_${model}.nii.gz

	run3dICC="3dICC -prefix ${MNI_dir}/ICC2_${inmap}_${model}.nii.gz -jobs 10"
	run3dICC="${run3dICC} -mask ${mask_path}"
	run3dICC="${run3dICC} -model  '1+(1|session)+(1|Subj)'"
		run3dICC="${run3dICC} -dataTable"
		run3dICC="${run3dICC}      Subj session    InputFile            "
		for sub in "${SBJ_LIST[@]}"
		do
			for ses in "${SES_LIST[@]}"
			do
				run3dICC="${run3dICC}      ${sub}  ${ses}  ${MNI_dir}/std_${inmap}_${model}_${sub}_${ses}.nii.gz"
			done
		done
		echo ""
		echo "${run3dICC}"
		echo ""
		eval "${run3dICC}"
done

echo "End of ICC analysis script! :)!"