

%% Snippet code for schematic illustration of linear B0 drift effects on PC BSSFP profile

M0 = 1;
T1 = 0.8; 
T2 = 0.07;

alpha = 15*pi/180; 
TR    = 5/1000; 
TE    = TR/2; 

nPC    = 100; 
phit   = linspace(0,2*pi,nPC);
phi    = phit(1:nPC);
ntheta = nPC; 
thetat = -100+linspace(0,20,ntheta); % B0 drift parameterization

profile = zeros(1,nPC);

for indPC = 1:nPC
    theta = thetat(indPC)*pi/180; 

    profile(indPC) = S_bSSFP_Ganter2(M0,T1,T2,alpha,phi(indPC),TR,TE,theta);
end
tot = profile;
tot = tot.*exp(-1i*angle(sum(tot)));
profile = tot;
figure(1)
polarplot(angle(profile),abs(profile),'o')
title('Schematic illustration of the effect of linear B0 drift on profile')


function profile = S_bSSFP_Ganter2(M0,T1,T2,alpha,phi,TR,TE,theta)
        E1    = exp(-TR./T1);
        E2    = exp(-TR./T2);
        
        a = M0.*(1-E1).*sin(alpha);
        b = 1-E1*E2^2+(E2^2-E1)*cos(alpha);
        c = 2*(E1-1)*E2*cos(alpha/2)^2;
        % MINUS/PLUS in contrast to the sigma=-1 function
        profile = -1i.*a./(b+c.*cos(theta-phi)).*(1-E2.*exp(-1i.*(theta-phi))).*exp(-TE/T2).*exp(1i.*theta*TE/TR); 
end