#!/bin/bash
#$ -cwd
#$ -o out.txt
#$ -e err.txt
#$ -m be
#$ -M narayanansweekriti@gmail.com
#$ -N Full_PREPROC
#$ -S /bin/bash
#$ -q long.q
######### FULL RESTING STATE PREPROC for EuskalIBUR
# Author:  Eneko
# Version: 1.0
# Date:    20.04.2022
#########
# 001 01 /bcbl/home/public/PJMASK_2/connPFM_data 2
# sub=001; ses=01; wdr=/bcbl/home/public/PJMASK_2/connPFM_data; step=2
####
# TODO:
# There are unused variables from legacy.

module unload python
module load python/venv
# module load python/python3.6
module load freesurfer/7.2.0
module load afni/latest
module load fsl/6.0.3

source activate /bcbl/home/public/PJMASK_2/connPFM_data/conda_env/tedana

sub=$1
ses=$2

wdr=${3:-/data}

scripts=${4:-wdr/scripts}
orig_dir=/bcbl/home/public/PJMASK_2/preproc/rawdata/sub-${sub}/ses-${ses}
step=${5:-1}
overwrite="overwrite"

run_anat=${5:-false}
run_sbref=${6:-false}

tmp=${7:-/tmp}
tmp=${wdr}/tmp

flpr=sub-${sub}_ses-${ses}

anat1=${flpr}_acq-uni_T1w 
anat2=${flpr}_T2w

adir=${wdr}/sub-${sub}/ses-${ses}/anat_preproc
fdir=${wdr}/sub-${sub}/ses-${ses}/func_preproc
fmap=${wdr}/sub-${sub}/ses-${ses}/fmap_preproc
stdp=${scripts}/90.template

run_folders=false
run_anat=false
run_task=true


vdsc=10
std=MNI152_2009_template.nii.gz
mmres=1
fwhm=2
polort=5

TEs="10.6 28.69 46.78 64.87 82.96"
# -> Answer to the Ultimate Question of Life, the Universe, and Everything.
nTE=5

# slice order file (full path to)
siot=none
# siot=${wdr}/sliceorder.txt

# Despiking
dspk=none

first_ses_path=${wdr}/sub-${sub}/ses-01

uni_sbref=${first_ses_path}/reg/sub-${sub}_sbref
uni_adir=${first_ses_path}/anat_preproc

######################################

######################################
######### Script starts here #########
######################################

# Preparing log folder and log file, removing the previous one
if [[ ! -d "${wdr}/log" ]]; then mkdir "${wdr}"/log; fi
if [[ -e "${wdr}/log/${flpr}_log" ]]; then rm "${wdr}"/log/"${flpr}"_preproc_log; fi

echo "************************************" >> "${wdr}"/log/"${flpr}"_preproc_log

exec 3>&1 4>&2

exec 1>"${wdr}"/log/"${flpr}"_log 2>&1

date
echo "************************************"


######################################
#########   Prepare folders  #########
######################################
if [[ "${run_folders}" == "true" ]]
then
	"${scripts}"/prepare_folder.sh "${sub}" "${ses}" "${wdr}" ${overwrite} \
					"${anat1}" "${anat2}" "${stdp}" ${std} "${orig_dir}"
fi


##############################################################
#########    Task and resting-state preprocessing    #########
##############################################################

if [[ "${run_task}" == "true" ]]
then
	aseg=sub-${sub}_ses-01_T1
	anat=sub-${sub}_ses-${ses}_T2w

	"${scripts}"/00.pipelines/full_preproc.sh "${sub}" "${ses}" "${wdr}" "${adir}"/"${anat}" "${uni_adir}"/"${aseg}" \
		"${fdir}" "${vdsc}" "${TEs}" \
		"${nTE}" "${siot}" "${dspk}" \
		"${scripts}" "${tmp}" "${step}" "${std}" \
		"${mmres}" "${fwhm}" "${polort}"

fi

date
echo "************************************"
echo "************************************"
echo "***      Preproc COMPLETE!       ***"
echo "************************************"
echo "************************************"