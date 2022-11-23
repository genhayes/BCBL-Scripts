# Mask VB and lGLM CVR and delay maps for GM, WM, and CSF and plot VB as a function lGLM for each session

from nilearn.masking import apply_mask
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
sns.set()
plt.style.use('dark_background')

prj_dir='/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/MNI_maps_postprocessed/'
out_filepath_cvr=prj_dir+'comparison_plots_cvr.png'
out_filepath_delay=prj_dir+'comparison_plots_delay.png'
SBJ_LIST=('sub-007',) #, 'sub-002', 'sub-003', 'sub-004', 'sub-007', 'sub-008')
SES_LIST=('ses-01',) # 'ses-02') #, 'ses-03', 'ses-04', 'ses-05', 'ses-06', 'ses-07', 'ses-08', 'ses-09', 'ses-10')
MAP_LIST=('cvr' 'delay')
TISSUE=('GM', 'WM', 'CSF')

# 0-CSF, 1-GM, 2-WM
GM_mask=prj_dir+'MNI152_T1_1mm_brain_seg_1.nii.gz'
WM_mask=prj_dir+'MNI152_T1_1mm_brain_seg_2.nii.gz'
CSF_mask=prj_dir+'MNI152_T1_1mm_brain_seg_0.nii.gz'

fig1, axs = plt.subplots(3, 1, figsize=(12,15), sharex=True) 
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
        ax2=fig1.add_subplot(3, 1, j+2)
        ax3=fig1.add_subplot(3, 1, j+3)
        ax.set(xlim=(-0.8,0.8), ylim=(0,0.8))
        ax2.set(xlim=(-0.8,0.8), ylim=(0,0.8))
        ax3.set(xlim=(-0.8,0.8), ylim=(0,0.8))
        ##plt.axis('off')
        #plt.xlabel("lGLM CVR amplitude (%BOLD/mmHg")
        #plt.ylabel("VB CVR amplitude (%BOLD/mmHg")

        ax.plot(GM_lGLM,GM_vb,'r.', alpha=0.2, label='GM')
        ax2.plot(WM_lGLM,WM_vb,'w.', alpha=0.2, label='WM')
        ax3.plot(CSF_lGLM,CSF_vb,'g.', alpha=0.2, label='CSF')
        
        

# Make the x-axis bounds from -0.6 to 0.6
plt.setp(axs, xlim=(-0.8,0.8),ylim=(0,0.8))
#plt.xlabel("lGLM CVR amplitude (%BOLD/mmHg")
#plt.ylabel("VB CVR amplitude (%BOLD/mmHg")
lines_labels=[ax.get_legend_handles_labels() for ax in fig1.axes]
lines,labels=[sum(lol,[]) for lol in zip(*lines_labels)]
#fig1.legend(lines, labels)
fig1.tight_layout()
fig1.savefig(out_filepath_cvr, dpi=300)

print('Done CVR!')


# # Delay map comparison
# fig2, axs2 = plt.subplots(3, 1, figsize=(12,15), sharex=True) 
# plt.rcParams.update({'font.size':10})
# # Loop over subjects and sessions and plot lGLM vs. VB
# for i, SBJ in enumerate(SBJ_LIST):
#     for j, SES in enumerate(SES_LIST):
#         print('Plotting comparison for : '+SBJ+'_'+SES)
#         lGLM_img_path = prj_dir+'std_delay_lGLM_'+SBJ+'_'+SES+'.nii.gz'
#         vb_img_path = prj_dir+'std_delay_vb_'+SBJ+'_'+SES+'.nii.gz'

#         CSF_vb= apply_mask(vb_img_path,CSF_mask)
#         CSF_lGLM= apply_mask(lGLM_img_path,CSF_mask)

#         WM_vb= apply_mask(vb_img_path,WM_mask)
#         WM_lGLM= apply_mask(lGLM_img_path,WM_mask)

#         GM_vb= apply_mask(vb_img_path,GM_mask)
#         GM_lGLM= apply_mask(lGLM_img_path,GM_mask)

#         ax=fig2.add_subplot(3, 1, j+1)
#         ax2=fig2.add_subplot(3, 1, j+2)
#         ax3=fig2.add_subplot(3, 1, j+3)
#         ax.set(xlim=(-10,10), ylim=(-10,10))
#         ax2.set(xlim=(-10,10), ylim=(-10,10))
#         ax3.set(xlim=(-10,10), ylim=(-10,10))
#         plt.axis('off')

#         ax.plot(CSF_lGLM,CSF_vb,'g.', alpha=0.2)
#         ax2.plot(WM_lGLM,WM_vb,'b.', alpha=0.2)
#         ax3.plot(GM_lGLM,GM_vb,'r.', alpha=0.2)

# # Make the x-axis bounds from -0.6 to 0.6
# plt.setp(axs2, xlim=(-10,10))
# fig2.tight_layout()
# fig2.savefig(out_filepath_delay, dpi=300)
# print('Done delay!')

# fig2, axs = plt.subplots(10, 1, figsize=(5,15), sharex=True) 
# plt.rcParams.update({'font.size':10})
# # Loop over subjects and sessions and plot lGLM vs. VB
# for i, SBJ in enumerate(SBJ_LIST):
#     for j, SES in enumerate(SES_LIST):
#         print('Plotting comparison for : '+SBJ+'_'+SES)
#         lGLM_img_path = prj_dir+'std_cvr_lGLM_'+SBJ+'_'+SES+'.nii.gz'
#         vb_img_path = prj_dir+'std_cvr_vb_'+SBJ+'_'+SES+'.nii.gz'


#         CSF_vb= apply_mask(vb_img_path,CSF_mask)
#         CSF_lGLM= apply_mask(lGLM_img_path,CSF_mask)

#         WM_vb= apply_mask(vb_img_path,WM_mask)
#         WM_lGLM= apply_mask(lGLM_img_path,WM_mask)

#         GM_vb= apply_mask(vb_img_path,GM_mask)
#         GM_lGLM= apply_mask(lGLM_img_path,GM_mask)

#         #print(type(GM_vb[:]))
#         #print(np.shape(GM_lGLM[1]))

#         ax=fig2.add_subplot(10, 1, j+1)
#         ax.set(xlim=(-0.6,0.6), ylim=(0,0.6))
#         plt.axis('off')

#         ax.plot(CSF_lGLM,CSF_vb,'g.', alpha=0.2)
#         ax.plot(WM_lGLM,WM_vb,'b.', alpha=0.2)
#         ax.plot(GM_lGLM,GM_vb,'r.', alpha=0.2)

# # Make the x-axis bounds from -0.6 to 0.6
# plt.setp(axs, xlim=(-0.6,0.6))
# fig2.tight_layout()
# fig2.savefig(out_filepath, dpi=300)
# print('Done WM!')





