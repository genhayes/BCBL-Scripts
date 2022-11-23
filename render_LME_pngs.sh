#! /bin/bash
# This script renders png images for the lGLM and vb CVR and delay map ICC stats using fsleyes
module load fsl/6.0.3
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed/LMEr

# Create a folder for the pngs
mkdir -p $prj_dir/pngs
out_dir=$prj_dir/pngs

# move into project directory
cd ${prj_dir}

# Render all lightbox images
fsleyes render -of ${out_dir}/LME_cvr_render.png --scene lightbox --worldLoc 24.027021668555903 -35.38523039628754 41.7533048411451 --displaySpace world --zaxis 2 --sliceSpacing 14.72666666464104 --zrange -24.516695149739583 65.63991881473223 --ncols 6 --nrows 2 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --showColourBar --colourBarLocation left --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 12 --performance 3 --movieSync ${prj_dir}/LMEr_cvr_lGLM_vs_vb.nii.gz --name "LMEr CVR lGLMvs.VB" --overlayType volume --alpha 100.0 --brightness 49.996249999713896 --contrast 99.99249999942779 --cmap hot --negativeCmap blue-lightblue --clipImage ${prj_dir}/LMEr_cvr_lGLM_vs_vb_Z.nii.gz --displayRange 0.0 0.03 --clippingRange 0.0 3.2 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0 ${prj_dir}/LMEr_cvr_lGLM_vs_vb_Z.nii.gz --name "LMEr_cvr_lGLM_vs_vb_Z" --disabled --overlayType volume --alpha 100.0 --brightness 49.99999923053835 --contrast 49.99999969221535 --cmap greyscale --negativeCmap greyscale --displayRange -22.065750122070312 8.919365882873535 --clippingRange -22.065750122070312 9.229217033386231 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

fsleyes render -of ${out_dir}/LME_delay_render.png --scene lightbox --worldLoc 24.027021668555903 -35.38523039628754 41.7533048411451 --displaySpace world --zaxis 2 --sliceSpacing 14.72666666464104 --zrange -24.516695149739583 65.63991881473223 --ncols 6 --nrows 2 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --showColourBar --colourBarLocation left --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 12 --performance 3 --movieSync ${prj_dir}/LMEr_delay_lGLM_vs_vb.nii.gz --name "LMEr Delay lGLMvs.VB" --overlayType volume --alpha 100.0 --brightness 49.996249999713896 --contrast 99.99249999942779 --cmap hot --negativeCmap blue-lightblue --clipImage ${prj_dir}/LMEr_delay_lGLM_vs_vb_Z.nii.gz --displayRange 0.0 0.5 --clippingRange 0.0 3.2 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0 ${prj_dir}/LMEr_delay_lGLM_vs_vb_Z.nii.gz --name "LMEr_delay_lGLM_vs_vb_Z" --disabled --overlayType volume --alpha 100.0 --brightness 49.99999923053835 --contrast 49.99999969221535 --cmap greyscale --negativeCmap greyscale --displayRange -22.065750122070312 8.919365882873535 --clippingRange -22.065750122070312 9.229217033386231 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

echo "Done rendering LMEr CVR and Delay lGLMvs.VB"