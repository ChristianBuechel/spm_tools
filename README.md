Tools for SPM

<b>plot_realignment_params.m</b> does exactly that.

<b>spm_spm_lss.m</b> is a fork of spm_spm to quickly do Mumfordian an LS-S analysis from a full
LS-A design matrix. The only thing needed is to add the field SPM.lss_ind to SPM.
Here all columns for which you want an LSS beta image are numbered confounds are marked 
with NaN eg [1 2 3 4 5 NaN NaN NaN NaN NaN NaN] for 5 events and 6 motion paraneters
(this will give lss_beta_0001.nii etc images)
Note that conditions will always be included from left to right, the number is used to name 
the lss_beta image

Caveat: The routine assumes conv(onset(a) + onset(b),hrf) == conv(onset(a),hrf) + conv(onset(b),hrf), 
as it adds hrf convolved columns of the design matrix 
This might not hold for long TRs
No changes are made to SPM.mat

Non-sphericity is performed on the full LS-A model only 
Best use 'None'.
Do each session seperately 

<b>make_atlas.m</b> is a tool to convert single probabilistic ROI images to an atlas that can be used within SPM. 
The example here assembles all images from Brainstem Navigator (https://www.nitrc.org/projects/brainstemnavig/) to an atlas.
  