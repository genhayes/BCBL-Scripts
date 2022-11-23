#!/usr/bin/env bash

######### Lagged GLM for CVR analysis with phys2cvr
# Author:  Cesar Caballero GAudes
# Version: 1.0
# Date:    16.09.2022
#########

module load afni/latest
module load python/python3.6


sub=$1
ses=$2
run=$3
task=$4
wdr=$5

flpr=sub-${sub}_ses-${ses}

PRJDIR="/bcbl/home/public/PJMASK_2/VB_Quantiphyse/PRESURGICAL_BH"
wdr=${PRJDIR}/sub-${sub}/ses-${ses}/func_preproc   
task=BH

func_in=$6
func_in="${flpr}_task-${task}_optcom_bold_spc"
fmask=${7}
fmask="${flpr}_task-${task}_optcom_mask"
co2file=$8
co2file="/bcbl/home/public/CVR/PRESURGICAL_BH/peakdet/sub-JH_ses-056_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys"
fs_co2=$9

# tr=$(3dinfo -tr "${wdr}/${func_in}.nii.gz")

echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -lm 9 -ls 1 -r2full"
phys2cvr -i "${wdr}/${func_in}.nii.gz" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -lm 9 -ls 1 -r2full 

