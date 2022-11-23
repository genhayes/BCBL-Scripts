#! /bin/bash
# This script renders png images for the lGLM and vb CVR maps using fsleyes


slice_type='multi_slice' #'single-slice'
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/pngs/${slice_type}

# Create a folder for the cropped pngs
mkdir -p $prj_dir/cropped
out_dir=$prj_dir/cropped/

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

# move into project directory
cd ${prj_dir}

# Crop images
for sub in ${SBJ_LIST[@]}
do
    for ses in ${SES_LIST[@]}
    do
        echo "cropping images for ${sub} ${ses}"

        convert ${sub}_${ses}_cvr1_lGLM_render.png -crop 920x212+10+220 +repage ${out_dir}${sub}_${ses}_cvr1_lGLM_render.png
        convert ${sub}_${ses}_cvr1_vb_render.png -crop 920x212+10+220 +repage ${out_dir}${sub}_${ses}_cvr1_vb_render.png

        convert ${sub}_${ses}_delay_lGLM_render.png -crop 920x212+10+220 +repage ${out_dir}${sub}_${ses}_delay_lGLM_render.png
        convert ${sub}_${ses}_delay_vb_render.png -crop 920x212+10+220 +repage ${out_dir}${sub}_${ses}_delay_vb_render.png
        
    done
done

echo "Done cropping images!"