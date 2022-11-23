#!/usr/bin/env bash

######### FUNCTIONAL 04 for PJMASK
# Author:  Eneko Uruñuela
# Version: 1.0
# Date:    10.2021
#########

## Variables
# functional
func_in=$1
# folders
fdir=$2
# Polort
polort=${3:-4}
# mask
mask=$4
## Temp folder
tmp=${5:-.}
# out name
func_out=$6

### print input
printline=$( basename -- "$0" )
echo "${printline} " "$@"
######################################
######### Script starts here #########
######################################

cwd=$(pwd)

cd "${fdir}" || exit

## 00. Mean
3dTstat -mean -overwrite -prefix "${tmp}"/"${func_out}"_mean.nii.gz "${tmp}"/"${func_in}".nii.gz -overwrite

## 01. Detrend
echo "Detrending ${func_out}"
3dTproject -input "${tmp}"/"${func_in}".nii.gz -prefix "${tmp}"/"${func_out}".nii.gz \
    -mask "${mask}".nii.gz -polort "${polort}" -overwrite

## 02. Add back mean
3dcalc -a "${tmp}"/"${func_out}".nii.gz -b "${tmp}"/"${func_out}"_mean.nii.gz -m "${mask}".nii.gz -expr 'm*(a+b)' \
    -prefix "${tmp}"/"${func_out}".nii.gz -overwrite

## 0.3. Remove mean to save space
rm -rf "${tmp}"/"${func_out}"_mean.nii.gz

cd "${cwd}" || exit