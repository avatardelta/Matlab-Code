function [ output_struct ] = decode( input_chararray )
%DECODE Return a time struct array from a char array.
%  Supports HOURS and MINUTE delays
field1 = 'state';  value1 = [];
field2 = 'wait';  value2 = struct('days',[],'hours',[],'minutes',[]);
s = struct(field1,value1,field2,value2);
%STATE H# M#
%% Processing the input character array
numlines = length(input_chararray);
output_structs = cell(numlines,1); %Create our output cell structure.
for n = 1:numlines
    
    % find where the spaces are, as both binary arrays and index arrays. 
    wherespace = isspace(input_chararray{n});
    %whereletters = isletter(input_chararray{n});
    %onesarenumbers = not(or(wherespace,whereletters));
    %number_index = find(onesarenumbers); %Get the indexes for all the numbers,
    spaceindex = find(wherespace);
    
    %% check end padding and correct
    if (wherespace(length(wherespace))==1) %check if the end of the input has a space.
        'Congratulations, the end character is a space';%Good. It's properly formatted
    else                                               %NO SPACE, AAARGH
        input_chararray{n} = input_chararray{n} + ' '; %So we add one
    end
  %% Begin processing characters.  
    e_worker = input_chararray{n};
    %Get the state. Take up to the first space.
    state = e_worker(1:spaceindex(1));
    
    %Defaults, woot.
    days = 0;
    hours = 0;
    minutes = 0;
    
    %Extract the numbers
    %We'll use the size of the space index matrix to determine how many pieces
    %of data might be checked for.
    %We're going between the spaces!!!
    datapoints = length(spaceindex)-1; %We padded the edge with a space to make this easier.
    for m = 1:datapoints
        next_char = spaceindex(m)+1;
        to_number = next_char + 1;
        get_character = e_worker(next_char);
        if (get_character == 'D')
            days = str2num(e_worker(to_number: spaceindex(m+1)));
        end
        if (get_character == 'H')
            hours = str2num(e_worker(to_number : spaceindex(m+1)))  ;
        end
        if (get_character == 'M')
            minutes = str2num(e_worker(to_number : spaceindex(m+1)))  ;
        end
        
    end
    s.state = state; s.wait.days = days; s.wait.hours = hours; s.wait.minutes = minutes;
    output_struct(n) = {s};
end
%% Okay, let's form a 'unit' struct for one line.
output_struct = transpose(output_struct);
end

