clear; clc;
bits = [1 0 1 1 0 0 1 0];
fc = 2; fs = 100;
t = 0:1/fs:1-1/fs;
N = length(t);
c = cos(2*%pi*fc*t);
 
xor_enc = zeros(1,length(bits)+1);
for i = 1:length(bits)
    xor_enc(i+1) = bitxor(bits(i), xor_enc(i));
end
xnor_enc = 1 - xor_enc;
 
mod_xor  = (2*xor_enc-1)  .*. c;
mod_xnor = (2*xnor_enc-1) .*. c;
 
demod_n = zeros(1,length(bits));
for i = 1:length(bits)
    s1 = mod_xnor((i-1)*N+1:i*N);
    s2 = mod_xnor(i*N+1:(i+1)*N);
    demod_n(i) = mean(s1.*s2) > 0;
end
demod_x = demod_n;
 
subplot(7,1,1); plot(bits .*. ones(1,N));     title('Message');
subplot(7,1,2); plot(xor_enc .*. ones(1,N));  title('XOR Encoded');
subplot(7,1,3); plot(mod_xor);                title('DPSK Modulated (XOR based)');
subplot(7,1,4); plot(demod_x .*. ones(1,N));  title('Demodulated (XOR)');
subplot(7,1,5); plot(xnor_enc .*. ones(1,N)); title('XNOR Encoded');
subplot(7,1,6); plot(mod_xnor);               title('DPSK Modulated (XNOR based)');
subplot(7,1,7); plot(demod_n .*. ones(1,N));  title('Demodulated (XNOR)');
