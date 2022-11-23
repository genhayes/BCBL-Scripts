#!/usr/bin/env bash

######### Task preproc for DenseMappingfMRI
# Author:  Eneko Uruñuela
# Version: 1.0
# Date:    20.05.2022
#########


sub=$1
ses=$2
run=$3
wdr=$4
task=$5

flpr=sub-${sub}_ses-${ses}

anat=${6:-none}
aseg=${7:-none}

fdir=$8

vdsc=$9

TEs=${10}
nTE=${11}

siot=${12} # DO SLICE TIMING CORRECTION?  

dspk=${13} # DO DESPIKING

scriptdir=${14}
echo "This is the scripts folder: ${scriptdir}" 
# scriptdir=${wdr}/scripts
# scriptdir=${scripts}

tmp=${wdr}/sub-${sub}/ses-${ses}/tmp/task-${task}

step=${15:-1}
fwhm=${16:-0}
polort=${17:-0}

anat_mni=${18:-false}
vox_res=${19:-none}

# This is the absolute sbref. Don't change it.
fdir_no_preproc=${wdr}/sub-${sub}/ses-${ses}/func
# sbrf=${wdr}/sub-${sub}/ses-${ses}/reg/sub-${sub}_sbref
sbrf=${fdir_no_preproc}/${flpr}_task-${task}_run-${run}_echo-1_sbref
mask=${sbrf}_brain_mask

# fmap=${wdr}/sub-${sub}/ses-${ses}/fmap_preproc
# bfor=${fmap}/${flpr}_acq-breathhold_dir-PA_epi
# brev=${fmap}/${flpr}_acq-breathhold_dir-AP_epi


### print input
printline=$( basename -- "$0" )
echo "${printline} " "$@"
######################################
#########    Task preproc    #########
######################################

# Start making the tmp folder
mkdir -p "${tmp}"

set -e

# If step is 1, then do until tedana (included)
if [ "${step}" -eq 1 ]; then

	for e in $( seq 1 "${nTE}" )
	do
		echo "************************************"
		echo "*** Copy ${task} BOLD echo ${e} ****"
		echo "************************************"
		echo "************************************"

		echo "${flpr}_task-${task}_run-${run}_echo-${e}_bold"
		bold=${flpr}_task-${task}_run-${run}_echo-${e}_bold

		echo "Copy raw dataset ${bold}.nii.gz  to ${tmp}"
		echo "3dcalc -a ${wdr}/sub-${sub}/ses-${ses}/func/${bold}.nii.gz -expr 'a' -prefix ${tmp}/${bold}.nii.gz -overwrite"
		3dcalc -a "${wdr}"/sub-"${sub}"/ses-"${ses}"/func/"${bold}".nii.gz -expr 'a' -prefix "${tmp}"/"${bold}".nii.gz -overwrite

		if [ ! -e "${tmp}"/"${bold}".nii.gz ]
		then
			echo "Something went wrong with the copy"
			# exit
		else
			echo "File copied, start preprocessing"
		fi

		echo "************************************"
		echo "*** Func correct ${task} BOLD echo ${e}"
		echo "************************************"
		echo "************************************"

		sh "${scriptdir}"/02.func_preproc/01.func_correct.sh "${bold}" "${fdir}" "${vdsc}" "${dspk}" "${siot}" "${tmp}" "${sbrf}" "${e}"

	done

	echo "************************************"
	echo "*** Func spacecomp ${task} echo 1 **"
	echo "************************************"
	echo "************************************"

	echo "fmat=${flpr}_task-${task}_run-${run}_echo-1_bold_cr"
	fmat=${flpr}_task-${task}_run-${run}_echo-1_bold_cr

# #	sh "${scriptdir}"/02.func_preproc/03.func_generate_mask.sh "${fdir}" "${sbrf}" # SBRF of first echo only
	# sh "${scriptdir}"/02.func_preproc/04.motion_realign.sh "${fmat}.nii.gz" "${fdir}" "${sbrf}" "${tmp}" "yes" "${nTE}" # With first echo

	echo "************************************"
	echo "************ Tedana ${task} ********"
	echo "************************************"
	echo "************************************"
	sh "${scriptdir}"/02.func_preproc/10.func_meica.sh "${fmat}_mcf_al.nii.gz" "${fdir}" "${TEs}" "${tmp}" "${step}"


elif [ "${step}" -eq 2 ]; then

	echo "************************************"
	echo "************ Tedana ${task} ********"
	echo "************************************"
	echo "************************************"
	echo "fmat=${flpr}_task-${task}_run-${run}_echo-1_bold"
	fmat=${flpr}_task-${task}_run-${run}_echo-1_bold
	# sh "${scriptdir}"/02.func_preproc/10.func_meica.sh "${fmat}_mcf_al.nii.gz" "${fdir}" "${TEs}" "${tmp}" "${step}"

	# echo "***********************************************************"
	# echo "*** Compute warping for geometric distortion correction ***"
	# echo "***********************************************************"
	# echo "***********************************************************"
	# sh "${scriptdir}"/02.func_preproc/02.func_blip_updown.sh "${brev}" "${bfor}" "${fdir}"

	# for e in $( seq 1 "${nTE}" )
	# do
	# 	echo "***********************************************************"
	# 	echo "*** Apply warping for geometric distortion correction ***"
	# 	echo "***********************************************************"
	# 	# echo "**** First, on BOLD data ${bold} ****" # We don't apply geometric distortion correction on BOLD data. It'll be applied in a single spatial transformation 
	# 	# sh "${scriptdir}"/02.func_preproc/02b.func_apply_blip_updown.sh "${tmp}/${bold}_cr" "${tmp}/${bold}_blip" "${bfor}"+orig "${fdir}"	
	# 	sbrf_echo=${fdir_no_preproc}/${flpr}_task-breathhold_rec-magnitude_echo-${e}_sbref
	# 	echo "**** On the corresponding SBRef ${sbrf_echo} ****"
	# 	sh "${scriptdir}"/02.func_preproc/02b.func_apply_blip_updown.sh "${sbrf_echo}" "${sbrf_echo}_blip" "${fmap}"/"${flpr}"_acq-breathhold_dir-PA_epi+orig "${fdir}"
	# done

	# echo "***************************************************"
	# echo "** Coregistration of ${anat} to ${sbrf##*/}_blip **"
	# echo "***************************************************"
	# echo "***************************************************"
	# sh "${scriptdir}"/02.func_preproc/05.func_alignto_anat.sh "${fdir}" "${anat}" "${sbrf##*/}_blip" "${tmp}"

	# # Align T1 to T2
	# # Extract everything except the last slash from anat
	# echo "**************************************"
	# echo "** Coregistration of ${anat} to T1w **"
	# echo "**************************************"
	# echo "**************************************"
	# adir=${anat%/*}
	# echo "anat_no_slash=${adir}"
	# sh "${scriptdir}"/02.func_preproc/06.align_T1toT2.sh "${adir}" "${anat##*/}" "${aseg}"
	
	# for e in optcom # $( seq 1 "${nTE}" )
	# do
	# 	echo "************************************"
	# 	echo "*** Applying transformations *******"
	# 	echo "************************************"
	# 	echo "************************************"
    #     if [ "${e}" == "optcom" ]; then
	# 		echo "fmat=sub-${sub}_ses-${ses}_task-${task}_meica_manual/desc-optcomDenoised_bold.nii.gz"
	# 	    fmat=sub-${sub}_ses-${ses}_task-${task}_meica_manual/desc-optcomDenoised_bold.nii.gz
    #     else
    #         echo "fmat=sub-${sub}_ses-${ses}_task-${task}_meica_manual/echo-${e}_desc-Denoised_bold.nii.gz"
	# 	    fmat=sub-${sub}_ses-${ses}_task-${task}_meica_manual/echo-${e}_desc-Denoised_bold.nii.gz
    #     fi 
    #     sh "${scriptdir}"/02.func_preproc/07.func_nwarp_apply_to_echos.sh "${fmat}" "${sub}" "${ses}" "${fdir}" \
    #         "${tmp}" "${anat_mni}" "${e}" "${task}" "${vox_res}" "${wdr}"
	# done

	# Copy tedana results to main folder
	echo "************************************"
	echo "*** Copying tedana results *********"
	echo "************************************"

	cp "${tmp}"/"${flpr}"_task-"${task}"_run-"${run}"_meica_manual/desc-optcomDenoised_bold.nii.gz "${tmp}"/"${flpr}"_task-"${task}"_run-"${run}"_optcomDenoised_bold.nii.gz
	mask_rm="${flpr}"_task-"${task}"_run-"${run}"_echo-1_bold_brain_mask
	bold_rm="${flpr}"_task-"${task}"_run-"${run}"_optcomDenoised_bold

	# As it's ${task}, only skip denoising (but create matrix nonetheless)!
	for e in optcom # $( seq 1 "${nTE}" )
	do

		if [ "${e}" != "optcom" ]; then
  			te="e${e}"
		else
			te="${e}"
		fi
		# bold_rm=rm.epi.nomask.${te}
		# mask_rm=rm.mask.${te}
		if [ "${e}" != "optcom" ]; then
			te=echo-${e}
		fi
		echo "bold=${flpr}_task-${task}_${te}_bold"
		bold=${flpr}_task-${task}_${te}_bold
		echo "mask=${flpr}_task-${task}_${te}_mask"
		mask=${flpr}_task-${task}_${te}_mask
		3dcopy -overwrite "${tmp}"/"${mask_rm}".nii.gz "${fdir}"/"${mask}".nii.gz

		# if [ "${fwhm}" -gt 0 ]; then
		# 	echo "***************************************************"
		# 	echo "*** Func smoothing ${task} BOLD ${e}"
		# 	echo "***************************************************"
		# 	echo "***************************************************"
		# 	sh "${scriptdir}"/02.func_preproc/08b.func_smooth.sh "${bold_rm}" "${fdir}" "${fwhm}" "${mask}" "${tmp}" "${bold}"_sm
		# 	bold_rm=${bold}_sm
		# fi

		if [ "${polort}" -gt 0 ]; then
			echo "***************************************************"
			echo "*** Func detrending ${task} BOLD ${e}"
			echo "***************************************************"
			echo "***************************************************"
			sh "${scriptdir}"/02.func_preproc/08c.func_detrend.sh "${bold_rm}" "${fdir}" "${polort}" "${mask}" "${tmp}" "${bold}"_dt
			bold_rm=${bold}_dt
		fi

		echo "************************************"
		echo "*** Func SPC ${task} BOLD ${e}"
		echo "************************************"
		echo "************************************"
		sh "${scriptdir}"/02.func_preproc/09.func_spc.sh "${bold_rm}" "${fdir}" "${mask}" "${tmp}" "${bold}"_spc

		# echo "*****************************************"
		# echo "*** Func grayplot ${task} BOLD echo ${e}"
		# echo "*****************************************"
		# echo "*****************************************"
		# sh "${scriptdir}"/02.func_preproc/12.func_grayplot.sh "${bold}"_SPC "${fdir}" "${anat%/*}" "${flpr}"_MNI_bucket "${tmp}"

	done


# 	echo "*****************************************"
# 	echo "***** Calculating absmax of all TE ******"
# 	echo "*****************************************"
# 	echo "*****************************************"

# 	# Remove values above 1 to avoid issues with short format.
# 	for e in $( seq 1 "${nTE}" )
# 	do
# 		3dTstat -absmax -overwrite -prefix "${tmp}"/rm.mask.absmax.e"${e}".nii.gz "${tmp}"/"${flpr}"_task-"${task}"_echo-"${e}"_bold_SPC.nii.gz
# 	done

# 	3dcalc -a "${tmp}"/rm.mask.absmax.e1.nii.gz -b "${tmp}"/rm.mask.absmax.e2.nii.gz -c "${tmp}"/rm.mask.absmax.e3.nii.gz -d "${tmp}"/rm.mask.absmax.e4.nii.gz -e "${tmp}"/rm.mask.absmax.e5.nii.gz -expr 'bool(astep(a,0.3)+astep(b,0.3)+astep(c,0.3)+astep(d,0.3)+astep(e,0.3))' -prefix "${tmp}"/"${flpr}"_task-"${task}"_mask_absmax.nii.gz -overwrite

# 	for e in $( seq 1 "${nTE}" )
# 	do
# 		echo "*****************************************"
# 		echo "******* Saving SPC in short format ******"
# 		echo "*****************************************"
# 		echo "*****************************************"
# 		if [ "${e}" != "optcom" ]
# 		then
# 			e=echo-${e}
# 		fi
# 		bold=${flpr}_task-${task}_${e}_bold
# 		mask=${flpr}_task-${task}_${e}_mask
# 		echo "3dcalc -a ${tmp}/${bold}_SPC.nii.gz -b ${tmp}/${flpr}_task-${task}_mask_absmax.nii.gz -m ${fdir}/${mask}.nii.gz -expr '(m-b)*a' -datum short -prefix ${fdir}/00.${bold}_preprocessed.nii.gz -overwrite"
# 		3dcalc -a "${tmp}"/"${bold}"_SPC.nii.gz -b "${tmp}"/"${flpr}"_task-"${task}"_mask_absmax.nii.gz -m "${fdir}"/"${mask}".nii.gz -expr '(m-b)*a' -datum short -prefix "${fdir}"/00."${bold}"_preprocessed.nii.gz -overwrite
# 	done

# 	echo "rm -rf ${tmp}"
# 	# rm -rf "${tmp}"

fi