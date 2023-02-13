clear
close all
clc

%Question 1:

% defining the nyquist sampling frequency and domain:
freq=-50:0.01:50;

% defining the rectangular and triangular functions:
f=@(a) sqrt(200/3)*rectangularPulse(-5,5,a);
c=@(a) 10*triangularPulse(-10,10,a);

% using cosine modulation in the frequency domain:
pulse1=1/2*f(freq+5)+1/2*f(freq-5);
pulse2=1/2*c(freq-40)+1/2*c(freq+40);
pulse= pulse1+pulse2;

% using inverse fourier transform to find f(t):
ifour1=ifft(pulse1);
ifour2=ifft(pulse2);
ifour=ifour1+ifour2;

check=fft(ifour);

% plotting the frequency response:
plot(freq,pulse);
title("Frequency Response");
xlabel('frequency(Hz)');
ylabel('F(f)');
ylim([-0.5,11]);
xlim([-50,50]);

% plotting the function of time graph for the rectangular function:
figure;
plot(freq,ifour1);
title("f(t) v time (Rectangular Pulse)");
xlabel('time (seconds)');
ylabel('f(t)');
ylim([-0.5,0.5]);
xlim([40,50]);

% plotting the function of time graph for the triangular function:
figure;
plot(freq,ifour2);
title("f(t) v time (Triangular Pulse)");
xlabel('time (seconds)');
ylabel('f(t)');
ylim([-0.5,0.5]);
xlim([49,50]);

% plotting the final function of time graph:
figure;
plot(freq,ifour);
title("f(t) v time");
xlabel('time (seconds)');
ylabel('f(t)');
ylim([-0.5,0.5]);
xlim([49,50]);


% plotting to check if fft results in initial graph:
figure;
plot(freq,check);
title("Frequency Response");
xlabel('Frequency (Hertz)');
ylabel('F(f)');
ylim([-0.5,10]);
xlim([-50,50]);


%Question 2:
pulser=@(a)pulse1+pulse2;
f1=@(a) (1/2*sqrt(200/3)*rectangularPulse(-10,10,a)).^2;
c1=@(a) (5*triangularPulse(-50,-30,a)).^2
d1=@(a)(5*triangularPulse(30,50,a)).^2;

% defining the low pass filter: 
g=@(a)rectangularPulse(-10,10,a); 
g1=g(freq);

% filtering the function:
H=@(a)g(a).*pulser(a);

% using inverse fourier transform to find filtered f(t):
filtered=H(freq);
Y=ifft(filtered);

% finding the energy of the filtered component:
q1=integral(f1, -10 , 10);

% plotting the low pass filter:
figure;
plot(freq,g1);
title("Low Pass Filter");
xlabel('freq (Hz)');
ylabel('R(f)');
ylim([-0.5,2]);

% plotting the frequency response of the filtered functino:
figure;
plot(freq,filtered);
title("Frequency Response Filtered Using Low Pass Filter");
xlabel('freq (Hz)');
ylabel('H(f)');
ylim([-0.5,10]);

% plotting the filtered f(t):
figure;
plot(freq,Y);
title("Filtered h(t) v time");
xlabel('time (seconds)');
ylabel('h(t)');
ylim([-0.5,0.5]);
xlim([48,50]);


%Question 3:

% defining the band pass filter: 
b=@(a)rectangularPulse(-50,-30,a) + rectangularPulse(30,50,a);
V1=b(freq);


% filtering the function:
V=@(a)b(a).*pulser(a);

% using inverse fourier transform to find filtered f(t):
filtered2=V(freq);
D=ifft(filtered2);

% finding the energy of the filtered component:
q2=integral(d1, 30 , 50)+integral(c1, -50 , -30);

% plotting the band pass filter:
figure;
plot(freq,V1);
title("Band Pass Filter");
xlabel('freq (Hz)');
ylabel('V(f)');
ylim([-0.5,2]);

% plotting the frequency response of the filtered functino:
figure;
plot(freq,filtered2);
title("Filtered Frequency Response Using BandPass Filter");
xlabel('freq (Hz)');
ylabel('G(f)');
ylim([-0.5,10]);

% plotting the filtered f(t):
figure;
plot(freq,D);
title("Filtered g(t) v time");
xlabel('time (seconds)');
ylabel('g(t)');
ylim([-0.5,0.5]);
xlim([49,50]);


% displaying output of energies:
display(q1);
display(q2);