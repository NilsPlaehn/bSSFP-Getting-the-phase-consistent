%% Description: Experimental readout of acetone-water-compartment PC-bSSFP profiles

%% Author of code: 
% Nils MJ Plähn, Bern, Switzerland
% E-mail: nils.plaehn@students.unibe.ch
% Department of Diagnostic, Interventional and Pediatric Radiology (DIPR), Inselspital, Bern University Hospital, University of Bern, Switzerland
% Translation Imaging Center (TIC), Swiss Institute for Translational and Entrepreneurial Medicine, Bern, Switzerland

%% 0) Scan parameters where: 

% RF excitation angle: 35°
% Repetion times TR:   [4.11,4.62,4.84,5.14]ms
% Echo times TE:       TE=TR/2  
% number of PC:        18
% remaining parameters are described in the Note

%% 1) Choose a PC-bSSFP experiment with corresponding TR value
%S              = load('PCbSSFP_Matrix_ACE_4p11.mat');
%S              = load('PCbSSFP_Matrix_ACE_4p62.mat');
%S              = load('PCbSSFP_Matrix_ACE_4p84.mat');
S              = load('PCbSSFP_Matrix_ACE_5p14.mat');
PCbSSFP_Matrix = S.ergmat_whis_slabsel_lowSAR; 

%% 2) Complex conjugation of Siemens 3T data

% Siemens uses left-handed coordinate system which can lead to confusion if
% one is familiar with right handed coordinate systems as the default
% choice
% Because eq(1-5) are all right handed I also want 
% right-handed coordinates for the experimental data
% Right-handed would be following: Mright = Mx+i*My
% Left-handed however follows;     Mleft  = Mx-i*My
% "complex conjugtation" of conj(Mleft)=conj(Mx-iMy)=Mx+i*My=Mright
% leads to a transformation from left to right handed coordinates for
% experimental data

PCbSSFP_Matrix = conj(PCbSSFP_Matrix);

%% 3) Set dimensions
Nx    = size(PCbSSFP_Matrix,1);
Ny    = size(PCbSSFP_Matrix,2);
Nz    = size(PCbSSFP_Matrix,3);
nPC   = size(PCbSSFP_Matrix,4);
slice = 6;              % Choice of slice one needs to visualize

%% 4) Load the mask for the 60% acetone vial
S        = load('mask_vial60percent_above4msTR.mat');
mask_raw = S.mask_dicom;

%% 5) Plot ellipses within the ROI of the mask

close all;

for indx = 1:Nx
    for indy = 1:Ny
        if mask_raw(indx,indy)>0
            % get PC-bSSFP profile in the ROI of the mask
            profile      = squeeze(PCbSSFP_Matrix(indx,indy,slice,:));
            % normalize the magnitude
            profile      = profile/mean(abs(profile));
            % rotate profile by negative angle of complex mean
            meanangle    = angle(mean(profile));
            profile      = profile.*exp(-1i*meanangle);
            % visualize profiles of the vial on stack of each other
            h            = figure(1);
            polarplot(angle(profile),abs(profile),'o','Markersize',3,'LineWidth',3);
            h.Position   = [100 100 600 600];
            ax           = gca;
            ax.GridColor ='k';
            ax.LineWidth = 3;
            ax.FontSize  = 20; 
            hold on;
        end
        
    end
end


%saveas(gcf,'Note_Experiment_4p11.png')
%saveas(gcf,'Note_Experiment_4p62.png')
%saveas(gcf,'Note_Experiment_4p84.png')
%saveas(gcf,'Note_Experiment_5p14.png')


