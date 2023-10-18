Phase-cycled bSSFP in two-compartment systems

Contains Matlab code to simulate phase-cycled bSSFP profiles of two-compartment systems using different sign conventions.

#Background: The code was developed to emphasize the different predictions of different phase-signs descriptions in two-compartment systems. 

#Codes: 

Simulation code based on references in the literature:

i) "S_Simulation_twoCompartmens_PCbSSFP.m":

Contains the main code. By changing the parameter "Is_Sigma_0" the effect of different phase sign description can be investigated in two-compartment systems. 
These different parameterizations are based on different published works. 
The comparison of these models with different descriptions is performed using this code. 
The code implements physical values like T1,T2,... and applies superposition principle "Stot=S1+S2" of complex values for the respective single compartment signals, 
which are simulated in the remaining provided code.

ii) "S_bSSFP_Sigma_m1.m":

Contains a aligned phase-sign parameterization based on published work.

iii) "S_bSSFP_Sigma_0.m":

Contains a anti-aligned phase-sign parameterization based on published work .

Parameters and references to literature are included and explanations are provided within the code.

Experimental Data and Codes can be found here: 
https://zenodo.org/records/10017784?token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6IjMzNGFhNGZmLTQ0ODEtNDdjZS1hMzhjLTE1ZDEwNjY4N2RhZCIsImRhdGEiOnt9LCJyYW5kb20iOiIwMjg2YmNlNmUxNjdhZDRmNWY2Y2NjMWU0YjJlZjU3ZCJ9.B9PFbr3weTgOqolpieMDZ0ZW4gPlX13sIfN39vtHV1KYhGrs0DW7UuG7A28tbnkm3-_Mh7ecibqTd_lLcppxXQ

If you have questions or comments on the code, on the theory, phantom or experiment, please contact plaehn.nils@web.de
