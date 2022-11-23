#!/bin/bash
#copy files from preproc and rawdata into new VB_Quantiphyse folder

path_thesis='/bcbl/home/public/PJMASK_2/preproc/derivatives/thesis'
path_raw='/bcbl/home/public/PJMASK_2/preproc/rawdata'
path_new='/bcbl/home/public/PJMASK_2/VB_Quantiphyse'


SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-005' 'sub-006' 'sub-007' 'sub-008' 'sub-009' 'sub-010')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

for SBJ in ${SBJ_LIST[@]}
do
    for SES in ${SES_LIST[@]}
    do
	
        cd ${path_thesis}/${SBJ}/${SES}/func_preproc

        if [ "$(ls -A ${path_new}/${SBJ}/${SES}/func_preproc)" ];then
            echo "Not Empty"
        else
            echo "Copy NIFTI optcom file for ${SBJ}, ${SES}"
            FILESIZE=$(stat -c%s "${path_thesis}/${SBJ}/${SES}/func_preproc/00.${SBJ}_${SES}_task-breathhold_optcom_bold_native_preprocessed.nii.gz")
            echo "--SIZE of ${SBJ}, ${SES} = $FILESIZE bytes."
            cp -f ${path_thesis}/${SBJ}/${SES}/func_preproc/00.${SBJ}_${SES}_task-breathhold_optcom_bold_native_preprocessed.nii.gz ${path_new}/${SBJ}/${SES}/func_preproc

            echo "Copy NIFTI mask file for ${SBJ}, ${SES}"
            cp -f ${path_thesis}/${SBJ}/ses-01/func_preproc/${SBJ}_ses-01_task-breathhold_rec-magnitude_echo-1_sbref_brain_mask.nii.gz ${path_new}/${SBJ}/${SES}/func_preproc

            echo "Copy PAR demean file for ${SBJ}, ${SES}"
            cp -f ${path_thesis}/${SBJ}/${SES}/func_preproc/${SBJ}_${SES}_task-breathhold_echo-1_bold_mcf_demean.par ${path_new}/${SBJ}/${SES}/func_preproc

            echo "Copy PAR deriv1 file for ${SBJ}, ${SES}"
            cp -f ${path_thesis}/${SBJ}/${SES}/func_preproc/${SBJ}_${SES}_task-breathhold_echo-1_bold_mcf_deriv1.par ${path_new}/${SBJ}/${SES}/func_preproc

            echo "Copy original CO2 file for ${SBJ}, ${SES}"
            cp -f ${path_raw}/${SBJ}/${SES}/func_phys/${SBJ}_${SES}_task-breathhold_physio_co_orig.1D ${path_new}/${SBJ}/${SES}/func_preproc

            echo "Copy CO2 peakline file for ${SBJ}, ${SES}"
            cp -f ${path_raw}/${SBJ}/${SES}/func_phys/${SBJ}_${SES}_task-breathhold_physio_co_peakline.1D ${path_new}/${SBJ}/${SES}/func_preproc
        fi

        

    done
done
