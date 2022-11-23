#! /bin/bash
# This script renders png images for the lGLM and vb CVR and delay map ICC stats using fsleyes
module load fsl/6.0.3
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed/ICC

# Create a folder for the pngs
mkdir -p $prj_dir/pngs
out_dir=$prj_dir/pngs

# move into project directory
cd ${prj_dir}

# Render all lightbox images
for map in cvr
do
    for model in lGLM vb
    do
        for tissue in CSF GM WM 
        do 
            echo "Rendering ${map}_${model}_${tissue}..."
            fsleyes render -of ${out_dir}/ICC_${map}_${model}_${tissue}_render.png --scene lightbox --worldLoc 50.055579291449675 -123.70001220703125 13.0 --displaySpace world --zaxis 2 --sliceSpacing 13.760000001350418 --zrange -20.326697281732535 109.49989318847656 --ncols 6 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation left --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 12 --performance 3 --movieSync /bcbl/home/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed/ICC/ICC_${map}_${model}_${tissue}.nii.gz --name "ICC ${map} ${model} ${tissue}" --overlayType volume --alpha 100.0 --brightness 74.64999997329711 --contrast 99.69999997711182 --cmap brain_colours_1hot_iso --negativeCmap greyscale --displayRange 0.4 1.0 --clippingRange 0.4 100.99999229431153 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
        done 
    done 
done
echo "Done rendering ICC cvr images!"

for map in delay
do
    for model in lGLM vb
    do
        for tissue in CSF GM WM 
        do 
        echo "Rendering ${map}_${model}_${tissue}..."
            fsleyes render -of ${out_dir}/ICC_${map}_${model}_${tissue}_render.png --scene lightbox --worldLoc 50.055579291449675 -123.70001220703125 13.0 --displaySpace world --zaxis 2 --sliceSpacing 13.760000001350418 --zrange -20.326697281732535 109.49989318847656 --ncols 6 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation left --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 12 --performance 3 --movieSync /bcbl/home/public/PJMASK_2/preproc/derivatives/thesis/sub-001/ses-01/reg/MNI152_T1_1mm_brain.nii.gz --name "MNI152_T1_1mm_brain" --overlayType volume --alpha 100.0 --brightness -14.670014347202297 --contrast 33.81877407280353 --cmap greyscale --negativeCmap greyscale --displayRange 0.0 40000.0 --clippingRange 0.0 8447.64 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0 /bcbl/home/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed/ICC/ICC_${map}_${model}_${tissue}.nii.gz --name "ICC ${map} ${model} ${tissue}" --overlayType volume --alpha 100.0 --brightness 74.64999997329711 --contrast 99.69999997711182 --cmap brain_colours_1hot_iso --negativeCmap greyscale --displayRange 0.4 1.0 --clippingRange 0.4 100.99999229431153 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
        done
    done 
done
echo "Done rendering ICC delay images!"

# Move into output directory
cd ${out_dir}

# Crop images
for map in cvr delay
do
    for model in lGLM vb
    do
        for tissue in CSF GM WM 
        do 
            echo "Cropping images for ${map}_${model}_${tissue}"
            convert ${out_dir}/ICC_${map}_${model}_${tissue}_render.png -crop 920x212+3+220 +repage ${out_dir}/ICC_${map}_${model}_${tissue}_render.png
        done
    done
done

echo "Done cropping images!"

for map in cvr delay
do
    montage -tile 1x6 ${out_dir}/ICC_${map}_lGLM_GM_render.png ${out_dir}/ICC_${map}_vb_GM_render.png ${out_dir}/ICC_${map}_lGLM_WM_render.png ${out_dir}/ICC_${map}_vb_WM_render.png ${out_dir}/ICC_${map}_lGLM_CSF_render.png ${out_dir}/ICC_${map}_vb_CSF_render.png -geometry +0+1 ${out_dir}/00.ICC_${map}_grid.png
done

echo "Done making grid images!"
