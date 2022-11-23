# Make a grid of png files from a folder using matplotlib

from matplotlib import pyplot as plt
import os

img_dir='/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/pngs/single_slice_-10to10/combined/'
out_filepath=img_dir+'delay_single_slice_-10to10_lGLMthenvb_grid.png'

SBJ_LIST=('sub-001', 'sub-002', 'sub-003', 'sub-004', 'sub-007', 'sub-008')
SES_LIST=('ses-01', 'ses-02', 'ses-03', 'ses-04', 'ses-05', 'ses-06', 'ses-07', 'ses-08', 'ses-09', 'ses-10')
METHOD=('Both',) # ('lGLM',) #'vb')

num_rows = len(SES_LIST)*len(METHOD)
num_columns = len(SBJ_LIST)

fig = plt.figure(figsize=(num_rows,num_columns)) #, constrained_layout=True)
fig.subplots_adjust(wspace=0, hspace=0)
print('Creating figure with %d rows and %d columns' % (num_rows, num_columns))

# Delay grid
# Loop over all subjects and sessions and plot those that end in .png in fig
for i, SBJ in enumerate(SBJ_LIST):
    for j, SES in enumerate(SES_LIST):
        for k, MET in enumerate(METHOD):
            #img_path=img_dir+SBJ+'_'+SES+'_cvr1_'+MET+'_render.png'
            img_path = img_dir+SBJ+'_'+SES+'_delay.png'
            if os.path.isfile(img_path):
                print('Plotting file: '+img_path)
                ax = fig.add_subplot(num_rows, num_columns, j*num_columns+i+1)
                ax.imshow(plt.imread(img_path))
                ax.set_aspect('equal')
                ax.axis('off')
                #ax.set_title(SBJ+'_'+SES+'_'+MET)
            else:
                print('File does not exist: '+img_path)

fig.subplots_adjust(left=None, bottom=None, right=None, top=None, wspace=None, hspace=None)

fig.savefig(out_filepath, dpi=400)


