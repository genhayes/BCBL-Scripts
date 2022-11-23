#!/bin/bash
#generate list of filepaths for quantiphyse analysis

path_base='/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/'
path_save='/bcbl/home/public/PJMASK_2/VB_Quantiphyse/Scripts'
filename='listqp.txt'

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-005' 'sub-006' 'sub-007' 'sub-008' 'sub-009' 'sub-010')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')
num=1

for SBJ in ${SBJ_LIST[@]}
do
    for SES in ${SES_LIST[@]}
    do

    #echo "${path_base}/${SBJ}/${SES}/func_preproc" | tee -a ${filename}
    cat >> ${filename} <<-EOF
        Case${num}:
            Folder: ${path_base}/${SBJ}/${SES}/func_preproc
EOF
    num=$((num+1))

    done
done