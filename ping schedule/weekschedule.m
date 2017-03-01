

%%
clc; clear all;

%% The Week Generation Process
%Generate time shifted begin statement. This is based on the first day.
%But first let's 'set up' our schedule
%% Generate the wait schedule for tuesday
tuesday = spacethewait(4,3,1); %Start at 4
wednesday = tuesday; %Start at 4
thursday = spacethewait(7,3,1); %Start at 2
friday = thursday; %start at 2
saturday = thursday; %start at 2

%% One week, Long Form
getfirst = {tuesday.delay_min}; %Get the initial delay for tuesday
delay_minutes = getfirst{1};
delayed_structured_begin_end_array = genbigend(delay_minutes); %Okay, here's the starting time. This is hardcoded to start tuesday at 16:00 + delay_minutes

%expand the schedule for tuesday to consume 24 hours
tuesday = trimconsume24(tuesday);
%We need to append the next day's delay.
getfirst = {wednesday.delay_min}; %Get the initial delay for wednesday
delay_minutes = getfirst{1};
structured_wait = struct('days',0,'hours',0,'minutes',delay_minutes);
tuesday = timeshift(tuesday, structured_wait); %Add the delay to the end of the previous day's timer

%expand wednesday to 24 hour
wednesday = trimconsume24(wednesday);
%get thursday's delay
getfirst = {thursday.delay_min}; %Get the initial delay for Thursday
delay_minutes = getfirst{1};
structured_wait = struct('days',0,'hours',0,'minutes',delay_minutes);
wednesday = timeshift(wednesday, structured_wait); %Add the delay to the end of the previous day's timer
structured_wait.hours = -2; %Wednesday -> Thursday transitioning to open at 2PM, not 4PM.
structured_wait.minutes = 0; %Don't forget to erase previous values in a reused struct. 
wednesday = timeshift(wednesday, structured_wait);

%expand thursday to 24 hour
thursday = trimconsume24(thursday);
%get friday's delay
getfirst = {friday.delay_min}; %Get the initial delay for friday
delay_minutes = getfirst{1};
structured_wait = struct('days',0,'hours',0,'minutes',delay_minutes);
thursday = timeshift(thursday, structured_wait); %Add the delay to the end of the previous day's timer

%expand friday to 24 hour
friday = trimconsume24(friday);
getfirst = {saturday.delay_min};
delay_minutes = getfirst{1};
structured_wait = struct('days',0,'hours',0,'minutes',delay_minutes);
friday = timeshift(friday, structured_wait); %Add the delay to the end of the previous day's timer

%expand saturday to 24 hour, generate and skip sunday, monday.
saturday = trimconsume24(saturday);
getfirst = {tuesday.delay_min}; %Get the initial delay for tuesday
delay_minutes = getfirst{1};
structured_wait = struct('days',0,'hours',0,'minutes',delay_minutes);
saturday = timeshift(saturday, structured_wait);
structured_wait = struct('days',0,'hours',2,'minutes',0); %Return the start time to be 4PM
saturday = timeshift(saturday, structured_wait);
%Need to figure out the delay to add to the end of saturday to return us to
%our 'start' point of about 1600 tuesday
%% Count the time we've done
meh = [ {tuesday.stringarray}, {wednesday.stringarray} , {thursday.stringarray} , {friday.stringarray}, {saturday.stringarray} ];
working_structs = transpose(decode(meh));

total = struct('days',0,'hours',0,'minutes',0);
for index = 1:length(working_structs)
    total.days = total.days + working_structs{index}.wait.days;
    total.hours = total.hours + working_structs{index}.wait.hours;
    total.minutes = total.minutes + working_structs{index}.wait.minutes;
end


fixthehours =(total.hours + floor(total.minutes / 60));
fixtheminutes = mod(total.minutes,60);
fixthedays = (total.days + floor(total.hours / 24));
fixthehours = mod(fixthehours, 24);
total.hours = fixthehours;
total.minutes = fixtheminutes;
total.days = fixthedays;
total_time_consumed = total;
time_to_go = struct('days',6-total.days,'hours',23-total.hours,'minutes',60-total.minutes);

saturday = timeshift(saturday, time_to_go);
%% wrap it around the start. 
meh = transpose([ {tuesday.stringarray}, {wednesday.stringarray} , {thursday.stringarray} , {friday.stringarray}, {saturday.stringarray} ]);

getfirst = {tuesday.delay_min}; %Get the initial delay for tuesday
delay_minutes = getfirst{1};


a_week = struct('delay_min', delay_minutes, 'stringarray', meh);
total = totaltime(a_week);
%Fix formatting for the humans.
fixthehours =(total.hours + floor(total.minutes / 60));
fixtheminutes = mod(total.minutes,60);
fixthedays = (total.days + floor(total.hours / 24));
fixthehours = mod(fixthehours, 24);
total.hours = fixthehours;
total.minutes = fixtheminutes;
total.days = fixthedays;
total_time_consumed = total; %Check that our array does indeed consume 7 days. 
% 
% getfirst = {saturday.delay_min};
% delay_minutes = getfirst{1};
% structured_wait = struct('days',0,'hours',0,'minutes',delay_minutes)
% friday = timeshift(friday, structured_wait); %Add the delay to the end of the previous day's timer

%% Begin prep to output a script file
output = ['#This is a generated, Weekly Schedule for the witty Pi'; ' '; delayed_structured_begin_end_array ; ' ';  meh];


%% File output?
'Here is output:'
T = cell2table(output,'VariableNames',{'d'})
writetable(T, 'Ping_3_times_During_open_hours_weekly.wpi.txt', 'WriteVariableNames', false, 'QuoteStrings', false, 'Delimiter', ' ' );


%Just remember to remove the .txt. Otherwise ready to upload to the
%raspberry pi / witty pi!

%% 
'Schedule Creation Complete'