#!/usr/bin/env bash

######### FUNCTIONAL 03 for PJMASK
# Author:  Stefano Moia
# Version: 1.0
# Date:    31.06.2019
#########

## Variables
# functional
func_in=$1
# folders
fdir=$2
# echo times
TEs=$3

# Temp folder
tmp=${4:-.}

## Step number
step=${5:-1}

## TODO: Make that the mask is given as input. If none, then use the brain_mask of the first echo

### print input
printline=$( basename -- "$0" )
echo "${printline} " "$@"
######################################
######### Script starts here #########
######################################

cwd=$(pwd)

cd "${fdir}" || exit

#Read and process input
func="${func_in%_echo-*}"

## 01. MEICA
# Run tedana

mkdir "${tmp}"/"${func}"_meica

echo "Running tedana"

source activate /export/home/eurunuela/eurunuela/conda_envs/tedana

echo "${TEs}"

# If step 1, run tedana
if [[ "${step}" == "1" ]]; then
    tedana -d "${tmp}"/"${func}"_echo-1_bold_mcf_al.nii.gz "${tmp}"/"${func}"_echo-2_bold_mcf_al.nii.gz "${tmp}"/"${func}"_echo-3_bold_mcf_al.nii.gz "${tmp}"/"${func}"_echo-4_bold_mcf_al.nii.gz -e 10.6 28.69 46.78 64.87 --mask "${tmp}"/"${func}"_echo-1_bold_brain_mask.nii.gz --tedpca aic --out-dir "${tmp}"/"${func}"_meica --verbose
    echo "Creating backup"
    tar -cvf ../"$(date +%Y%m%d-%H%M%S)${func}"_meica_bck.tar.gz "${tmp}"/"${func}"_meica/desc-ICA_mixing.tsv "${tmp}"/"${func}"_meica/desc-ICA_decomposition.json
elif [[ "${step}" == "2" ]]; then
    tedana -d "${tmp}"/"${func}"_echo-1_bold_mcf_al.nii.gz "${tmp}"/"${func}"_echo-2_bold_mcf_al.nii.gz "${tmp}"/"${func}"_echo-3_bold_mcf_al.nii.gz "${tmp}"/"${func}"_echo-4_bold_mcf_al.nii.gz -e 10.6 28.69 46.78 64.87 --mask "${tmp}"/"${func}"_echo-1_bold_brain_mask.nii.gz --ctab "${tmp}"/"${func}"_meica/manual_classification.tsv --mix "${tmp}"/"${func}"_meica/desc-ICA_mixing.tsv --out-dir "${tmp}"/"${func}"_meica_manual --verbose
fi

cd "${cwd}" || exit