#!bin/bash
PRJDIR="/bcbl/home/public/PJMASK_2/VB_Quantiphyse/PRESURGICAL_BH"

# SUBJECTS_LIST=("sub-001" "sub-002" "sub-003" "sub-004" "sub-005" "sub-006" "sub-007" "sub-008" "sub-009" "sub-010")
# SESSIONS_LIST=("02" "03" "04" "05" "06" "07" "08" "09" "10" "11")
# BIDS_DIR="/bcbl/home/public/PJMASK_2/preproc/rawdata"
# SUBJECTS_LIST=( $(find ${BIDS_DIR} -maxdepth 1 -name "sub*"| cut -sd / -f 8-) )
module load freesurfer/7.2.0
module load afni/latest
module load python/venv

SCRIPTSDIR=/bcbl/home/public/PJMASK_2/VB_Quantiphyse/Scripts

script=${SCRIPTSDIR}/full_preproc.sh
vdsc=10
step=2

std=MNI152_2009_template.nii.gz
mmres=1
fwhm=2
polort=5

TEs="10.6 28.69 46.78 64.87"
# -> Answer to the Ultimate Question of Life, the Universe, and Everything.
nTE=4

# slice order file (full path to)
siot=none
# siot=${wdr}/sliceorder.txt
# Despiking
dspk=none
task=BH

set -e

for SUBJ in  JH 
do
    for SES in 1 # "${SESSIONS_LIST[@]}";
    do
        for RUN in 1
        do

            adir="${PRJDIR}/sub-${SUBJ}/ses-${SES}/anat"   
            anat="sub-${SUBJ}_ses-${SES}_run-${RUN} _T1w.nii.gz"
            unidir="${PRJDIR}/sub-${SUBJ}/ses-${SES}/anat"
            aseg="sub-${SUBJ}_ses-${SES}_run-${RUN} _T1w.nii.gz"
            fdir="${PRJDIR}/sub-${SUBJ}/ses-${SES}/func_preproc"

            # qsub -q long.q -N "${SUBJ}-${SES}" \
            #     -o ${PRJDIR}/LogFiles/Preproc_sub-${SUBJ}_ses-${SES}_run-${RUN}_task-${task} \
            #     -e ${PRJDIR}/LogFiles/Preproc_sub-${SUBJ}_ses-${SES}_run-${RUN}_task-${task} \
                ${script} ${SUBJ} ${SES} ${RUN}  ${PRJDIR} ${task} \
                "${adir}"/"${anat}" "${uni_adir}"/"${aseg}" \
                "${fdir}" "${vdsc}" "${TEs}" "${nTE}" \
                "${siot}" "${dspk}" \
                "${SCRIPTSDIR}" "${step}" \
                "${fwhm}" "${polort}" "${std}" "${mmres}"

        done
		 
    done

done 
