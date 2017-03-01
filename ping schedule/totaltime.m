function [ total_time_consumed ] = totaltime( char_array )
%TOTALTIME Figure out how long a given, formatted character array lasts. 
%   Detailed explanation goes here
%input data looks as such:
%func_output = struct('delay_min', equidistant_spacing * 60, 'stringarray', output);

%Inner work data is formatted as such:
% field1 = 'state';  value1 = [];
%field2 = 'wait';  value2 = struct('days',[],'hours',[],'minutes',[]);
% s = struct(field1,value1,field2,value2)
% STATE H# M#

%% Work?
working_structs = decode({char_array.stringarray});
total = struct('days',0,'hours',0,'minutes',0);
for index = 1:length(working_structs)
    total.days = total.days + working_structs{index}.wait.days;
    total.hours = total.hours + working_structs{index}.wait.hours;
    total.minutes = total.minutes + working_structs{index}.wait.minutes;
end
%% Account for the initial shift. This is...unclear. if necessary. 
%getfirst = {char_array.delay_min};
%delay_minutes = getfirst{1};
%total.minutes = total.minutes+delay_minutes;
total_time_consumed = total;
end

