clear; clc;
bits = [1 0 1 1 0 0 1 0];
f1 = 4; f2 = 2; fs = 100;
t = 0:1/fs:1-1/fs;
N = length(t);
c1 = cos(2*%pi*f1*t);
c2 = cos(2*%pi*f2*t);
 
msg = bits .*. ones(1,N);
mod_sig = (bits .*. c1) + ((1-bits) .*. c2);
 
demod = zeros(1,length(bits));
for i = 1:length(bits)
    seg = mod_sig((i-1)*N+1:i*N);
    demod(i) = mean(seg.*c1) > mean(seg.*c2);
end
demod_sig = demod .*. ones(1,N);
 
subplot(3,1,1); plot(msg); title('Message');
subplot(3,1,2); plot(mod_sig); title('BFSK Modulated');
subplot(3,1,3); plot(demod_sig); title('Demodulated');
