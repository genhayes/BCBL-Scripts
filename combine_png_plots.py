# Make a grid of png files from a folder using matplotlib

from matplotlib import pyplot as plt
import os

img_dir='/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/pngs/single_slice_-10to10/'
out_dir='/export/home/ghayes/public/PJMASK_2/VB_Quantiphyse/Data/links_to_all_maps_postprocessed/pngs/single_slice_-10to10/combined/'
os.mkdir(out_dir)

SBJ_LIST=('sub-001', 'sub-002', 'sub-003', 'sub-004', 'sub-007', 'sub-008')
SES_LIST=('ses-01', 'ses-02', 'ses-03', 'ses-04', 'ses-05', 'ses-06', 'ses-07', 'ses-08', 'ses-09', 'ses-10')
METHOD=('lGLM', 'vb')

num_rows = 2
num_columns = 1
print('Creating figures with %d rows and %d columns' % (num_rows, num_columns))

# Stack CVR maps for each subject and session
# Loop over all subjects and sessions and plot the lGLM and VB maps in their own figures respectively
for i, SBJ in enumerate(SBJ_LIST):
    for j, SES in enumerate(SES_LIST):
        fig = plt.figure(figsize=(num_rows,num_columns))
        out_filepath = out_dir+SBJ+'_'+SES+'_cvr.png'
        for k, MET in enumerate(METHOD):
            img_path=img_dir+SBJ+'_'+SES+'_cvr1_'+MET+'_render.png'
            if os.path.isfile(img_path):
                print('Plotting file: '+img_path)
                ax = fig.add_subplot(num_rows, num_columns, k+1)
                ax.imshow(plt.imread(img_path))
                ax.set_aspect('equal')
                ax.axis('off')
                #ax.set_title(SBJ+'_'+SES+'_'+MET)
                fig.subplots_adjust(wspace=0, hspace=0)
                fig.savefig(out_filepath, dpi=300)
            else:
                print('File does not exist: '+img_path)


# Stack CVR maps for each subject and session
# Loop over all subjects and sessions and plot the lGLM and VB maps in their own figures respectively
for i, SBJ in enumerate(SBJ_LIST):
    for j, SES in enumerate(SES_LIST):
        fig = plt.figure(figsize=(num_rows,num_columns))
        out_filepath = out_dir+SBJ+'_'+SES+'_delay.png'
        for k, MET in enumerate(METHOD):
            img_path=img_dir+SBJ+'_'+SES+'_delay_'+MET+'_render.png'
            if os.path.isfile(img_path):
                print('Plotting file: '+img_path)
                ax = fig.add_subplot(num_rows, num_columns, k+1)
                ax.imshow(plt.imread(img_path))
                ax.set_aspect('equal')
                ax.axis('off')
                #ax.set_title(SBJ+'_'+SES+'_'+MET)
                fig.subplots_adjust(wspace=0, hspace=0)
                fig.savefig(out_filepath, dpi=300)
            else:
                print('File does not exist: '+img_path)

print('Done!')