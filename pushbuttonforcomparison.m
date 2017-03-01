function [ fft1 fft2 fs sample1 sample2 ] = pushbuttonforcomparison()
%PUSHBUTTONFORCOMPARISON Summary of this function goes here
%   Detailed explanation goes here

handles = guidata(gcbo); %get all the handles in our gui
contents1 = cellstr(get(handles.popupmenu1,'String'));%Get the contents of our selection box
selected1 = contents1{get(handles.popupmenu1,'Value')} %Get what was actually selected.
contents2 = cellstr(get(handles.popupmenu2,'String'));%Get the contents of our selection box
selected2 = contents2{get(handles.popupmenu2,'Value')} %Get what was actually selected.

[ fft1 fft2 fs sample1 sample2] = comparetwo(selected1, selected2);

%myfreqz(fft(fft1), fs)
%myfreqz(fft(fft2), fs)
%% Filter from 1500Hz to 4500 Hz //Trying to pass our main frequency.
% Wp = [0 4500*2*pi];
% Ws = [0 1500*2*pi];
% Rp = 3;
% Rs = 16;
% [n,Wp] = cheb1ord(Wp,Ws,Rp,Rs,'s')
% [ A B ] = cheby1(32, 1, [2*pi*1500 2*pi*4000],'bandpass');
% filtered = filter(B, A, fft1, [], 4);
% %% Cheby1 example
% Wp = [1000 4000]/500;
% Ws = [0 20000]/500;
% Rp = 3;
% Rs = 40;
% [n,Wp] = cheb1ord(Wp,Ws,Rp,Rs)
% [B,A] = cheby1(n,Rp,Wp);
%% myfreqz(fs, filtered)


plot(fft2, 'parent', handles.axes1)
%set(handles.axes1, 'XLim', [0 200])
plot(fft1, 'parent', handles.axes2)
plot(sample2, 'parent', handles.axes4)
plot(sample1, 'parent', handles.axes5)
end

