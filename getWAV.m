function [ names ] = getWAV( input_args )

%GETTIFF Return a an
%   input the extension, text only. no punctuation.
%% Okay, start handling files
% Retrieve all the files in a directory
names = dir('*.wav');
names = {names.name}; %Look, a Cell Array with names as a string...I think. Yes, just the names.
%Get the number of elements in the names struct.


end