#!/usr/bin/env bash

######### FUNCTIONAL 02 for PJMASK
# Author:  Stefano Moia
# Version: 1.0
# Date:    31.06.2019
#########

## Variables
# functional
func_in=$1
# folders
fdir=$2
# discard
# vdsc=$3
## Optional

# Motion reference file
mref=${3:-none}

## Temp folder
tmp=${4:-.}

## Whether to apply motion correction
apply_mc=${5:-no}

## Number of TE
nTE=${6:-1}

### print input
# printline=$( basename -- $0 )
# echo "${printline} " "$@"
######################################
######### Script starts here #########
######################################

cwd=$(pwd)

cd "${fdir}" || exit

echo "${tmp}"/"${func_in}"
echo $(3dinfo -nt "${tmp}"/"${func_in}")
nTR=$(3dinfo -nt "${tmp}"/"${func_in}")
let nTR--
echo "TRs: ${nTR}"

if [[ "${func_in}"  == *nii.gz  ]]; then
	func=${func_in::-7}
elif [[ "${func_in}"  == *nii ]]; then
	func=${func_in::-4}
else
	func=${func_in}
	func_in=${func_in}.nii.gz
fi

if [[ "${mref}"  == *nii.gz  ]]; then
	mref=${mref}
else
	mref=${mref}.nii.gz
fi

## 01. Motion Computation, if more than 1 volume

if [[ nTR -gt 1 ]]
then

	if [[ "${mref}" == "none" ]]
	then
		echo "Creating a reference for ${func}"
		mref=${func}_avgref
		3dTstat -mean -prefix "${mref}" "${tmp}"/"${func_in}" -overwrite
		# fslmaths ${tmp}/${func_in} -Tmean ${mref}
	fi

	echo "Head motion realignement ${func} to ${mref}"
	if [[ -d ${tmp}/${func}_mcf.mat ]]; then rm -r "${tmp}/${func}_mcf.mat"; fi
	echo "3dvolreg -overwrite -Fourier -base ${mref} -1Dfile ${tmp}/${func}_mcf.1D -1Dmatrix_save ${tmp}/${func}_mcf.aff12.1D -prefix ${tmp}/${func}_mcf.nii.gz ${tmp}/${func_in}"
	3dvolreg -overwrite -Fourier -base "${mref}" -1Dfile "${tmp}/${func}_mcf.1D" -1Dmatrix_save "${tmp}/${func}_mcf.aff12.1D" -prefix "${tmp}/${func}_mcf.nii.gz" "${tmp}"/"${func_in}"
	# mcflirt -in ${tmp}/${func_in} -r ${mref} -out ${tmp}/${func}_mcf -stats -mats -plots

	# 01.2. Demean motion parameters
	echo "Demean and derivate ${func} motion parameters"
	1d_tool.py -infile "${tmp}/${func}_mcf.1D" -demean -write "${func}_mcf_demean.1D" -overwrite
	1d_tool.py -infile "${func}_mcf_demean.1D" -derivative -demean -write "${func}_mcf_deriv1.1D" -overwrite

	# 01.3. Compute various metrics
	echo "Computing DVARS and FD for ${func}"
	fsl_motion_outliers -i "${tmp}"/"${func}"_mcf -o "${tmp}"/"${func}"_mcf_dvars_confounds -s "${func}"_dvars_post.par -p "${func}"_dvars_post --dvars --nomoco
	fsl_motion_outliers -i "${tmp}"/"${func_in}" -o "${tmp}"/"${func}"_mcf_dvars_confounds -s "${func}"_dvars_pre.par -p "${func}"_dvars_pre --dvars --nomoco
	fsl_motion_outliers -i "${tmp}"/"${func_in}" -o "${tmp}"/"${func}"_mcf_fd_confounds -s "${func}"_fd.par -p "${func}"_fd --fd
	1d_tool.py -infile "${tmp}/${func}_mcf.1D"  -derivative -collapse_cols euclidean_norm -write "${tmp}/${func}_mcf_enorm.1D" 
fi

## 02. Motion Correction, if apply_mc is yes
if [[ "${apply_mc}" == "yes" ]]
then
	file_root="${func%_echo-1*}"
	file_tail="${func#*_echo-1}"
	echo "Applying motion correction to ${func}"
	for e in $( seq 1 "${nTE}" )
	do
		func_in="${file_root}_echo-${e}${file_tail}.nii.gz"
		3dAllineate -overwrite -base "${mref}" -final 'cubic' -1Dmatrix_apply "${tmp}/${func}_mcf.aff12.1D" -prefix "${tmp}/${file_root}_echo-${e}_bold_mcf_al.nii.gz" "${tmp}"/"${func_in}"
	done
fi

cd "${cwd}" || exit
