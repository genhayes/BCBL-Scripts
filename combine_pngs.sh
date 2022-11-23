#!/usr/bin/env bash

prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/pngs/multi_slice/cropped
out_dir=${prj_dir}/grids
# Define subject to use in grid
subject='sub-002'

mkdir -p $out_dir

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')
MAP_LIST=('cvr1' 'delay')

# move into project directory
cd ${prj_dir}

for sub in ${SBJ_LIST[@]}
do
    for ses in ${SES_LIST[@]}
    do
        for map in ${MAP_LIST[@]}
        do
            echo "Combining vb and lGLM images for ${sub} ${ses} ${map}"
            montage ${sub}_${ses}_${map}_lGLM_render.png ${sub}_${ses}_${map}_vb_render.png -tile 2x1 -geometry +2+0 ${out_dir}/${map}_${sub}_${ses}.png
        done

        # montage concatentates lGLM and vb images horizontally
        # montage -tile 1x2 ${sub}_${ses}_cvr1_lGLM_render.png ${sub}_${ses}_cvr1_vb_render.png -geometry +0+0 ${out_dir}/cvr_${sub}_${ses}.png

        #montage -density 150 tile 0x2 -geometry +0+0 ${prj_dir}/${sub}_${ses}_cvr1_lGLM_render.png ${prj_dir}/${sub}_${ses}_cvr1_vb_render.png ${out_dir}/00.all_${sub}.png
        #montage -density 150 tile 2x0 -geometry +0+1 ${prj_dir}/${sub}_${ses}_cvr1_vb_render.png ${out_dir}/00.all_${sub}.png
        
    done
done

cd ${out_dir}
#montage -tile 1x2 cvr_sub-001_ses-01.png cvr_sub-001_ses-02.png -geometry +0+2 ${out_dir}/cvr_grid.png
montage -tile 1x10 cvr1_${subject}_ses-01.png cvr1_${subject}_ses-02.png cvr1_${subject}_ses-03.png cvr1_${subject}_ses-04.png cvr1_${subject}_ses-05.png cvr1_${subject}_ses-06.png cvr1_${subject}_ses-07.png cvr1_${subject}_ses-08.png cvr1_${subject}_ses-09.png cvr1_${subject}_ses-10.png -geometry +0+2 ${out_dir}/00.${subject}_cvr_grid.png
montage -tile 1x10 delay_${subject}_ses-01.png delay_${subject}_ses-02.png delay_${subject}_ses-03.png delay_${subject}_ses-04.png delay_${subject}_ses-05.png delay_${subject}_ses-06.png delay_${subject}_ses-07.png delay_${subject}_ses-08.png delay_${subject}_ses-09.png delay_${subject}_ses-10.png -geometry +0+2 ${out_dir}/00.${subject}_delay_grid.png

echo "Done rengerering grid images"
