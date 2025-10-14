%% Define distances between position

clear all
close all

nameRef             = "reference_FT";

nScale              = 1/60;

TraceRef.Laps       = 2;

TraceRef.Ts         = 2e-2;

% Distance: specify in km, the variable will be in metres
Trace.distances     = [1    3   2   5   1   1]*1e3;      % km
% time to cover the length: input minutes, the variable will be in seconds
Trace.timeLength    = [1    2   2   4   1   0.6]*60;       %
% Load: input tons, the variable will be in kg
Trace.load          = [0    2   1   4   5   1]*1e3;      % kg

Trace.waitingTime   = ones(size(Trace.distances))*60;    % minute

% Set the road slope vector in percentage
TraceRef.SlopeRef   = [0    0 10  -4   -6   0]/100;

WindRef.values = [0 10 30 30 0 0]; % (m/s)



% To cover each distance, the vehicle starts from rest, accelerates to the speed defined in Trace.speed_ms, then decelerates to rest at the end of each distance.
% The acceleration and deceleration are assumed to be constant, and the time to accelerate or decelerate is half of the time length for each distance.
Trace.acceleration = 0.5; % m/s^2
Trace.deceleration = 1; % m/s^2

%% Get profile

% Get the speed between each position
Trace.speed_kmh = Trace.distances ./ (Trace.timeLength); % km/h
% Convert speed to m/s
Trace.speed_ms = Trace.speed_kmh * 1000 / 3600; % m/s

% The total time is the sum of the time lengths and the waiting times
Trace.timeTot = cumsum(Trace.timeLength) + cumsum(Trace.waitingTime);
Trace.distancesTot = cumsum(Trace.distances); % km


% The time to accelerate or decelerate is calculated using the formula: t = v / a
Trace.accelerationTime = Trace.speed_ms ./ Trace.acceleration; % seconds
Trace.decelerationTime = Trace.speed_ms ./ Trace.deceleration; % seconds
% The total time for each distance is the sum of the acceleration time, the constant speed time, and the deceleration time
Trace.timeLength = Trace.accelerationTime + Trace.decelerationTime + (Trace.timeLength - Trace.accelerationTime - Trace.decelerationTime); % seconds


% Initialize the time and speed reference vectors
TraceRef.time = [];
TraceRef.SpeedRef = [];
TraceRef.LoadRef = [];
% Loop through each distance to create the reference vectors
for i = 1:length(Trace.distances)
    % Time vector for the current segment
    t = linspace(0, Trace.timeLength(i), Trace.timeLength(i)/TraceRef.Ts); % 
    % Speed vector for the current segment
    v = zeros(size(t));
    % Load vector for the current segment
    TraceRef.LoadRef = [TraceRef.LoadRef, repmat(Trace.load(i), 1, length(t))];

    % Calculate the speed profile for acceleration phase
    if Trace.accelerationTime(i) > 0
        accel_t = t(t <= Trace.accelerationTime(i));
        v(t <= Trace.accelerationTime(i)) = Trace.acceleration * accel_t;
    end

    % Calculate the speed profile for constant speed phase
    if Trace.timeLength(i) > Trace.accelerationTime(i) + Trace.decelerationTime(i)
        const_t = t(t > Trace.accelerationTime(i) & t <= (Trace.timeLength(i) - Trace.decelerationTime(i)));
        v(t > Trace.accelerationTime(i) & t <= (Trace.timeLength(i) - Trace.decelerationTime(i))) = Trace.speed_ms(i);
    end
    % Calculate the speed profile for deceleration phase
    if Trace.decelerationTime(i) > 0
        decel_t = t(t > (Trace.timeLength(i) - Trace.decelerationTime(i)));
        v(t > (Trace.timeLength(i) - Trace.decelerationTime(i))) = Trace.speed_ms(i) - Trace.deceleration * (decel_t - (Trace.timeLength(i) - Trace.decelerationTime(i)));
    end
    % Append the current segment's time and speed to the reference vectors
    TraceRef.time = [TraceRef.time, t + sum(Trace.timeLength(1:i-1)) + sum(Trace.waitingTime(1:i-1))];
    TraceRef.SpeedRef = [TraceRef.SpeedRef, v];

    % Add zero load during the waiting time
    if i < length(Trace.distances)
        wait_t = linspace(0, Trace.waitingTime(i), 100);
        TraceRef.time = [TraceRef.time, wait_t + sum(Trace.timeLength(1:i)) + sum(Trace.waitingTime(1:i-1))];
        TraceRef.SpeedRef = [TraceRef.SpeedRef, zeros(size(wait_t))];
        TraceRef.LoadRef = [TraceRef.LoadRef, zeros(size(wait_t))];
    end

end

%%
% Remove duplicate time points and ensure strictly increasing time vector
[TraceRef.time, uniqueIdx] = unique(TraceRef.time, 'stable');
TraceRef.SpeedRef = TraceRef.SpeedRef(uniqueIdx);
TraceRef.LoadRef = TraceRef.LoadRef(uniqueIdx);

% Augment the number of points in the reference vectors to ensure they are smooth and continuous
timeTemp = linspace(0, TraceRef.time(end), TraceRef.time(end)/TraceRef.Ts); % 1000 points for smoothness
TraceRef.SpeedRef = interp1(TraceRef.time, TraceRef.SpeedRef, timeTemp, 'linear', 'extrap');
TraceRef.LoadRef = interp1(TraceRef.time, TraceRef.LoadRef, timeTemp, 'linear', 'extrap');

TraceRef.time = timeTemp;


LoadRef.time    = TraceRef.time;
LoadRef.values      = TraceRef.LoadRef;


Trace.time(1) = Trace.timeLength(1)+Trace.waitingTime(1); % Start time at 0
for ii = 2:length(Trace.timeLength)-1
    Trace.time(ii) = Trace.time(ii-1) + Trace.timeLength(ii) + Trace.waitingTime(ii);
end
Trace.time(end+1) = Trace.time(end)+Trace.timeLength(end);

% Position reference in meter
TraceRef.PosRef = cumsum(TraceRef.SpeedRef)*TraceRef.Ts;

Trace.pos = interp1(TraceRef.time,TraceRef.PosRef,Trace.time);

%% Slope

% Interpolate slope only during non-zero speed, hold value during stops
SlopePoints.time = Trace.time;
SlopePoints.values = TraceRef.SlopeRef;

% Ensure the slope profile is a loop
SlopePoints.values(end+1) = SlopePoints.values(1);
SlopePoints.time(end+1) = Trace.time(end);

% Find indices where speed is not zero
nonZeroIdx = find(TraceRef.SpeedRef > 0);

% Preallocate slope reference
TraceRef.SlopeProfile = zeros(size(TraceRef.time));

% Ensure SlopePoints.time is strictly increasing and unique
[SlopePoints.time, uniqueIdxSlope] = unique(SlopePoints.time, 'stable');
SlopePoints.values = SlopePoints.values(uniqueIdxSlope);

% Interpolate slope at non-zero speed points
slopeInterp = interp1(SlopePoints.time, SlopePoints.values, unique(TraceRef.time(nonZeroIdx)), 'linear', 'extrap');
TraceRef.SlopeProfile(nonZeroIdx) = slopeInterp;

% For zero speed, hold previous slope value
lastSlope = SlopePoints.values(1);
for k = 1:length(TraceRef.time)
    if TraceRef.SpeedRef(k) == 0
        TraceRef.SlopeProfile(k) = 0*lastSlope;
    else
        lastSlope = TraceRef.SlopeProfile(k);
    end
end

% Ensure the first and last slope values are identical
TraceRef.SlopeProfile(end) = TraceRef.SlopeProfile(1);

TraceRef.SlopeRef = TraceRef.SlopeProfile;


%% Wind

% Get the wind reference
tempTime = TraceRef.time;
WindRef.values = interp1([0 Trace.time], [0 WindRef.values],tempTime,'spline');
WindRef.time = tempTime;
clear tempTime


% %% Acceleration
% % Calculate the acceleration profile
% TraceRef.Acceleration = zeros(size(TraceRef.SpeedRef));
% for i = 1:length(TraceRef.SpeedRef)-1
%     if TraceRef.SpeedRef(i+1) > TraceRef.SpeedRef(i)
%         TraceRef.Acceleration(i) = (TraceRef.SpeedRef(i+1) - TraceRef.SpeedRef(i)) / TraceRef.Ts;
%     elseif TraceRef.SpeedRef(i+1) < TraceRef.SpeedRef(i)
%         TraceRef.Acceleration(i) = (TraceRef.SpeedRef(i+1) - TraceRef.SpeedRef(i)) / TraceRef.Ts;
%     end
% end

%% Plot figures

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
grid on

figure
title('Wind speed profile')
plot(WindRef.time,WindRef.values)
xlabel('Time (s)')
ylabel('Wind speed (m/s)')

figure
title('Load profile')
plot(LoadRef.time,LoadRef.values)
xlabel('Time (s)')
ylabel('Load profile (kg)')

return
%% Save

% Scale the number of points to 5e3

TraceSave.time       = linspace(0,TraceRef.time(end),5e3);
TraceSave.LoadRef    = interp1(TraceRef.time,TraceRef.LoadRef,TraceSave.time);
TraceSave.WindRef    = interp1(TraceRef.time,WindRef.values,TraceSave.time);
TraceSave.PosRef     = interp1(TraceRef.time,TraceRef.PosRef,TraceSave.time);
TraceSave.SlopeRef   = interp1(TraceRef.time,TraceRef.SlopeRef,TraceSave.time);
TraceSave.Laps       = TraceRef.Laps;

% TraceSave.time       = TraceRef.time;
% TraceSave.LoadRef    = TraceRef.LoadRef;
% TraceSave.WindRef    = WindRef.values;
% TraceSave.PosRef     = TraceRef.PosRef;
% TraceSave.SlopeRef   = TraceRef.SlopeRef;
% TraceSave.Laps       = TraceRef.Laps;

save(nameRef,"TraceSave")
