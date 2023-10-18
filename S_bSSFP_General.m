function profile = S_bSSFP_General(M0,T1,T2,alpha,phi,TR,TE,deltaCS,dB0,B0,Is_Sigma_0,IS_RH)

% Description: generation of PC-bSSFP profiles for general-signs

% Author of function: 
% Nils MJ Plähn, Bern, Switzerland
% E-mail: nils.plaehn@students.unibe.ch
% Department of Diagnostic, Interventional and Pediatric Radiology (DIPR), Inselspital, Bern University Hospital, University of Bern, Switzerland
% Translation Imaging Center (TIC), Swiss Institute for Translational and Entrepreneurial Medicine, Bern, Switzerland

% 1)See papers e.g.:
% i)
% Ganter C. Steady state of gradient echo sequences with radiofrequency phase cycling: 
% Analytical solution, contrast enhancement with partial spoiling. 
% Magn. Reson. Med. 2006;55:98–107 doi: 10.1002/mrm.20736
% ii) 
% Zur Y, Wood ML, Neuringer LJ. Motion-insensitive, steady-state free precession imaging.
% Magn. Reson. Med. 1990;16:444–459 doi: 10.1002/mrm.1910160311

% 2) Used parameters: 
% M0:      polarized magnetization of the substance, i.e. PD ( 1^H proton density)
% T1:      longitudinal relaxation time
% T2:      transversal  relaxation time
% alpha:   excitation angle of RF pulse
% phi:     linear phase increment of RF excitation pulse
% TR:      repetition time of each PC-bSSFP module
% TE:      echo time of each PC-bSSFP module
% theta:   accumulated phase 
% gamma:   gyromagnetic ratio for 1H protons
% B0:      main magnetic field strength
% dB0:     B0 inhomogeneity
% deltaCS: chemical shift

% 3) following parameterization orients base onto the defintions of the Note whose link will be shared
%    as soon as it gets accepted and based onto paper (i,ii) 
 
        if Is_Sigma_0==true
            Theta_TE_sign = 1;
        else
            Theta_TE_sign = -1; 
        end



        gamma = 2*pi*42.577*10^6; 

        E1    = exp(-TR./T1);
        E2    = exp(-TR./T2);
        theta = -gamma*(dB0+deltaCS*B0)*TR;  
        
        a = M0.*(1-E1).*sin(alpha);
        b = 1-E1*E2^2+(E2^2-E1)*cos(alpha);
        c = 2*(E1-1)*E2*cos(alpha/2)^2;
        % Note: the first exponent theta has opposite sign to the second exponent theta 
        % i.e. ~(1-E2*exp(-1i*(theta-phi)))*exp(1i*theta*TE/TR) is
        % MINUS/PLUS in contrast to the sigma=-1 function
        profile = -1i*a/(b+c*cos(theta-phi))*(1-E2*exp(-1i*(theta-phi)))*exp(-TE/T2)*exp(1i*theta*TE/TR*Theta_TE_sign); 
        if IS_RH==false
            profile = conj(profile); % since a change of coordinate handedness is just a complex conjugation
            % E.g. M(RH)=Mx+i*My -> M(LH) = conj(M(RH))=conj(Mx+i*My)=Mx-i*My q.e.d.
        end

end
