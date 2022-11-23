#Create grid of all sub and ses cvr maps with lGLM on top and VB on bottom, each subject in a column and each session in a row
import os
from nilearn import plotting

prj_dir = '/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_all_maps/'

lGLM_filename = 'sub-001-ses-01_cvr1_lGLM.nii.gz'
vb_filename = '/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_all_maps/ssub-001_ses-01_cvr1_vb.nii.gz'

plotting.view_img(os.path.join(prj_dir, lGLM_filename))

