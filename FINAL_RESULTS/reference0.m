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
6
12
18
24
32
40
50
58
66
74
84
92
100
108
114
120
];

% Set the speed vector in m/s
TraceRef.SpeedRef = [
0
12
12
4
0
16
24
24
8
0
18
27.78
27.78
12
6
0
0
];

% Set the road slope vector in radian
TraceRef.SlopeRef = [
0
5
8
3
0
4
7
10
5
-1
4
4
3
1
-3
-1
0
]/100;

TraceRef.Laps = 12;

TraceRef.Ts = 1e-2;
tempTime = TraceRef.time(1):TraceRef.Ts:TraceRef.time(end);
TraceRef.SpeedRef = interp1(TraceRef.time,TraceRef.SpeedRef,tempTime);
TraceRef.SlopeRef = interp1(TraceRef.time,TraceRef.SlopeRef,tempTime,'pchip');
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
15
30
45
60
75
90
105
120
];

WindRef.values = [
3
12
24
15
28
8
6
20
4
];

WindRef.Ts = 1e-2;
tempTime = WindRef.time(1):WindRef.Ts:WindRef.time(end);
WindRef.values = interp1(WindRef.time, WindRef.values, tempTime, 'pchip');
WindRef.time = tempTime;
clear tempTime

figure
title('Wind speed profile')
plot(WindRef.time,WindRef.values)
xlabel('Time (s)')
ylabel('Wind speed (m/s)')


LoadRef.time = [
0
25
60
95
130
170
220
270
320
380
430
500
560
];

LoadRef.values = [
0
6000
12500
15000
9000
4000
11000
7000
3000
9500
12000
5000
0
]*scaleF;

LoadRef.Ts = 1e-2;
tempTime = LoadRef.time(1):LoadRef.Ts:LoadRef.time(end);
LoadRef.values = interp1(LoadRef.time, LoadRef.values, tempTime, 'previous');
LoadRef.time = tempTime;
clear tempTime

figure
title('Load profile')
plot(LoadRef.time,LoadRef.values)
xlabel('Time (s)')
ylabel('Load profile (kg)')