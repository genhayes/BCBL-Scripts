#!/bin/bash
#MEICA preprocessing script

module load afni/latest

path_thesis='/bcbl/home/public/PJMASK_2/preproc/derivatives/thesis'
path_raw='/bcbl/home/public/PJMASK_2/preproc/rawdata'
path_new='/bcbl/home/public/PJMASK_2/VB_Quantiphyse/Data'
path_matrices='/bcbl/home/public/PJMASK_2/preproc/derivatives/thesis/analyses/CVR'


SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-005' 'sub-006' 'sub-007' 'sub-008' 'sub-009' 'sub-010')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

for SBJ in ${SBJ_LIST[@]}
do
    for SES in ${SES_LIST[@]}
    do

        cd ${path_new}/${SBJ}/${SES}/func_preproc
        if [[ ! -f "task-breathhold_meica-cons_bold_native_preprocessed.dt.nii.gz" ]]; then

            echo "ANFI nuissance regression for ${SBJ} ${SES}"
            3dTproject -overwrite -input task-breathhold_optcom_bold_native_preprocessed.nii.gz \
                -mask task-breathhold_rec-magnitude_echo-1_sbref_brain_mask.nii.gz \
                -ort  ${path_matrices}/${SBJ}_${SES}_meica-cons_mat/mat_0360.1D[0..4,6..$] \
                -prefix task-breathhold_meica-cons_bold_native_preprocessed.dt.nii.gz

            3dTstat -mean -prefix rm.mean.nii.gz \
                task-breathhold_optcom_bold_native_preprocessed.nii.gz -overwrite

            3dcalc -a task-breathhold_meica-cons_bold_native_preprocessed.dt.nii.gz \
                -b rm.mean.nii.gz -m task-breathhold_rec-magnitude_echo-1_sbref_brain_mask.nii.gz \
                -expr 'm*(a+b)' \
                -prefix task-breathhold_meica-cons_bold_native_preprocessed.dt.nii.gz -overwrite

            rm rm.mean.nii.gz
        fi

    done
done
