%% Snippet code for schematic illustration of linear B0 drift effects on PC BSSFP profile

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
% 2.1) Additional B0-drift parameters
% theta_drift: the offresonance value drifts while the phase cycle increments are 
%              successively sampled phase cycle increments
% off:         estimated offresonance value at the start of the acquisition

M0      = 1;                  
alpha   = 35*pi/180;         
Lambda  = 1.4;                
T1      = 3;            
T2      = T1/Lambda; 
TR      = 4.84/1000; 
TE      = TR/2; 

nPC    = 38; 
phit   = linspace(0,2*pi,nPC+1);
phi    = phit(1:nPC);
ntheta = nPC;

IS_1Comp =  false; %true;


deltaCSw = 0; 
gamma = 2*pi*42.577*10^6; 
dB0      = 0;     
B0       = 2.89;
if IS_1Comp==true
    fPD = 0; 
else
    fPD      = 0.6;      
end
deltaCS  = -2.25*10^(-6); 

% Theta drift parameterization found to be
if IS_1Comp==true
    off = -110; 
else
    off = -230;   
end


theta_drift = linspace(0,20,ntheta); % B0 drift parameterization
theta_drift = off+theta_drift;
profile_w = zeros(1,nPC);
profile_A = zeros(1,nPC);

for indPC = 1:nPC
    theta_w   = theta_drift(indPC)*pi/180-gamma*(dB0+deltaCSw*B0)*TR; 
    theta_A   = theta_drift(indPC)*pi/180-gamma*(dB0+(deltaCS+deltaCSw)*B0)*TR; 
    profile_w(indPC) = S_bSSFP_Ganter2(M0*(1-fPD),T1,T2,alpha,phi(indPC),TR,TE,theta_w);
    profile_A(indPC) = S_bSSFP_Ganter2(M0*fPD,T1,T2,alpha,phi(indPC),TR,TE,theta_A);
end
tot = profile_w+profile_A;
tot = tot.*exp(-1i*angle(sum(tot)));
profile = tot;
h = figure(2);
polarplot(angle(profile),abs(profile),'ko','Markersize',4,'LineWidth', 3);
h.Position   = [100 100 600 600];
ax           = gca;
ax.GridColor ='k';
ax.LineWidth = 3;
ax.FontSize  = 20;
% title('Schematic illustration of the effect of linear B0 drift on profile')
if IS_1Comp == true
    str = append('B0drift_1Comp.png');
    saveas(gcf,str)
else 
    str = append('B0drift_2Comp.png');
    saveas(gcf,str)
end

function profile = S_bSSFP_Ganter2(M0,T1,T2,alpha,phi,TR,TE,theta)
        E1    = exp(-TR./T1);
        E2    = exp(-TR./T2);
        
        a = M0.*(1-E1).*sin(alpha);
        b = 1-E1*E2^2+(E2^2-E1)*cos(alpha);
        c = 2*(E1-1)*E2*cos(alpha/2)^2;
        % MINUS/PLUS in contrast to the sigma=-1 function
        profile = -1i.*a./(b+c.*cos(theta-phi)).*(1-E2.*exp(-1i.*(theta-phi))).*exp(-TE/T2).*exp(1i.*theta*TE/TR); 
end