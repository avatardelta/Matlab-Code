function [ func_output ] = spacethewait( hours, events, event_length )
%SPACETHEWAIT Space events out evenly as you can across end-start time!
%% Output formatting, String


% Organizing the delay time things.
field1 = 'state';  value1 = [];
field2 = 'wait';  value2 = struct('days',0,'hours',[],'minutes',[]);
s = struct(field1,value1,field2,value2);
event_length = 1; %1 minute to run.
%Defined out output data structure

%% Constants for testing
% hours = 9-2
% events = 2

%% Stuff
span = hours; %Okay, here's the time we have to work in
middle = span / 2 ;
%oddeve = mod(events,2); %Check if we have an even number of events
%Find out the unit spacing from the middle for an event
%If there are an odd number of events, then we'll space starting from the
%middle
%If there are even numbers of events, we'll space around the middle
equidistant_spacing = middle / events;
event_spaced_hours = floor(equidistant_spacing);
event_spaced_minutes = mod( equidistant_spacing* 60, 60 );

%|begin|event_spaced_distance|event_length|event_spaced_distance -
%event_length|
%|
%|

%We're going to return an array of state waits. 
%% Making the timing loop
size = 2*events;

output = cell(size,1);

%counter = 0;
for i=1:size
    i;
    if (mod(i,2) == 0)
     %   counter = counter + 1;
       %An event is happening, right now!
        s.state = 'ON'; s.wait.hours = 0; s.wait.minutes = event_length;
        encoded = encode(s);
        s.state = 'OFF'; s.wait.hours = 2*event_spaced_hours; s.wait.minutes = 2*event_spaced_minutes - event_length;
       encoded_2 = encode(s);
      output(i-1) =  {encoded };
     output(i) = { encoded_2};
      
    end    
end

func_output = struct('delay_min', equidistant_spacing * 60, 'stringarray', output);
end

