# SydSGM_Parcellation
![SydSGM_parcellation_github](https://github.com/user-attachments/assets/d47c6338-fae6-4f39-a038-c4b6e6e273c2)


This repository releases codes for the following paper.

Tonima Ali, Jinglei Lv, Mustafa Kassem et al. In-vivo parcellation of human subcortex by multi-modal MRI, 14 April 2024, PREPRINT (Version 1) available at Research Square [https://doi.org/10.21203/rs.3.rs-4203104/v1]

Our population template and subcortical parcellation is open source and can be found here: https://osf.io/pmuez/

Please cite this paper if you use any of the scripts, templates, and parcellation. CC0 1.0 Universal.

Implementation of these codes do not require installation of any newly developed software. Below is the list of the well-known and well-used software platforms used in this project.

Required softwares: Mrtrix 3.0 (https://www.mrtrix.org/), Freesurfer 7.4 (https://surfer.nmr.mgh.harvard.edu/), FSL 6.0 (https://fsl.fmrib.ox.ac.uk/fsl/docs/), and Matlab R2022b (https://au.mathworks.com/products/matlab.html)

Instrutcions for installation of these software and additional requirements can be found in the associated pages as mentioned above.

Instructions for computing SydSGM parcellation:

The parcellation comprises of 3 major segments: (1) generation of population template, (2) computation of parametric maps, and (3) Hierarchical bi-modal clustering. T1w, T2w and diffusion MRI, all obtained from Human Connectome Project (HCP) are used for this pipeline. 

All of the structural (T1 and T2) and diffusion MRI data can be downloaded from publicly available Human Connectome Project [1,2]. Below are the ID numbers of the subjects that were analysed in this project: 100206 103111 107018 100307 103212 107321 100408 103414 107422 100610 103515 107725 101006 103818 108020 101107 104012 108121 101309 104416 108222 101410 104820 108323 101915 105014 108525 102008 105115 108828 102109 105216 109123 102311 105620 109830 102513 105923 110007 102614 106016 110411 102715 106319 110613 102816 106521 111009 103010 106824.

Due to space constraint, a sample dataset (Sample_data.zip) consisting data from 5 subjects is provided (https://osf.io/pmuez/) along with the parcellation for ease of access. 

Below are the pseudocodoes for the steps/scripts that were implemented to attain the SydSGM parcellation.

Step 1:  please refer to the scripts released here https://github.com/Jinglei-Lv/Tissue_Unbiased_FOD_Tractogram_Template for the generation of the 50-subject population template. 

Step 2_1: 2_1_compute_parametric_maps.sh

Step 2_2: 2_2_multimodal_reg_apply2fod.sh

Step 2_3: 2_3_warp_images_HDf50*.sh

Step 2_4: 2_4_warp_DEC_HDf50.sh

Step 2_5: 2_5_Generate_fiber_warps_HD.sh

Step 2_6: 2_6_warp_fibres*.sh

Step 3_1: 3_1_compute_subcortical_mask.m

Step 3_2: 3_2_bimodal_clustering.m

*Time required for completing the scripts may vary depending on the strength of the computer (such as CPU architecture, number of cores, etc.). For each subject, computation of parametric maps is expected to take about 3 hours, recon-all about 24 hours, and FSL based segmentation about 4 hours. Computation of multi-modal population template is likely to take 24 hours, warping of all 3D volumes about 200 (50 x 4) hours, generationof fibre tracks, SIFT, and tract warps about 600 (50 x 12) hours, and the computation of subcortical masks about 4 hours. Princical componant analysis and hiararchical bomidal clustering of all caudate, putamen, globus pallidus, nucleus accumbens and thalamus is like to take about 300 hours.    

[1] Van Essen DC, Smith SM, Barch DM, Behrens TE, Yacoub E, Ugurbil K, Wu-Minn HCP Consortium. The WU-Minn human connectome project: an overview. Neuroimage. 2013 Oct 15;80:62-79.
[2] Van Essen DC, Ugurbil K, Auerbach E, Barch D, Behrens TE, Bucholz R, Chang A, Chen L, Corbetta M, Curtiss SW, Della Penna S. The Human Connectome Project: a data acquisition perspective. Neuroimage. 2012 Oct 1;62(4):2222-31.
