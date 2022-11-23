#!/usr/bin/env bash

######### FUNCTIONAL 01 for PJMASK
# Author:  Stefano Moia
# Version: 1.0
# Date:    31.06.2019
#########

## Variables
# functional
func=$1
# folders
fdir=$2
# discard
vdsc=${3:-0}
## Optional
# Despiking
dspk=${4:-none}
# Slicetiming
siot=${5:-none}

## Temp folder
tmp=${6:-.}

# SBREF of first echo
sbref=$7

# Echo time
echo_time=$8

### print input
printline=$( basename -- $0 )
echo "${printline} " "$@"
######################################
######### Script starts here #########
######################################

cwd=$(pwd)

cd "${fdir}" || exit

## 01. Corrections
# 01.1. Discard first volumes if there's more than one TR
if [[ "${func}"  == *nii.gz  ]]; then
	funcsource=${tmp}/${func}
else
	funcsource=${tmp}/${func}.nii.gz
fi

echo "Input file name is ${funcsource}"

nTR=$(3dinfo -nt "${funcsource}")

echo "Number of time-points is ${nTR}"

if [[ "${nTR}" -gt "1" && "${vdsc}" -gt "0" ]]
then
	echo "Discarding first ${vdsc} volumes"
	# The next line was added due to fslroi starting from 0, however it does not.
	# let vdsc--
	3dcalc -a "${funcsource}[${vdsc}..$]" -expr 'a' -prefix "${tmp}/${func}_dsd.nii.gz" -overwrite
	# fslroi ${funcsource} ${tmp}/${func}_dsd.nii.gz ${vdsc} -1
	funcsource=${tmp}/${func}_dsd.nii.gz
fi

# The following two commands were removed after a conversation between Stefano and Oscar Esteban
# # 01.2. Deoblique & resample
# echo "Deoblique and RPI orient ${func}"
# 3drefit -deoblique "${func}.nii.gz"
# 3dresample -orient RPI -inset "${func}.nii.gz" -prefix "${tmp}/${func}_RPI.nii.gz" -overwrite
# set name of source for 3dNwarpApply
funcsource=${tmp}/${func}_dsd

## TODO: Change the mask for 3dToutcount because it is using the mask of the sbref of the BH but
##       but datasets have not been aligned. We need to use a mask from the same dataset.
##		 Also, it is not necessary to compute the brain mask in all echoes, just in the 1st echo
##		 Therefore, it is better that the mask is computed from the sbref of the same dataset (1st echo) 


# 01.3. Compute outlier fraction if there's more than one TR
if [[ "${nTR}" -gt "1" ]]
then

	echo "Echo time is ${echo_time}"

	# Only continue if echo_time is 1
	if [[ "${echo_time}" -eq 1 ]]
	then

		echo "Computing outlier fraction in ${func}"
		# 3dTstat -mean -prefix "${tmp}/${func}_avg".nii.gz "${funcsource}".nii.gz
		# fslmaths ${funcsource} -Tmean ${tmp}/${func}_avg
		echo "3dSkullStrip -input ${sbref}.nii.gz -prefix ${tmp}/${func}_brain_mask_surf.nii.gz -use_skull -no_avoid_eyes -mask_vol -overwrite"

		3dSkullStrip -input "${sbref}.nii.gz" -prefix "${tmp}/${func}_brain_mask_surf.nii.gz" -use_skull -no_avoid_eyes -mask_vol -overwrite
		3dcalc -a "${tmp}/${func}_brain_mask_surf.nii.gz" -expr 'astep(a,3)' -prefix "${tmp}/${func}_brain_mask.nii.gz" -overwrite
		3dmask_tool -input "${tmp}/${func}_brain_mask.nii.gz" -prefix "${tmp}/${func}_brain_mask.nii.gz" -fill_holes -dilate_inputs -1 +1 -overwrite

		# bet ${tmp}/${func}_avg ${tmp}/${func}_brain -R -f 0.5 -g 0 -n -m
		3dToutcount -mask "${tmp}/${func}_brain_mask.nii.gz" -fraction -polort 5 -legendre "${funcsource}.nii.gz" > "${func}_outcount.1D"
	fi
fi

# 01.4. Despike if asked
if [[ "${dspk}" != "none" ]]
then
	echo "Despike ${func}"
	3dDespike -prefix "${tmp}/${func}_dsk.nii.gz" "${funcsource}.nii.gz" -overwrite
	funcsource=${tmp}/${func}_dsk
fi

## 02. Slice timing interpolation if asked
if [[ "${siot}" != "none" ]]
then
	echo "Slice timing interpolation of ${func}"
	3dTshift -Fourier -prefix "${tmp}/${func}_si.nii.gz" -tpattern "${siot}" -overwrite "${funcsource}.nii.gz" -overwrite
	funcsource=${tmp}/${func}_si
fi

## 03. Change name to script output
3dcalc -a "${funcsource}.nii.gz" -expr 'a' -prefix "${tmp}/${func}_cr.nii.gz" -overwrite

cd ${cwd}
