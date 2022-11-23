#!/bin/bash
#copy files from preproc and rawdata into new VB_Quantiphyse folder

module load afni/latest

path_thesis='/bcbl/home/public/PJMASK_2/preproc/derivatives/thesis'
path_raw='/bcbl/home/public/PJMASK_2/preproc/rawdata'
path_new='/bcbl/home/public/PJMASK_2/VB_Quantiphyse'
path_decomp='/bcbl/home/public/PJMASK_2/preproc/derivatives/thesis/analyses/decomp'


SBJ_LIST=('sub-007') #'sub-002' 'sub-003' 'sub-004' 'sub-005' 'sub-006' 'sub-007' 'sub-008' 'sub-009' 'sub-010')
SES_LIST=('ses-01') #'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

POLORT_ORDER=4

for SBJ in ${SBJ_LIST[@]}
do
    for SES in ${SES_LIST[@]}
    do

        cd ${path_new}/${SBJ}/${SES}/func_preproc
        if [[ ! -f "00.${SBJ}_${SES}_task-breathhold_REJ_bold_native_preprocessed.dt.nii.gz" ]]; then

            echo "ANFI nuissance regression for ${SBJ} ${SES}"
            3dTproject -overwrite -input 00.${SBJ}_${SES}_task-breathhold_optcom_bold_native_preprocessed.nii.gz \
                -mask ${SBJ}_ses-01_task-breathhold_rec-magnitude_echo-1_sbref_brain_mask.nii.gz \
                -ort ${SBJ}_${SES}_task-breathhold_echo-1_bold_mcf_demean.par \
                -ort ${SBJ}_${SES}_task-breathhold_echo-1_bold_mcf_deriv1.par \
                -ort ${path_decomp}/${SBJ}_${SES}_rejected.1D \
                -polort ${POLORT_ORDER} \
                -prefix 00.${SBJ}_${SES}_task-breathhold_REJ_bold_native_preprocessed.dt.nii.gz

            3dTstat -mean -prefix rm.mean.nii.gz \
                00.${SBJ}_${SES}_task-breathhold_optcom_bold_native_preprocessed.nii.gz -overwrite

            3dcalc -a 00.${SBJ}_${SES}_task-breathhold_REJ_bold_native_preprocessed.dt.nii.gz \
                -b rm.mean.nii.gz -m ${SBJ}_ses-01_task-breathhold_rec-magnitude_echo-1_sbref_brain_mask.nii.gz \
                -expr 'm*(a+b)' \
                -prefix 00.${SBJ}_${SES}_task-breathhold_REJ_bold_native_preprocessed.dt.nii.gz -overwrite

            rm rm.mean.nii.gz
        fi

    done
done