#!/usr/bin/env bash
module load afni/latest

MNI_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/025_MNI_maps_postprocessed
#mask_path=/export/home/ghayes/public/PJMASK_2/preproc/derivatives/thesis/sub-001/ses-01/reg/MNI152_T1_1mm_brain_mask.nii.gz
thesis_dir=/export/home/ghayes/public/PJMASK_2/preproc/derivatives/thesis/
mask_path=${thesis_dir}sub-001/ses-01/reg/MNI152_T1_1mm_brain_resamp_2.5mm.nii.gz 

echo "Mask path: ${mask_path}"

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

echo "Starting LME analysis"

for inmap in cvr delay
do
	# Compute LMEr
	rm ../LMEr_${inmap}.nii.gz

	run3dLMEr="3dLMEr -prefix ${MNI_dir}/LMEr_${inmap}.nii.gz -jobs 10"
	run3dLMEr="${run3dLMEr} -mask ${mask_path}"
	run3dLMEr="${run3dLMEr} -model  'model+(1|session)+(1|subject)'"

	run3dLMEr="${run3dLMEr} -gltCode lGLM_vs_vb  'model : 1*lGLM -1*vb'"

	run3dLMEr="${run3dLMEr} -dataTable                                                     "
	run3dLMEr="${run3dLMEr}       subject session  model       InputFile                        "
	for sub in "${SBJ_LIST[@]}"
	do
		for ses in "${SES_LIST[@]}"
		do
			for model in lGLM vb
			do
				run3dLMEr="${run3dLMEr}       ${sub}  ${ses}       ${model}      ${MNI_dir}/std_${inmap}_${model}_${sub}_${ses}.nii.gz"
			done
		done
	done
	echo ""
	echo "${run3dLMEr}"
	echo ""
	eval ${run3dLMEr}
done

echo "End of LME analysis script, woohoo!"
