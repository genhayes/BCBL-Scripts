# Mask VB and lGLM CVR and delay maps for GM, WM, and CSF and plot VB as a function lGLM for each session

from nilearn.masking import apply_mask
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
sns.set()
#plt.style.use('dark_background')

prj_dir='/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed/'
out_filepath_cvr=prj_dir+'distribution_plots_cvr.png'
out_filepath_delay=prj_dir+'distribution_plots_delay.png'
SBJ_LIST=('sub-002',) #, 'sub-002', 'sub-003', 'sub-004', 'sub-007', 'sub-008')
SES_LIST=('ses-01',) # 'ses-02') #, 'ses-03', 'ses-04', 'ses-05', 'ses-06', 'ses-07', 'ses-08', 'ses-09', 'ses-10')
MAP_LIST=('cvr' 'delay')
TISSUE=('GM', 'WM', 'CSF')

# 0-CSF, 1-GM, 2-WM
GM_mask=prj_dir+'MNI152_T1_1mm_brain_seg_1.nii.gz'
WM_mask=prj_dir+'MNI152_T1_1mm_brain_seg_2.nii.gz'
CSF_mask=prj_dir+'MNI152_T1_1mm_brain_seg_0.nii.gz'

fig1, axs = plt.subplots(3, 1, figsize=(30,15), sharex=True) 
plt.rcParams.update({'font.size':18})
# CVR comparison
# Loop over subjects and sessions and plot lGLM vs. VB
for i, SBJ in enumerate(SBJ_LIST):
    for j, SES in enumerate(SES_LIST):
        print('Plotting comparison for : '+SBJ+'_'+SES)
        lGLM_img_path = prj_dir+'std_cvr_lGLM_'+SBJ+'_'+SES+'.nii.gz'
        vb_img_path = prj_dir+'std_cvr_vb_'+SBJ+'_'+SES+'.nii.gz'

        CSF_vb= apply_mask(vb_img_path,CSF_mask)
        CSF_lGLM= apply_mask(lGLM_img_path,CSF_mask)

        WM_vb= apply_mask(vb_img_path,WM_mask)
        WM_lGLM= apply_mask(lGLM_img_path,WM_mask)

        GM_vb= apply_mask(vb_img_path,GM_mask)
        GM_lGLM= apply_mask(lGLM_img_path,GM_mask)

        ax=fig1.add_subplot(3, 1, j+1)
        ax=sns.histplot(data=GM_lGLM, color='red', binwidth=0.007) #, bw_adjust=5)
        ax=sns.histplot(data=GM_vb, color='darkred', binwidth=0.007) #, linestyle='--', bw_adjust=5)

        ax2=fig1.add_subplot(3, 1, j+2)
        ax2=sns.histplot(data=WM_lGLM,  color='b', binwidth=0.007) #, bw_adjust=5)
        ax2=sns.histplot(data=WM_vb, color='darkblue', binwidth=0.007) #, linestyle='--', bw_adjust=5)
        
        ax3=fig1.add_subplot(3, 1, j+3)
        ax3=sns.histplot(data=CSF_lGLM, color='g', binwidth=0.007) #, bw_adjust=5)
        ax3=sns.histplot(data=CSF_vb, binwidth=0.007, color='darkgreen') #, linestyle='--', bw_adjust=5)

        ax.set(xlim=(-0.3,0.5))
        ax2.set(xlim=(-0.3,0.5))
        ax3.set(xlim=(-0.3,0.5))
        ##plt.axis('off')
        #plt.xlabel("lGLM CVR amplitude (%BOLD/mmHg")
        #plt.ylabel("VB CVR amplitude (%BOLD/mmHg")

        #ax.plot(GM_lGLM,GM_vb,'r.', alpha=0.2, label='GM')
         #,x="GM CVR (%BOLD/mmHg)")
        #ax2.plot(WM_lGLM,WM_vb,'w.', alpha=0.2, label='WM')
        #ax3.plot(CSF_lGLM,CSF_vb,'g.', alpha=0.2, label='CSF')
        
        

# Make the x-axis bounds from -0.6 to 0.6
plt.setp(axs, xlim=(-0.3,0.5)) #,ylim=(0,0.8))
#plt.xlabel("lGLM CVR amplitude (%BOLD/mmHg")
#plt.ylabel("VB CVR amplitude (%BOLD/mmHg")
lines_labels=[ax.get_legend_handles_labels() for ax in fig1.axes]
lines,labels=[sum(lol,[]) for lol in zip(*lines_labels)]
#fig1.legend(lines, labels)
fig1.tight_layout()
fig1.savefig(out_filepath_cvr, dpi=300)

print('Done CVR!')