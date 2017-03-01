function [ output_args ] = genbigend( input )
%GENBIGEND Generate the time-shifted begin/end time for a wittypi script
%A hardcoded cell array of strings...ick ick ick
%% Parse the delay time (expected delay in minutes for equidistance)
%input = 145;
hours = floor(input / 60 );
minutes = mod(input, 60) ;
seconds = floor(input / (60^2));
%% Hard Coded, Structured output
s1 = struct('state','BEGIN ' ,'t', datetime([2016 12 20 16+hours 00+minutes 00+seconds], 'TimeZone','local','Format','y-MM-d HH:mm:ss'));
s2 = struct('state','END ','t', datetime([2026 12 20 16 00 00], 'TimeZone','local','Format','y-MM-d HH:mm:ss'));

string1 = [char(s1.state) , char(s1.t)];
string2 =[ char(s2.state) , char(s2.t)];

output_args = {string1 ; string2};
%% Hardcoding approach.
%hardstart = 'BEGIN 2016-12-20 00:00:00';
%hardend = 'END 2025-07-31 23:59:59';

%output_args = {hardstart;hardend}; %Oh, this is a very lazy way to do it. But that's when this schedule starts...
%% Non hardcoding
%t = datetime('now','TimeZone','local','Format','d-MM-y HH:mm:ss')
end

