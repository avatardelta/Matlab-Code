function [ output_char_struct ] = timeshift( char_array, time)
%timeshift shift the last entry by the indicated relative number of hours. 
s = struct('days',[],'hours',[],'minutes',[]);

working_structs = decode({char_array.stringarray});
%% Get the last element
last = length(working_structs);
lastone = working_structs{last}.wait; %get a working member
working_structs{last}.wait.minutes =  lastone.minutes + time.minutes;
working_structs{last}.wait.hours =  lastone.hours + time.hours;
working_structs{last}.wait.days =  lastone.days + time.days;
%% Find our 'normal' delay time
getfirst = {char_array.delay_min};
delay_minutes = getfirst{1}; %What's our 'normal' delay 

new_string_array = encode(working_structs);
output_char_struct = struct('delay_min', delay_minutes, 'stringarray', new_string_array);
end

