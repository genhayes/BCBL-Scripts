#! /bin/bash

# I know the name is super long xD

prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data

# Create a folder for the links
mkdir -p $prj_dir/links_to_cvr

# Move into the folder
cd $prj_dir/links_to_cvr || exit

# For each Case folder in the qp_out folder, create a link to the cvr1_vb.nii and 
# cvr1_lGLM.nii files in the links_to_cvr folder, and rename them to have the name of the Case folder
# before their actual name
for i in "$prj_dir"/qp_out/*; do
    # Extract the Case name from the path
    case_name=$(basename "$i")
    # If .nii not on case_name
    if [[ ! "$case_name" == *".nii"* ]]; then
        echo "Linking $case_name files..."
        # Create a link to the cvr1_vb.nii file
        ln -s "$prj_dir"/qp_out/"$case_name"/cvr1_vb.nii "$case_name"_cvr1_vb.nii
        # Create a link to the cvr1_lGLM.nii file
        ln -s "$prj_dir"/qp_out/"$case_name"/cvr1_lGLM.nii "$case_name"_cvr1_lGLM.nii
    fi
done

echo "Done!"