function [ chunk_array ] = process( cal_data, number_of_segments )
%PROCESS Combine the stereo data of a signal with an average, and then
%split the signal into a user defined number of subsamples (think splitting
%audio)
%
%   Column data is a a lengthofsample/numchunks column vector. 
%number_of_chunks = 6; %Set our chunk/sound segment number


size = length(cal_data(:,1)); %Grab the size of the calibration data
increment = size / number_of_segments;

%Let's collapse the stereo channel data but adding it together.
%cal_data = abs(cal_data); %why is taking the absolute value here going to do?
try
    cal = ((cal_data(:,1)+cal_data(:,2)))./2; %Don't forget to elementwise it...nope that's not it. 
catch DataIsNotStereo
   cal = cal_data; 
end
%allocate a split array, increment x number_of_chunks


%% AND NOW THE SPLITTER
for iterator = 1:number_of_segments
    if iterator == 1
        new_start = 1; %%Zeroth run, 1:44100
        new_end = increment;
        chunk_array = cal(new_start:new_end); %let's start our chunk data array.
   else 
         new_start = (iterator-1) * (increment)+1; %%1st run, 44100 
         new_end = (iterator) * increment; %2nd run, 88200  
         segment_data = cal(new_start:new_end); 
         chunk_array = [chunk_array segment_data];
    end

end


