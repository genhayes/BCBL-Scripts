#! /bin/bash
# This script renders png images for the lGLM and vb CVR maps using fsleyes
module load fsl/6.0.3
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/
slice_type='single_slice_-10to10' #'single-slice'

# Create a folder for the pngs
mkdir -p ${prj_dir}pngs
# Create a folder for the slice type
mkdir -p ${prj_dir}pngs/$slice_type

out_dir=${prj_dir}pngs/$slice_type/

# SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
# SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')
SBJ_LIST=('sub-004')
SES_LIST=('ses-05')

# Create lightbox png of vb, lGLM CVR and delay map for each subject and each session
for SBJ in "${SBJ_LIST[@]}"
do
    for SES in "${SES_LIST[@]}"
    do

        if [[ ! -f "task-breathhold_meica-cons_bold_native_preprocessed.dt.nii.gz" ]]; then
            # Create png of lGLM CVR map (1x1 ortho view) WITHOUT colourbar (add --showColourBar to add colourbar)
            echo "rendering lGLM CVR map for ${SBJ} ${SES}"
            fsleyes render -of ${out_dir}${SBJ}_${SES}_cvr1_lGLM_render.png --scene ortho --worldLoc 22.20543896466853 58.51775086344193 -33.965769171702945 --displaySpace ${prj_dir}${SBJ}_${SES}_cvr1_lGLM.nii --xcentre  0.00000  0.00000 --ycentre  0.00000  0.00000 --zcentre  0.00000  0.00000 --xzoom 100.0 --yzoom 100.0 --zzoom 100.0 --hideLabels --layout horizontal --hidex --hidey --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 30.0 --labelSize 12 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_cvr1_lGLM.nii --name "${SBJ}_${SES}_cvr1_lGLM" --overlayType volume --alpha 100.0 --cmap red-yellow --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 0.6 --clippingRange 0.0 550.9034027099609 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

            # fsleyes --scene ortho --worldLoc 17.40547270279083 55.660040919974094 -24.928274550333683 --displaySpace /bcbl/home/public/PJMASK_2/VB_Quantiphyse/Data/centered_delay_maps/sub-001_ses-08_delay_lGLM.nii --xcentre  0.00000  0.00000 --ycentre  0.00000  0.00000 --zcentre  0.00000  0.00000 --xzoom 100.0 --yzoom 100.0 --zzoom 100.00880401522787 --hideLabels --layout horizontal --hidex --hidey --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 12 --performance 3 --movieSync /bcbl/home/public/PJMASK_2/VB_Quantiphyse/Data/centered_delay_maps/sub-001_ses-08_delay_lGLM.nii --name "sub-001_ses-08_delay_lGLM" --disabled --overlayType volume --alpha 100.0 --cmap red-yellow --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 8.0 --clippingRange 0.0 8.91716911315918 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0 /bcbl/home/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/sub-001_ses-01_cvr1_lGLM.nii --name "sub-001_ses-01_cvr1_lGLM" --disabled --overlayType volume --alpha 100.0 --cmap red-yellow --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 0.6 --clippingRange 0.0 2016.8938061523438 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0 /bcbl/home/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/sub-001_ses-03_cvr1_lGLM.nii --name "sub-001_ses-03_cvr1_lGLM" --overlayType volume --alpha 100.0 --cmap red-yellow --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 0.6 --clippingRange 0.0 550.9034027099609 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
        
            # Create png of VB CVR map
            echo "rendering VB CVR map for ${SBJ} ${SES}"
            fsleyes render -of ${out_dir}${SBJ}_${SES}_cvr1_vb_render.png --scene ortho --worldLoc 22.20543896466853 58.51775086344193 -33.965769171702945 --displaySpace ${prj_dir}${SBJ}_${SES}_cvr1_vb.nii --xcentre  0.00000  0.00000 --ycentre  0.00000  0.00000 --zcentre  0.00000  0.00000 --xzoom 100.0 --yzoom 100.0 --zzoom 100.0 --hideLabels --layout horizontal --hidex --hidey --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 30.0 --labelSize 12 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_cvr1_vb.nii --name "${SBJ}_${SES}_cvr1_vb" --overlayType volume --alpha 100.0 --cmap red-yellow --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 0.6 --clippingRange 0.0 550.9034027099609 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

            # Create png of lGLM Delay map
            echo "rendering lGLM Delay map for ${SBJ} ${SES}"
            fsleyes render -of ${out_dir}${SBJ}_${SES}_delay_lGLM_render.png --scene ortho --worldLoc 22.20543896466853 58.51775086344193 -33.965769171702945 --displaySpace ${prj_dir}${SBJ}_${SES}_delay_lGLM.nii --xcentre  0.00000  0.00000 --ycentre  0.00000  0.00000 --zcentre  0.00000  0.00000 --xzoom 100.0 --yzoom 100.0 --zzoom 100.0 --hideLabels --layout horizontal --hidex --hidey --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 30.0 --labelSize 12 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_delay_lGLM.nii --name "${SBJ}_${SES}_delay_lGLM" --overlayType volume --alpha 100.0 --cmap red-yellow --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 10.0 --clippingRange 0.0 18691.9319140625 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
        
            # Create png of VB Delay map
            echo "rendering VB Delay map for ${SBJ} ${SES}"
            fsleyes render -of ${out_dir}${SBJ}_${SES}_delay_vb_render.png --scene ortho --worldLoc 22.20543896466853 58.51775086344193 -33.965769171702945 --displaySpace ${prj_dir}${SBJ}_${SES}_delay_vb.nii --xcentre  0.00000  0.00000 --ycentre  0.00000  0.00000 --zcentre  0.00000  0.00000 --xzoom 100.0 --yzoom 100.0 --zzoom 100.0 --hideLabels --layout horizontal --hidex --hidey --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 30.0 --labelSize 12 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_delay_vb.nii --name "${SBJ}_${SES}_delay_vb" --overlayType volume --alpha 100.0 --cmap red-yellow --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 10.0 --clippingRange 0.0 18691.9319140625 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

        fi

    done
done

echo "Done!"

            
