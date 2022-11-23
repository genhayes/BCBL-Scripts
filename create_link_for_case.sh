#! /bin/bash

# I know the name is super long xD
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data
maps_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/manual_qp_batch_outputs/Case35


subject_number=4
session_number=5

# Move into the folder
cd $prj_dir/links_to_all_maps || exit

echo "Linking Case35 files..."

ln -sf "${maps_dir}"/cvr1_vb.nii sub-00"$subject_number"_ses-0"$session_number"_cvr1_vb.nii
ln -sf "${maps_dir}"/cvr1_lGLM.nii sub-00"$subject_number"_ses-0"$session_number"_cvr1_lGLM.nii
ln -sf "${maps_dir}"/delay_vb.nii sub-00"$subject_number"_ses-0"$session_number"_delay_vb.nii
ln -sf "${maps_dir}"/delay_lGLM.nii sub-00"$subject_number"_ses-0"$session_number"_delay_lGLM.nii

echo "Done!"