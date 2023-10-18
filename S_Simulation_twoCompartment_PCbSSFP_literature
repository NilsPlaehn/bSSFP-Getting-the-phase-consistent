
% Description: generation of two-compartment PC-bSSFP profiles for the
%              sigma=0 and sigma=-1 cases

% Author of code: 
% Nils MJ Plähn, Bern, Switzerland
% E-mail: nils.plaehn@students.unibe.ch
% Department of Diagnostic, Interventional and Pediatric Radiology (DIPR), Inselspital, Bern University Hospital, University of Bern, Switzerland
% Translation Imaging Center (TIC), Swiss Institute for Translational and Entrepreneurial Medicine, Bern, Switzerland

% 1)   See papers e.g.:
% 1.1) sigma=0
% i)
% Ganter C. Steady state of gradient echo sequences with radiofrequency phase cycling: 
% Analytical solution, contrast enhancement with partial spoiling. 
% Magn. Reson. Med. 2006;55:98–107 doi: 10.1002/mrm.20736
% ii) 
% Zur Y, Wood ML, Neuringer LJ. Motion-insensitive, steady-state free precession imaging.
% Magn. Reson. Med. 1990;16:444–459 doi: 10.1002/mrm.1910160311
% 1.2) sigma=-1:
% i)
% Shcherbakova Y, Berg CAT van den, Moonen CTW, Bartels LW. PLANET: 
% An ellipse fitting approach for simultaneous T1 and T2 mapping using
% phase-cycled balanced steady-state free precession. Magn. Reson. Med. 2018;79:711–722 doi: 10.1002/mrm.26717
% ii) 
% Shcherbakova Y, van den Berg CAT, Moonen CTW, Bartels LW. On the accuracy and precision of PLANET 
% for multiparametric MRI using phase-cycled bSSFP imaging. 
% Magn. Reson. Med. 2019;81:1534–1552 doi: 10.1002/mrm.27491

% 2) Used parameters: 
% M0:       polarized magnetization of the substance, i.e. PD ( 1^H proton density)
% T1:       longitudinal relaxation time
% T2:       transversal  relaxation time
% alpha:    excitation angle of RF pulse
% phi:      linear phase increment of RF excitation pulse
% TR:       repetition time of each PC-bSSFP module
% TE:       echo time of each PC-bSSFP module
% theta:    accumulated phase 
% gamma:    gyromagnetic ratio for 1H protons
% B0:       main magnetic field strength
% dB0:      B0 inhomogeneity
% deltaCS:  chemical shift of acetone w.r.t water
% deltaCSw: chemical shift of water
% fPD:      Proton density fraction of acetone w.r.t. water      
M0      = 1;                  % M0 is an arbitrary extensive unit
alpha   = 35*pi/180;          % Experimental value
% Relaxations times of water and acetone are assumed to be equal and high 
% due to Bloembergen-Purcell-Pound theory
Lambda  = 1.4;                % T1/T2 ratio
T1      = 3;            
T2      = T1/Lambda; 
nPC     = 38;                 % Number of sampled PC increments
phit    = linspace(0,2*pi,nPC+1);
phi     = phit(1:nPC);        % linear sampling of PC increments =[0,2*pi[
%phi     = -phi;              % Note: sign of PC-increment does not change
                              % trajectories, i.e. phi=-phi leads to same
                              % shape
deltaCS = -2.25*10^(-6);      % Experimental value for chemical shift of acetone w.r.t. water 
                              % Experiental estimations: PC-bSSFP -2.25+-0.03ppm and NMR is -2.32+-0.09ppm
                              % DANGER NOTE: deltaCS=-deltaCS lead to a complex conjugation which appears as a
                              % f=0.4 acetone fraction instead 0.6 fraction (in right handed coordinate frame).
                              % Hence the sign of the CS is important and shouln't be changed!
                              % The sign convention in combination of the "S_bSSFP_Sigma_0.m" function
                              % follows the physical ground truth that Acetone has a higher B0 field screening effect (lenz rule)
                              % than the protons of water. In water the high electronegativity of the oxygen atom
                              % "steals" all the surounding electrons of the water hydrogene atoms. This leads to least 
                              % screening effect of water protons in presence of B0 field because (almost) no electrons are in ambient 
                              % surounding of the hydrogene protons to cause a screening effect based on Lenz' rule.
                              % Carbon atoms of acetone exhibit lower electronegativity than the oxygen of water and hence the screening effect
                              % is higher for the acetone protons. The higher screening effect is diamagnetic and leads to a lowering of the 
                              % effective field acting on the acetone protons. Because the chemical shift is defined within the accumulated phase 
                              % theta = -gamma*(dB0+deltaCS*B0)*TR the "deltaCS" term of acetone must be negative to model for the lower effective 
                              % field acting on the acetone protons. 
                              % Or short: The chemical shift needs to act opposite to dB0 for acetone if water is at 0ppm.
                              % Hence the sign of acetone CS must be negative.  
deltaCSw = randn(1)*100;      % Arbitrary: does not lead to a difference of the shape up
                              % to a global phase factor and inherent
                              % rotation of points onto the same trajectory 
dB0     = 1000*randn(1);      % Also arbitrary: does not lead to a difference of the shape up
                              % to a global phase factor and inherent
                              % rotation of points onto the same trajectory
B0      = 2.89;               % Experimental value
fPD     = 0.6;                % Experimental value
                             
% 3) Sampling of different repetition times TR
TR_exp     = [3.4,3.62,4.11,4.62,4.84,5.14]/1000;  % Experimental value
nTR        = numel(TR_exp); 
% 4) Choose whether (Ganter,Zur,Ernst,...) model is used or different phase
% description
Is_Ganter = true; 


% 5) Generate superimposed signals
bSSFP_2comp = zeros(nTR,nPC);
for indTR = 1:nTR
    TR            = TR_exp(indTR);
    TE            = TR/2;          % Experimental value
    profile_water = zeros(1,nPC);
    profile_Ace   = zeros(1,nPC);
    for indPC = 1:nPC
        if Is_Ganter == true
            profile_water(indPC) = S_bSSFP_Ganter(M0,T1,T2,alpha,phi(indPC),TR,TE,deltaCSw,dB0,B0);
            profile_Ace(indPC)   = S_bSSFP_Ganter(M0,T1,T2,alpha,phi(indPC),TR,TE,deltaCS+deltaCSw,dB0,B0);
        else
            profile_water(indPC) = S_bSSFP_Case2(M0,T1,T2,alpha,phi(indPC),TR,TE,deltaCSw,dB0,B0);
            profile_Ace(indPC)   = S_bSSFP_Case2(M0,T1,T2,alpha,phi(indPC),TR,TE,deltaCS+deltaCSw,dB0,B0);
        end
    end
    % Superposition principle
    tot = (1-fPD)*profile_water+fPD*profile_Ace;
    % rotation of global phase by the angle of complex sum
    tot = tot.*exp(-1i.*angle(sum(tot)));
    % save two compartment profile
    bSSFP_2comp(indTR,:) = tot; 
end

% 6) Visualization of all two-compartment profiles for the given TR variation and the sigma choice
h = figure(1); 
subplot(2,3,1)
k = 1; 
polarplot(angle(bSSFP_2comp(k,:)),abs(bSSFP_2comp(k,:)),'ko')
if Is_Sigma_0 == true
    title(['Sigma=0: TR = ' num2str(TR_exp(k)*1000) ' ms'])
else
    title(['Sigma=-1: TR = ' num2str(TR_exp(k)*1000) ' ms'])
end
subplot(2,3,2)
k = 2; 
polarplot(angle(bSSFP_2comp(k,:)),abs(bSSFP_2comp(k,:)),'ko')
title(['TR = ' num2str(TR_exp(k)*1000) ' ms'])
subplot(2,3,3)
k = 3; 
polarplot(angle(bSSFP_2comp(k,:)),abs(bSSFP_2comp(k,:)),'ko')
title(['TR = ' num2str(TR_exp(k)*1000) ' ms'])
subplot(2,3,4)
k = 4; 
polarplot(angle(bSSFP_2comp(k,:)),abs(bSSFP_2comp(k,:)),'ko')
title(['TR = ' num2str(TR_exp(k)*1000) ' ms'])
subplot(2,3,5)
k = 5; 
polarplot(angle(bSSFP_2comp(k,:)),abs(bSSFP_2comp(k,:)),'ko')
title(['TR = ' num2str(TR_exp(k)*1000) ' ms'])
subplot(2,3,6)
k = 6; 
polarplot(angle(bSSFP_2comp(k,:)),abs(bSSFP_2comp(k,:)),'ko')
title(['TR = ' num2str(TR_exp(k)*1000) ' ms'])

h.Position = [200 200 900 500];
    
% 7) Visualization of individual TR PC-bSSFP profile

indTR   = 6;                    % indTR selects profile of repetition time choice TR_exp(indTR)
profile = bSSFP_2comp(indTR,:); 

h = figure(2);
polarplot(angle(profile),abs(profile),'ko','Markersize',14,'LineWidth', 3);
h.Position   = [100 100 600 600];
ax           = gca;
ax.GridColor ='k';
ax.LineWidth = 3;
ax.FontSize  = 20; 





