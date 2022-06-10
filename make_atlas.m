function make_atlas

path_images = 'c:\Users\buechel\Documents\MATLAB\brainstem_navigator\images\labels_probabilistic\';
% You need to use the *probabilistic* unthresholded images!
% I have simply copied all the Diencephalic and the Brainstem images in one
% dir
% Cave: check the space you are working in (MNI in most cases)

% get all images
all = spm_select('FPList', path_images,'gz$');

all_names = [];
for g=1:size(all,1)
    [~,n,~] = fileparts(all(g,:));
    [~,n,~] = fileparts(n); % because of *.nii.gz
    all_names{g,1} = num2str(g);
    all_names{g,2} = n;
end

% Let's save it as a textfile
spm_save([path_images 'brainstem_nav.tsv'],all_names);

% assemble atlas index image
V_all    = spm_vol(all);
data     = spm_read_vols(V_all);
[~, ind] = max(data,[],4); %find which structures has highest prob

V_out         = V_all(1);
V_out.fname   = [path_images 'brainstem_nav.nii'];
V_out.dt(1)   = spm_type('uint16');
V_out.descrip = 'brainstem_nav';
spm_write_vol(V_out,ind);

% then copy both the *.tsv and the *.nii to /spm12/atlas and cd into this dir and run
% spm_atlas('save_labels','brainstem_nav.xml',spm_atlas('import_labels','brainstem_nav.tsv'));
% spm_atlas('load','brainstem_nav')



