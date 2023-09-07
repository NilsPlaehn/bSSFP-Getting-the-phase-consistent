function profile = S_bSSFP_Sigma_m1(M0,T1,T2,alpha,phiPC,TR,TE,deltaCS,dB0,B0)
% Description: generation of PC-bSSFP profiles for aligned signs

% Author of function: 
% Nils MJ Plähn, Bern, Switzerland
% E-mail: nils.plaehn@students.unibe.ch
% Department of Diagnostic, Interventional and Pediatric Radiology (DIPR), Inselspital, Bern University Hospital, University of Bern, Switzerland
% Translation Imaging Center (TIC), Swiss Institute for Translational and Entrepreneurial Medicine, Bern, Switzerland

% 1)See papers e.g.:
% i)
% Shcherbakova Y, Berg CAT van den, Moonen CTW, Bartels LW. PLANET: 
% An ellipse fitting approach for simultaneous T1 and T2 mapping using
% phase-cycled balanced steady-state free precession. Magn. Reson. Med. 2018;79:711–722 doi: 10.1002/mrm.26717
% ii) 
% Shcherbakova Y, van den Berg CAT, Moonen CTW, Bartels LW. On the accuracy and precision of PLANET 
% for multiparametric MRI using phase-cycled bSSFP imaging. 
% Magn. Reson. Med. 2019;81:1534–1552 doi: 10.1002/mrm.27491

% 2) Used parameters: 
% M0:      polarized magnetization of the substance, i.e. PD ( 1^H proton density)
% T1:      longitudinal relaxation time
% T2:      transversal  relaxation time
% alpha:   excitation angle of RF pulse
% phiPC:   linear phase increment of RF excitation pulse
% TR:      repetition time of each PC-bSSFP module
% TE:      echo time of each PC-bSSFP module
% gamma:   gyromagnetic ratio for 1H protons
% B0:      main magnetic field strength
% dB0:     B0 inhomogeneity
% deltaCS: chemical shift

% 3) following parameterization orients base onto the defintions of paper (i,ii)

        gamma       = 2*pi*42.577*10^6; 
        E1          = exp(-TR./T1);
        E2          = exp(-TR./T2);
        % note: For the "phi" defintion additional constant phase terms are given in paper (i), 
        % while this leads only to a global phase shift and hence they are all set
        % to zero for this simulation. 
        % tot = tot.*exp(-1i.*angle(mean(tot))) is performed in the main code to
        % correct for this arbitrariness anyway
        phi         = gamma*(dB0+deltaCS*B0)*TE;
        theta0      = gamma*(dB0+deltaCS*B0)*TR;
        % note: The sampling of phiPC in paper(i) starts at 180°, while other paper
        % start at 0° which is however not affecting the resulting profile shapes
        theta       = theta0-phiPC; 
        % note the negative sign of phiPC which follows "left handedness convention"
        % it does not affect the shape as discussed in theory section of the Note but
        % the rotation sense of the profile in complex plane is clockwise
        % instead to [Zur,Ganter]. This is not a problem and only mentioned
        % for completeness. For plausibility the sign of phiPC can be inverted which will
        % lead to equal trajectories.
        denominator = 1-E1.*cos(alpha)-E2.^2.*(E1-cos(alpha));  % auxiliary defintion
        M           = M0.*(1-E1).*sin(alpha)./denominator; 
        K           = 1;                                        % "K is the magnitude of the combined receive field" (i)
                                                                % -> extensive global magnitude scales do not change shape
                                                                % of the profile and hence K=1 is chosen for this function
        Meff        = K.*M.*exp(-TE/T2);
        b           = E2.*(1-E1).*(1+cos(alpha))./denominator;
        a           = E2; 
 
        % Note: the first exponent theta0 has the same sign to the second exponent phi=theta0*TE/TR 
        % i.e. ~(1-E2*exp(1i*(theta0-phiPC)))*exp(1i*theta0*TE/TR) is
        % PLUS/PLUS in contrast to the opposite sign function
        % The sign of phiPC is negative in contrast to the opposite sign function
        % This does not lead to different shapes of the trajectory as can be checked
        % by an inversion of the phiPC sign 
        profile = Meff.*(1-a.*exp(1i.*theta))./(1-b.*cos(theta)).*exp(1i.*phi); 
end