Phase-cycled bSSFP in two-compartment systems

Contains Matlab code to simulate phase-cycled bSSFP profiles of two-compartment systems using different sign conventions.

#Background: The code was developed to emphasize the different predictions of different phase-signs descriptions in two-compartment systems. 

#Codes: 

Simulation code based on references in the literature:

i) "S_Simulation_twoCompartment_PCbSSFP_literature.m":

Contains the main code. By changing the parameter "Is_Ganter" the effect of different phase sign description can be investigated in two-compartment systems in agreement with literature. 
The comparison of these models with different descriptions is performed using this code. 
The code implements physical values like T1,T2,... and applies superposition principle "Stot=S1+S2" of complex values for the respective single compartment signals, 
which are simulated in the remaining provided code.

ii) "S_bSSFP_Ganter.m":

Contains a aligned phase-sign parameterization based on published work.

iii) "S_bSSFP_Case2.m":

Contains a anti-aligned phase-sign parameterization based on published work .

Parameters and references to literature are included and explanations are provided within the code.

I) "S_Simulation_twoCompartment_PCbSSFP_Sigma.m":

Basically the same as ""S_Simulation_twoCompartment_PCbSSFP_literature.m" but with the sigma parameterization. With "Is_Sigma_0" one selects the different phase description cases and with "IS_RH" the coordinate handedness

II) "S_bSSFP_General.m":

bSSFP signal generation in dependence of handedness and sigma. 
Experimental Data and Codes can be found here: 
https://zenodo.org/records/10017784?token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6IjMzNGFhNGZmLTQ0ODEtNDdjZS1hMzhjLTE1ZDEwNjY4N2RhZCIsImRhdGEiOnt9LCJyYW5kb20iOiIwMjg2YmNlNmUxNjdhZDRmNWY2Y2NjMWU0YjJlZjU3ZCJ9.B9PFbr3weTgOqolpieMDZ0ZW4gPlX13sIfN39vtHV1KYhGrs0DW7UuG7A28tbnkm3-_Mh7ecibqTd_lLcppxXQ

If you have questions or comments on the code, on the theory, phantom or experiment, please contact plaehn.nils@web.de
