#! /bin/bash

# I know the name is super long xD

prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data
maps_dir=${prj_dir}/qp_lGLM_ts025_out/

# Create a folder for the links
mkdir -p ${prj_dir}/025_links_to_all_maps

# remove all files ending in png
rm ${prj_dir}/025_links_to_all_maps/*.png

# Move into the folder
cd $prj_dir/025_links_to_all_maps || exit
#cd $prj_dir/links_delay || exit

# For each Case folder in the qp_batch_outputs folder, create a link to the cvr1_vb.nii and 
# cvr1_lGLM.nii files in the links_to_all_maps folder, and rename them to have the name of each subject and session folder
# before their actual name
for i in "${maps_dir}"/*; do
    # Extract the Case name from the path
    case_name=$(basename "$i")
    # If .nii not on case_name
    if [[ ! "$case_name" == *".nii"* ]]; then
        echo "Linking $case_name files..."
        # Remove first 4 characters from case_name
        case_num=${case_name:4}
        # Decrement case_num by 1
        case_num=$((case_num-1))
        echo "Case number: $case_num"

        # If the case name is 6 characters long, the subject number is the first number plus 1 and the last number is the session number
        if [[ ${#case_num} -eq 2 ]]; then
            # Extract the subject number
            subject_number=${case_num:0:1}
            # Increment the subject number by 1
            subject_number=$((subject_number+1))
            #if subject number is less than 2 characters, pad the beginning of session number with 0
            if [[ ${#subject_number} -eq 1 ]]; then
                subject_number="0$subject_number"
            else
                echo "Subject number ${subject_number} is ${#subject_number} characters long"          
            fi
            echo "Subject number: $subject_number"
            # Extract the session number
            session_number=${case_num:1:1}
            # Increment the session number by 1
            session_number=$((session_number+1))
            #if session number is less than 2 characters, pad the beginning of session number with 0
            if [[ ${#session_number} -eq 1 ]]; then
                session_number="0$session_number"
            else
                echo "Session number ${session_number} is ${#session_number} characters long" 
            fi

            echo "Session number: $session_number"

                        # Create a link to the cvr1 files if the link doesn't already exist
            if [[ ! -f sub-0"$subject_number"_ses-"$session_number"_cvr1_vb.nii ]]; then
                #ln -s "${maps_dir}"/"$case_name"/cvr1_vb.nii sub-0"$subject_number"_ses-"$session_number"_cvr1_vb.nii
                ln -s "${maps_dir}"/"$case_name"/cvr1_lGLM.nii sub-0"$subject_number"_ses-"$session_number"_cvr1_lGLM.nii
                #ln -s "${maps_dir}"/"$case_name"/delay_vb.nii sub-0"$subject_number"_ses-"$session_number"_delay_vb.nii
                ln -s "${maps_dir}"/"$case_name"/delay_lGLM.nii sub-0"$subject_number"_ses-"$session_number"_delay_lGLM.nii
            fi

            # # Create a link to the cvr1_vb.nii file
            # ln -s "${maps_dir}"/"$case_name"/cvr1_vb.nii sub-0"$subject_number"_ses-"$session_number"_cvr1_vb.nii
            # # Create a link to the cvr1_lGLM.nii file
            # ln -s "${maps_dir}"/"$case_name"/cvr1_lGLM.nii sub-0"$subject_number"_ses-"$session_number"_cvr1_lGLM.nii
            # # Create a link to the delay1_vb.nii file
            # ln -s "${maps_dir}"/"$case_name"/delay_vb.nii sub-0"$subject_number"_ses-"$session_number"_delay_vb.nii
            # # Create a link to the delay1_lGLM.nii file
            # ln -s "${maps_dir}"/"$case_name"/delay_lGLM.nii sub-0"$subject_number"_ses-"$session_number"_delay_lGLM.nii
        fi
        # Otherwise, if the case name is 5 characters long, the subject number is 1 amd the session number is the last number
        if [[ ${#case_num} -eq 1 ]]; then
            # Extract the subject number
            subject_number=01
            echo "Subject number: $subject_number"
            # Extract the session number
            session_number=${case_num:0:1}
            # Increment the session number by 1
            session_number=$((session_number+1))
            if [[ ${#session_number} -eq 1 ]]; then
                session_number="0$session_number"
            else
                echo "Session number ${session_number} is ${#session_number} characters long" 
            fi
            echo "Session number: $session_number"
            # Create a link to the cvr1 files if the link doesn't already exist
            if [[ ! -f sub-0"$subject_number"_ses-"$session_number"_cvr1_vb.nii ]]; then
                #ln -s "${maps_dir}"/"$case_name"/cvr1_vb.nii sub-0"$subject_number"_ses-"$session_number"_cvr1_vb.nii
                ln -s "${maps_dir}"/"$case_name"/cvr1_lGLM.nii sub-0"$subject_number"_ses-"$session_number"_cvr1_lGLM.nii
                #ln -s "${maps_dir}"/"$case_name"/delay_vb.nii sub-0"$subject_number"_ses-"$session_number"_delay_vb.nii
                ln -s "${maps_dir}"/"$case_name"/delay_lGLM.nii sub-0"$subject_number"_ses-"$session_number"_delay_lGLM.nii
            fi


            # ln -s "${maps_dir}"/"$case_name"/cvr1_vb.nii sub-0"$subject_number"_ses-"$session_number"_cvr1_vb.nii
            # # Create a link to the cvr1_lGLM.nii file
            # ln -s "${maps_dir}"/"$case_name"/cvr1_lGLM.nii sub-0"$subject_number"_ses-"$session_number"_cvr1_lGLM.nii
            # # Create a link to the delay1_vb.nii file
            # ln -s "${maps_dir}"/"$case_name"/delay_vb.nii sub-0"$subject_number"_ses-"$session_number"_delay_vb.nii
            # # Create a link to the delay1_lGLM.nii file
            # ln -s "${maps_dir}"/"$case_name"/delay_lGLM.nii sub-0"$subject_number"_ses-"$session_number"_delay_lGLM.nii
        fi

    fi
done

echo "Done!"