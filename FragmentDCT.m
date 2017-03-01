function [ index processed_signal original fs] = FragmentDCT( string1 bits)
%FRAGMENTDCT This performs the same as comparetwo, but on one signal. Performing a fragmentation and DCT given an input signal. 
%   Takes a one second 
% 
%%importing data. 
if nargin == 1      %if xyoffset isn't given, set the default value to zero.
    bits = 8;
end

[sample1 fs] = audioread(string1);
original = sample1; %Okay, we've got out input to output, or...yeah... sure. whatever. (BECAUSE THIS IS WORKING WITHIN A GUI! and I'm lazy)

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
%bits = 8; %Default 8
number_of_segments = 2^(bits-1);
timesegment = 6 / number_of_segments; %Six second / number segments. 

%% Split the data
splitcolumnsample1 = process(sample1, number_of_segments);

%% transform into dct
massmushtest1 = dct(splitcolumnsample1(:,:), 2^bits);

processed_signal = abs(massmushtest1);
x = 1:1:length(processed_signal);
index = x.*fs./(2^8);


end

