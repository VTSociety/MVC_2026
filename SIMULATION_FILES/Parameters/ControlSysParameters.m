%% VTS Motor Vehicles Challenge 2026
% Ludovico Ortombina
% Department of Industrial Engineering
% University of Padova, Italy
% Fabio Tinazzi
% Department of Management and Engineering
% University of Padova, Italy
% Binh Minh Nguyen
% Department of Advanced Energy
% The University of Tokyo, Japan
% Yuki Hosomi
% Department of Advanced Energy
% University of Tokyo, Japan
% Yusaku Takagi
% Department of Advanced Energy
% University of Tokyo, Japan
% Hiroshi Fujimoto
% Department of Advanced Energy
% University of Tokyo, Japan
% https://github.com/VTSociety/MVC_2026 

%% Control parameters
	
% Motor current loops parameters
CTRLpmsm.Front.fci = 5e2;
CTRLpmsm.Front.kpd = 2*pi*CTRLpmsm.Front.fci*MOT.Front.Ld;				
CTRLpmsm.Front.kid = CTRLpmsm.Front.kpd*MOT.Front.R/MOT.Front.Ld;
CTRLpmsm.Front.kpq = 2*pi*CTRLpmsm.Front.fci*MOT.Front.Lq;				
CTRLpmsm.Front.kiq = CTRLpmsm.Front.kpq*MOT.Front.R/MOT.Front.Lq;
CTRLpmsm.Rear.fci = 5e2;
CTRLpmsm.Rear.kpd = 2*pi*CTRLpmsm.Rear.fci*MOT.Rear.Ld;				
CTRLpmsm.Rear.kid = CTRLpmsm.Rear.kpd*MOT.Rear.R/MOT.Rear.Ld;
CTRLpmsm.Rear.kpq = 2*pi*CTRLpmsm.Rear.fci*MOT.Rear.Lq;				
CTRLpmsm.Rear.kiq = CTRLpmsm.Rear.kpq*MOT.Rear.R/MOT.Rear.Lq;