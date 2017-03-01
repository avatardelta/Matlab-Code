%% This is a script to process all the samples in a directory and save them in a matlab array form, saving the original sample data and an 8-bit fft

clear all; close all; clc;
%reset the workspace
%% Okay, start handling files

% Retrieve all the files in a directory
names = dir('*.wav');
%addpath('C:\Users\Owner\Documents\Pinger\data\recordings\Jan_Samples\DoppelBock_Kill\');
names = {names.name} %Look, a Cell Array with names as a string...I think. Yes, just the names.
%Get the number of elements in the names struct.
sizeofnames = size(names,2);
%% And now the processing/plotting loop.
%figure(1)
%title('Press any key to begin')
%pause[
% sample = names
% stuff = sample{:}


% bits = 8; %Default 8

% number_of_segments = 2^(bits-1)
% timesegment = 6 / number_of_segments; %Six second / number segments.
% Split the data%%
data = [];
for counter = 1:sizeofnames
    filename = names{counter};
    [sample fs] = audioread(names{counter});
    
    %Let's average out the data and move to a mono set of values.
    try
        sample = ((sample(:,1)+sample(:,2)))./2; %Don't forget to elementwise it...nope that's not it.
    catch DataIsNotStereo
        sample = sample;
    end
    
    
    output = struct('name', filename, 'timeSample', sample, 'fs', fs);
    data = [ data; output]; %Append new files into
    %     figure
    %     subplot(2,1,1)
    %     plot(abs(massmushtest1));
    %     axis([0 500 0 .5])
    %     title(names(counter));
    %     subplot(2,1,2)
    %     plot(sample)
    %     drawnow; %Drawnow refreshes the figure without relaunching.
end
%%
%% Okay, so I can save the data now.
save('sampled_dataset.mat','data')

