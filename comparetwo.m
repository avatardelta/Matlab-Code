function [first_fft second_fft fs sample1 sample2] = comparetwo(string1, string2)
%Comparing two samples
%% importing data. 
[sample1 fs] = audioread(string1);
[sample2 sfs] = audioread(string2);

%% PLot time domain

%% Make a matching index vector
% index = 1:1:length(sample1);
% figure
% plot(index/fs, sample1)
% title(string1)
% %axis([0, length(sample1)/fs, 0, 1])
% figure
% plot(index/sfs, sample2)
% title(string2)
%axis([0, length(sample2)/sfs, 0, 1])
bits = 8; %Default 8
number_of_segments = 2^(bits-1);
timesegment = 6 / number_of_segments; %Six second / number segments. 

%% Split the data
splitcolumnsample1 = process(sample1, number_of_segments);
splitcolumnsample2 = process(sample2, number_of_segments);

%% transform into dct
massmushtest1 = dct(splitcolumnsample1(:,:), 2^bits);
massmushtest2 = dct(splitcolumnsample2(:,:), 2^bits);

first_fft = abs(massmushtest1);
second_fft = abs(massmushtest2);
