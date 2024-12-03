% script used to load the cell peremeters for the cell model in Plecs ('cell_model.plecs')

%% common cell parameters

% parameters for second order RC model
% - the OCV voltage without histeresis (averaged value)
% - RC parameters are the same for the charge and the discharge process 
% - fixed time constants 

% to see the model parameter characteristics run the external script: plot_cell_characteristics

% cell defoult parameters
Qref        = 4.9    *3600;  % cell freference capacity,[C]
Rs_ref      = 0.036;  % reference resistance for standarized charateristic, [ohm]
R1_ref      = 0.036;  % reference resistance for standarized charateristic, [ohm]
R2_ref      = 0.036;  % reference resistance for standarized charateristic, [ohm]
tau1_ref    = 60;           % time constant for R1C1 branch, [s]
tau2_ref    = 700;          % time constant for R2C2 branch, [s]
I_slfDsg    = 0;    % self discharge current, [A]
Q_N         = 5000  *3600;  % cell measured capacity [C]

% border relative values for specific modelling assumtions:
relDOD_FC   = -0.0033; %  relative dod at full charge state of the cell, for 4.2 V end of charging voltage (EOCV) and nearly zero end of charging current (EOCC)
relDOD_FD   =  0.984;  %  relative dod at complete discharge state of the cell, attention: value read from simulation for I_DSG = 0.5 'C' at 2.8 V for specific cell parameters

%% battery parameters: 
% - initiallize all cells with the same parameters
% - parameters of an individual cell are selected in the cell model in Plecs via
%  paramters box (double click on the cell model in Plecs)

NO_cells = 1;       % number of cells


Rs_ref_vector   = Rs_ref * ones(1,NO_cells);
R1_ref_vector   = R1_ref * ones(1,NO_cells);
R2_ref_vector   = R2_ref * ones(1,NO_cells);
Qref_vector     = Qref   * 1;
I_slfDis_vector = I_slfDsg * 0;
%DOD_init_vector = Qref * [relDOD_FC, relDOD_FC, relDOD_FC, relDOD_FC]; % inital DOD due to OCV characteristic and 
%DOD_init_vector = [relDOD_FC * Qref, 0.1 * Q_N + Q_d0, 0.2 * Q_N + Q_d0, 0.2 * Q_N + Q_d0];
DOD_init_vector = 0 * Qref;


%% BMS safety settigns
OCHG_U = 4.25;  % over charge voltage (upper limit) - triger limit 
OCHG_L = 4.2;  % over charge voltage (loweer limit) - reset

ODSG_U = 3.4;   % over charge voltage (upper limit) - reset
ODSG_L = 2.5;   % over charge voltage (lower limit) - triger limit

%% data for the cell characteristics
% to see the model parameter characteristics run the external script: plot_cell_characteristics

% parameters of approximation function for R1 characteristic, 
% approximation function y =  a*exp(b*x-c)+ d + e*x;
R1_aprox_param = [2.407157e-05, 2.277496e+01, 1.025527e+01, 9.997716e-01, 2.278010e-01];  

% parameters of approximation function for R2 characteristic, 
% approximation function y =  a*exp(b*x-c)+ d + e*x;
R2_aprox_param =  [5.073826e-01, 4.540393e+01, 4.246701e+01, 1.000345e+00, 8.132890e-01];

% parameters of approximation function for OCV characteristic,
% approximation function y= a0*exp(a1*(x+a6))+ a2 + a3*x + a4*x.^2 + a5*x^3;
OCV_aprox_param = [-1.6407e+01, 4.5855e+01, 4.1945e+00, -1.6361e+00, 1.647e+00, -7.720e-01, -1.0638e+00];  



