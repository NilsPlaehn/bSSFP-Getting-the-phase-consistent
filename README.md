# Phase-cycled bSSFP in two-compartment systems

Matlab code to simulate phase-cycled bSSFP profiles of two-compartment systems using different phase descriptions.

**********
Available codes: 

1) "S_Simulation_twoCompartment_PCbSSFP_literature.m":

Contains the main code. By changing the parameter "Is_Ganter" one can visualize the effect of different phase descriptions on phase-cycled bSSFP profiles obtained in two-compartment systems. The simulation includes physical values such as T1 and T2. The simulation applies the superposition principle on single component signals.

2) "S_bSSFP_Ganter.m":

Contains the correct phase description to be used to describe multi-compartment PC bSSFP profiles. 

3) "S_bSSFP_Case2.m":

Contains the incorrect phase description to describe multi-compartment PC bSSFP profiles. 

4) "S_Simulation_twoCompartment_PCbSSFP_Sigma.m":

Similar to i) "S_Simulation_twoCompartment_PCbSSFP_literature.m" but using a different parameterization. With the selection of "Is_Sigma_0"  the different phase description options can be selected and with  "IS_RH" the coordinate handedness can be selected.

5) "S_bSSFP_General.m":

bSSFP signal generation in dependent on the coordinate system handedness and the phase description definition. 

6) "BlochSImulation_Acetone_Water.m"

Includes a simulation code based on Bloch equation for the iterative simulation of the same profile shapes as a possible alternative.

7) "E1_ExperimentalReadout_below4msTR"

Contains the readout code for PC-bSSFP experimental data found on Zenodo for TR<4ms.

8) "E_ExperimentalReadout_above4msTR.m"

Contains the readout code for PC-bSSFP experimental data found on Zenodo for TR>4ms.

9) "E_Spectrum_plots.m"

Contains the readout code for spectroscopic experimental data found on Zenodo.

***********
Experimental data can be found on the following public repository: 

https://zenodo.org/records/10017784


