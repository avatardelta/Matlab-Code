function [ output_char] = encode( input )
%ENCODE Return a character array with the Witty Pi formatting for a line of
%text.
%   Supports HOURS and MINUTE delays
% field1 = 'state';  value1 = [];
%field2 = 'wait';  value2 = struct('days',[],'hours',[],'minutes',[]);
% s = struct(field1,value1,field2,value2)
% STATE H# M#
%% vectorizing this encode statement to work with either a single struct (as is currently defined AND / OR arrays of structs.
input_holder = input;
if (iscell(input))
    runs = length(input);
else
    runs = 1;
end
output_array = cell(runs,1);
for n = 1:runs
    %% Check if there are any funky inputs (minutes > 60), (hours > 24)
    if (iscell(input_holder))
        input = input_holder{n};
    end
    
    if (input.wait.minutes > 60)
        input.wait.hours = input.wait.hours + floor(input.wait.minutes/60);
        input.wait.minutes = mod(input.wait.minutes, 60);
    end
    if (input.wait.minutes < 0)
        input.wait.hours = input.wait.hours - 1;
        input.wait.minutes = input.wait.minutes + 60;
    end
    if (input.wait.hours > 24)
        input.wait.days = input.wait.days + floor(input.wait.hours/24);
        input.wait.hours = mod(input.wait.hours, 24);
    end
    if (input.wait.hours < 0)
        input.wait.days = input.wait.days - 1;
        input.wait.hours = input.wait.hours + 24;
    end
    if (input.wait.days == 0)
        %days is empty or zero.
        if (input.wait.hours == 0)
            output_char = [ input.state,' ','M',num2str(input.wait.minutes), ' '];
        elseif (input.wait.minutes == 0 )
            output_char = [ input.state , ' ',  'H',num2str(input.wait.hours), ' '];
        else
            output_char = [ input.state , ' ',  'H',num2str(input.wait.hours),' ','M', num2str(input.wait.minutes), ' '] ;
        end
    else %This will run if we EVER touch the value in days. That's okay.
        output_char = [ input.state , ' ','D', num2str(input.wait.days),' ','H',num2str(input.wait.hours),' ','M', num2str(input.wait.minutes),' '];
    end
    output_array(n) = {output_char};
end



if (iscell(input_holder))
    output_char = output_array;
end

end