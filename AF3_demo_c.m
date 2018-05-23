%% Initialize
clear all;
close all;
load music.mat;
load('music.mat');
N = length(s);
delta = 100;
coeff = 100;
%%  Joint Process Estimator
u = zeros(N,1);
for i = delta+1:N
    u(i) = s(i-delta);
end

% Create Correlation Vector

r = xcorr(s,s,coeff-1,'unbiased');
r = r(coeff:(2*coeff - 1));

% Use Lecture 07 script to find Levinson-Durbin coefficients
a = LevinsonDurbin(coeff-1,r); 

y = filter(a,1,u);

% Create .wav file
audiowrite('cleanTrack.wav',50*y,fs);
%sound(50*y,fs)