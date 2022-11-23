#!/bin/bash
#Remove empty files from all folders
#Warning: problem with Script, new folder ses-01/ses-02/ses-... gets created

prj_dir=/bcbl/home/public/PJMASK_2/VB_Quantiphyse

cd "${prj_dir}" || exit

# Loop through all sub- folders in prj_dir
for d in "${prj_dir}"/*; do

    # Move into the folder if it's not called Scripts
    if [ "${d}" != "${prj_dir}/Scripts" ]; then

        cd "${d}" || exit
        
        # echo "Processing ${d}"

        # Loop through all directories in the current folder
        for dd in ./*; do

            cd "${dd}/func_preproc" || exit

            # echo "Processing ${dd}"
        
            # Loop through all files in the current folder
            for f in ./*; do

                # echo "Processing ${f}"
            
                # Remove the file if it's empty
                if [ ! -s "${f}" ]; then
                    rm "${f}"
                    # echo "Removing ${f}"
                fi
            
            done

            cd ../..

        done

        cd "${d}" || exit
    fi

    echo "Done with ${d}"
    
    cd ..
    
done