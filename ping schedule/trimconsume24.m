function [ output_char_struct ] = trimconsume24( char_array )
%TRIM Take a structured character array. trim off the time-delay from the
%last entry. 
%   Subtract one 
%% remove one delay from the last entry.
working_structs = decode({char_array.stringarray});

%% Get the total time
total = struct('days',0,'hours',0,'minutes',0);
for index = 1:length(working_structs)
    total.days = total.days + working_structs{index}.wait.days;
    total.hours = total.hours + working_structs{index}.wait.hours;
    total.minutes = total.minutes + working_structs{index}.wait.minutes;
end
%% Calculate the 24-total time delay struct. 
eh1 = 23 - (total.hours + floor(total.minutes / 60));
eh2 = 60 - mod(total.minutes,60);
%% Get the last element
last = length(working_structs);
the_final_wait = working_structs{last}.wait; %get a working member
%% Find our 'normal' delay time
getfirst = {char_array.delay_min};
delay_minutes = getfirst{1}; %What's our 'normal' delay 

%% Reduce total time by the initial delay needed
the_final_wait.minutes =  the_final_wait.minutes - delay_minutes + eh2; %removes one normal delay. 
working_structs{last}.wait.hours = working_structs{last}.wait.hours + eh1;
working_structs{last}.wait.minutes = the_final_wait.minutes ; 

new_string_array = encode(working_structs);
output_char_struct = struct('delay_min', delay_minutes, 'stringarray', new_string_array);
end

