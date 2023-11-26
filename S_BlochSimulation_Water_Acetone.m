%% Bloch Simulation

% Description: generation of PC-bSSFP profiles using Bloch Simulations

% Author of function: 
% Nils MJ Plähn, Bern, Switzerland
% E-mail: nils.plaehn@students.unibe.ch
% Department of Diagnostic, Interventional and Pediatric Radiology (DIPR), Inselspital, Bern University Hospital, University of Bern, Switzerland
% Translation Imaging Center (TIC), Swiss Institute for Translational and Entrepreneurial Medicine, Bern, Switzerland

% 1) Based on paper:
% Freeman R, Hill HDW. Phase and intensity anomalies in fourier transform NMR. 
% Journal of Magnetic Resonance (1969). 1971;4(3):366-383. doi:10.1016/0022-2364(71)90047-3
% 2) See Eqn.[2,3,4,5] for Bloch simulations for bSSFP sequence

% 3) Used parameters: 
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

% 3.1) Bloch Simulation specific
% niter:    Amount of iterations used to approach a steady state
% T:        Relaxation matrix within one TR module
% Rx:       Effect of RF-exciation pulse on spins e.g. Roation matrix
%           around x axis
% Rz:       Effect of precession and (counter-acting) phase cycle increment
%           on the magnetization vector i.e. Rotation matrix around the
%           z-axis for one TR module
% bvec:     T1-recovery term for one TR module
% Mvec:     is the (Mx,My,Mz) magnetization vector which is initially in
%           thermal equilibrium (Mvec(0)=(0,0,M0)) and is approaching for
%           increasing iteration steps the steady state magnetization

M0      = 1;                  
alpha   = 35*pi/180;         
Lambda  = 1.4;                
T1      = 3;            
T2      = T1/Lambda; 
nPC     = 38;                 
phit    = linspace(0,2*pi,nPC+1);
phi     = phit(1:nPC);       
deltaCS = -2.48*10^(-6);   % -2.25*10^(-6);  % 

deltaCSw = 1;      
dB0      = 0;     
B0       = 2.89;               
fPD      = 0.36;       %0.36;%
Mw       = M0*(1-fPD);
Ma       = M0*fPD; 

% 3) Sampling of different repetition times TR
TR_exp     = [3.4,3.62,4.11,4.62,4.84,5.14]/1000;  % Experimental value
nTR        = numel(TR_exp); 

gamma = 2*pi*42.577*10^6; 

bSSFP_2comp = zeros(nTR,nPC);

for indTR = 1:nTR
    TR        = TR_exp(indTR);
    TE        = TR/2;          % Experimental value
                
    niter     = 10000;
    theta_W   = -gamma*(dB0+deltaCSw*B0)*TR; 
    theta_A   = -gamma*(dB0+(deltaCS+deltaCSw)*B0)*TR; 
               
    E1   = exp(-TR/T1); 
    E2   = exp(-TR/T2); 
    T    = diag([E2,E2,E1]);
    Rx   = [[1,0,0];[0,cos(alpha),-sin(alpha)];[0,sin(alpha),cos(alpha)]];
    nPC  = numel(phi);

    profile_A = zeros(1,nPC);

    for indPC = 1:nPC
        bvec = [0;0;1-E1].*Ma;
        Mvec = [0;0;Ma];
        x    = theta_A-phi(indPC);    
        Rz   = [[cos(x),-sin(x),0];[sin(x),cos(x),0];[0,0,1]];
        for inditer = 1:niter 
            Mvec = Rx*Rz*T*Mvec+Rx*bvec;
        end
        x       = theta_A*TE/TR;    
        Rz      = [[cos(x),-sin(x),0];[sin(x),cos(x),0];[0,0,1]];
        Mvec    = T.^(0.5)*Rz*Mvec;

        profile_A(indPC) = Mvec(1)+1i*Mvec(2);
    end

    profile_W = zeros(1,nPC);

    for indPC = 1:nPC
        bvec = [0;0;1-E1].*Mw;
        Mvec = [0;0;Mw];
        x    = theta_W-phi(indPC);    
        Rz   = [[cos(x),-sin(x),0];[sin(x),cos(x),0];[0,0,1]];
        for inditer = 1:niter 
            Mvec = Rx*Rz*T*Mvec+Rx*bvec;
        end
        x       = theta_W*TE/TR;    
        Rz      = [[cos(x),-sin(x),0];[sin(x),cos(x),0];[0,0,1]];
        Mvec    = T.^(0.5)*Rz*Mvec;

        profile_W(indPC) = Mvec(1)+1i*Mvec(2);
    end
    
    
    tot  = profile_W+profile_A;

    tot = tot.*exp(-1i.*angle(sum(tot)));

    bSSFP_2comp(indTR,:) = tot;
    indTR
end

% 6) Visualization of all two-compartment profiles for the given TR variation and the sigma choice
h = figure(1); 
subplot(2,3,1)
k = 1; 
polarplot(angle(bSSFP_2comp(k,:)),abs(bSSFP_2comp(k,:)),'ko')
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


















