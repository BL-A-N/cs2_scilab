clear; clc;
bits = [1 0 1 1 0 0 1 0];
fc = 2; fs = 100;
t = 0:1/fs:1-1/fs;
N = length(t);
ci = cos(2*%pi*fc*t);
cq = sin(2*%pi*fc*t);
 
odd  = bits(1:2:$);
even = bits(2:2:$);
 
odd_sig  = odd  .*. ones(1,N);
even_sig = even .*. ones(1,N);
mod_sig  = ((2*odd-1) .*. ci) - ((2*even-1) .*. cq);
 
demod = zeros(1,length(bits));
for i = 1:length(odd)
    seg = mod_sig((i-1)*N+1:i*N);
    demod(2*i-1) = mean(seg.*ci) > 0;
    demod(2*i)   = mean(seg.*cq) < 0;
end
demod_sig = demod .*. ones(1,N);
 
subplot(4,1,1); plot(odd_sig);   title('Odd bits');
subplot(4,1,2); plot(even_sig);  title('Even bits');
subplot(4,1,3); plot(mod_sig);   title('QPSK Modulated');
subplot(4,1,4); plot(demod_sig); title('Demodulated');
