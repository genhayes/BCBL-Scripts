#! /bin/bash
# This script renders png images for the lGLM and vb CVR maps using fsleyes
module load fsl/6.0.3
prj_dir=/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/
slice_type='multi_slice' #'single-slice'

# Create a folder for the pngs
mkdir -p $prj_dir/pngs
# Create a folder for the slice type
mkdir -p $prj_dir/pngs/$slice_type

out_dir=$prj_dir/pngs/$slice_type/

SBJ_LIST=('sub-001' 'sub-002' 'sub-003' 'sub-004' 'sub-007' 'sub-008')
SES_LIST=('ses-01' 'ses-02' 'ses-03' 'ses-04' 'ses-05' 'ses-06' 'ses-07' 'ses-08' 'ses-09' 'ses-10')

# Create lightbox png of vb, lGLM CVR and delay map for each subject and each session
for SBJ in ${SBJ_LIST[@]}
do
    for SES in ${SES_LIST[@]}
    do

        if [[ ! -f "task-breathhold_meica-cons_bold_native_preprocessed.dt.nii.gz" ]]; then
            # Create png of lGLM CVR map (1x5 lighthouse view) 
            echo "rendering lGLM CVR map for ${SBJ} ${SES}"
            fsleyes render -of ${out_dir}${SBJ}_${SES}_cvr1_lGLM_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_cvr1_lGLM.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_cvr1_lGLM.nii --name "${SBJ}_${SES}_cvr1_lGLM" --overlayType volume --alpha 100.0 --cmap hot --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 0.6 --clippingRange 0.0 1960.618485107422 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
        
            # Create png of VB CVR map (1x5 lighthouse view)
            echo "rendering VB CVR map for ${SBJ} ${SES}"
            fsleyes render -of ${out_dir}${SBJ}_${SES}_cvr1_vb_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_cvr1_vb.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_cvr1_vb.nii --name "${SBJ}_${SES}_cvr1_vb" --overlayType volume --alpha 100.0 --cmap hot --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 0.6 --clippingRange 0.0 1960.618485107422 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

            # # Create png of lGLM Delay map (1x5 lighthouse view) 
            # echo "rendering lGLM Delay map for ${SBJ} ${SES}"
            # fsleyes render -of ${out_dir}${SBJ}_${SES}_delay_lGLM_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_delay_lGLM.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_delay_lGLM.nii --name "${SBJ}_${SES}_delay_lGLM" --overlayType volume --alpha 100.0 --cmap hot --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 10.0 --clippingRange 0.0 1960.618485107422 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

            # Create png of lGLM Delay map (1x5 lighthouse view) 
            echo "rendering lGLM Delay map for ${SBJ} ${SES}"
            fsleyes render -of ${out_dir}${SBJ}_${SES}_delay_lGLM_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_delay_lGLM.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_delay_lGLM.nii --name "${SBJ}_${SES}_delay_lGLM" --overlayType volume --alpha 100.0 --cmap pink --negativeCmap brain_colours_2winter --unlinkLowRanges --useNegativeCmap --displayRange 0.0 10.0 --clippingRange 0.0 8.10481616973877 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
        
            # # Create png of VB Delay map (1x5 lighthouse view) 
            # echo "rendering VB Delay map for ${SBJ} ${SES}"
            # fsleyes render -of ${out_dir}${SBJ}_${SES}_delay_vb_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_delay_vb.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_delay_vb.nii --name "${SBJ}_${SES}_delay_vb" --overlayType volume --alpha 100.0 --cmap hot --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 10.0 --clippingRange 0.0 1960.618485107422 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

            # Create png of VB Delay map (1x5 lighthouse view) 
            echo "rendering VB Delay map for ${SBJ} ${SES}"
            fsleyes render -of ${out_dir}${SBJ}_${SES}_delay_vb_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_delay_vb.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_delay_vb.nii --name "${SBJ}_${SES}_delay_vb" --overlayType volume --alpha 100.0 --cmap pink --negativeCmap brain_colours_2winter --unlinkLowRanges --useNegativeCmap --displayRange 0.0 10.0 --clippingRange 0.0 8.10481616973877 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
    

        fi

    done
done

echo "Done!"

# # Crop images
# for sub in ${SBJ_LIST[@]}
# do
#     echo "Creating montage for ${sub}"
#     for ses in ${SES_LIST[@]}
#     do
#         echo "Adding ${ses} to montage"

#         convert ${prj_dir}${sub}_${ses}_cvr1_lGLM_render.png -crop 920x212+30+220 +repage ${prj_dir}${sub}_${ses}_cvr1_lGLM_render.png
        
#     done
# done

            # # Create png of lGLM CVR map (1x5 lighthouse view) WITH colourbar
            # echo "rendering lGLM CVR map for ${SBJ} ${SES}"
            # fsleyes render -of ${out_dir}${SBJ}_${SES}_cvr1_lGLM_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_cvr1_lGLM.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --showColourBar --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_cvr1_lGLM.nii --name "${SBJ}_${SES}_cvr1_lGLM" --overlayType volume --alpha 100.0 --cmap hot --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 0.06 --clippingRange 0.0 1960.618485107422 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
        
            # # Create png of VB CVR map (1x5 lighthouse view) WITH colourbar
            # echo "rendering VB CVR map for ${SBJ} ${SES}"
            # fsleyes render -of ${out_dir}${SBJ}_${SES}_cvr1_vb_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_cvr1_vb.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --showColourBar --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_cvr1_vb.nii --name "${SBJ}_${SES}_cvr1_vb" --overlayType volume --alpha 100.0 --cmap hot --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 0.6 --clippingRange 0.0 1960.618485107422 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0

            # # Create png of lGLM Delay map (1x5 lighthouse view) WITH colourbar
            # echo "rendering lGLM Delay map for ${SBJ} ${SES}"
            # fsleyes render -of ${out_dir}${SBJ}_${SES}_delay_lGLM_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_delay_lGLM.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --showColourBar --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_delay_lGLM.nii --name "${SBJ}_${SES}_delay_lGLM" --overlayType volume --alpha 100.0 --cmap hot --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 10.0 --clippingRange 0.0 1960.618485107422 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0
        
            # # Create png of VB Delay map (1x5 lighthouse view) WITH colourbar
            # echo "rendering VB Delay map for ${SBJ} ${SES}"
            # fsleyes render -of ${out_dir}${SBJ}_${SES}_delay_vb_render.png --scene lightbox --worldLoc -102.87531972308113 -15.181425407856537 -35.46561431884764 --displaySpace ${prj_dir}${SBJ}_${SES}_delay_vb.nii --zaxis 2 --sliceSpacing 16.0 --zrange 35.0 115.0 --ncols 5 --nrows 1 --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --showColourBar --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 25 --performance 3 --movieSync ${prj_dir}${SBJ}_${SES}_delay_vb.nii --name "${SBJ}_${SES}_delay_vb" --overlayType volume --alpha 100.0 --cmap hot --negativeCmap blue-lightblue --useNegativeCmap --displayRange 0.0 10.0 --clippingRange 0.0 1960.618485107422 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 60 --blendFactor 0.3 --smoothing 0 --resolution 70 --numInnerSteps 10 --clipMode intersection --volume 0