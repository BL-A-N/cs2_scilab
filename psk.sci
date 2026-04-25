clear; clc;
bits = [1 0 1 1 0 0 1 0];
fc = 2; fs = 100;
t = 0:1/fs:1-1/fs;
N = length(t);
c = cos(2*%pi*fc*t);
 
msg = bits .*. ones(1,N);
mod_sig = (2*bits-1) .*. c;
 
demod = zeros(1,length(bits));
for i = 1:length(bits)
    seg = mod_sig((i-1)*N+1:i*N);
    demod(i) = mean(seg.*c) > 0;
end
demod_sig = demod .*. ones(1,N);
 
subplot(3,1,1); plot(msg); title('Message');
subplot(3,1,2); plot(mod_sig); title('BPSK Modulated');
subplot(3,1,3); plot(demod_sig); title('Demodulated');
