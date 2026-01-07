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

% Set the time vector:
TraceRef.time = [
0 
5
10
15
20
30
37.5
47.5
55;
60;
65;
80;
98;
105
120;
140;
155;
160;
];

% Set the speed vector in m/s
TraceRef.SpeedRef = [
0 
10 
10 
0
0
20 
20 
0 
0 
7
10
10
0
0
30
30
0
0
];

% Set the road slope vector in radian
TraceRef.SlopeRef = [
0 
10 
7 
1
0
3 
6 
0 
0 
4
10
3
-2
0   
3
4
0
0
]/100;

TraceRef.Laps = 8;

TraceRef.Ts = 1e-2;
tempTime = TraceRef.time(1):TraceRef.Ts:TraceRef.time(end);
TraceRef.SpeedRef = interp1(TraceRef.time,TraceRef.SpeedRef,tempTime);
TraceRef.SlopeRef = interp1(TraceRef.time,TraceRef.SlopeRef,tempTime,'spline');
TraceRef.time = tempTime;

% Position reference in meter
TraceRef.PosRef = cumsum(TraceRef.SpeedRef)*TraceRef.Ts;
clear tempTime

figure
title('Track definition')
yyaxis right
plot(TraceRef.time,TraceRef.PosRef)
xlabel('Time (s)')
ylabel('Position (m)')
yyaxis left
plot(TraceRef.time,TraceRef.SpeedRef)
ylabel('Speed (m/s)')

figure
title('Track definition')
yyaxis right
plot(TraceRef.time,TraceRef.SlopeRef)
xlabel('Time (s)')
ylabel('Road slope (rad)')
yyaxis left
plot(TraceRef.time,TraceRef.SpeedRef)
ylabel('Speed (m/s)')


WindRef.time = [
0
25
40
70
80
90
100
115
];

WindRef.values = [
0
10
30
10
30
30
10
0
]/2;

WindRef.Ts = 1e-2;
tempTime = WindRef.time(1):WindRef.Ts:WindRef.time(end);
WindRef.values = interp1(WindRef.time, WindRef.values,tempTime,'spline');
WindRef.time = tempTime;
clear tempTime

figure
title('Wind speed profile')
plot(WindRef.time,WindRef.values)
xlabel('Time (s)')
ylabel('Wind speed (m/s)')


LoadRef.time = [
0 
17
53
104
158
160
213
264
317
320
337
373
424
477
480
];

LoadRef.values = [
10000
7500
5000
2500
0
0
12500
7800
6000
1000
7000
6000
2000
1500
0
]*scaleF;

LoadRef.Ts = 1e-2;
tempTime = LoadRef.time(1):LoadRef.Ts:LoadRef.time(end);
LoadRef.values = interp1(LoadRef.time, LoadRef.values, tempTime,'previous');
LoadRef.time = tempTime;
clear tempTime

figure
title('Load profile')
plot(LoadRef.time,LoadRef.values)
xlabel('Time (s)')
ylabel('Load profile (kg)')
