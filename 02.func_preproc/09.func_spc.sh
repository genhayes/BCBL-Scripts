#!/usr/bin/env bash

######### FUNCTIONAL 04 for PJMASK
# Author:  Stefano Moia
# Version: 1.0
# Date:    31.06.2019
#########

## Variables
# file
func_in=$1
# folders
fdir=$2
# mask
mask=$3
# Temp folder
tmp=${4:-.}
# out name
func_out=$5


### print input
printline=$( basename -- $0 )
echo "${printline} " "$@"
######################################
######### Script starts here #########
######################################

cwd=$(pwd)

cd ${fdir} || exit

# 00. Mean
echo "Computing mean"
3dTstat -mean -overwrite -prefix ${fdir}/${func_in}_mean.nii.gz ${tmp}/${func_in}.nii.gz -overwrite

# 01. SPC
echo "Computing SPC of ${func_in} ( [x-mean(x)]/mean(x) )"
3dcalc -a ${tmp}/${func_in}.nii.gz -b ${fdir}/${func_in}_mean.nii.gz -m ${mask}.nii.gz -expr 'm*(a-b)/b' -prefix ${fdir}/${func_out}.nii.gz -overwrite

cd ${cwd}