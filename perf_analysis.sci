clear; clc;
SNR_dB = 0:2:12;
N = 100000;
bits = round(rand(1,N));

ber_bask = zeros(1,length(SNR_dB));
ber_bfsk = zeros(1,length(SNR_dB));
ber_bpsk = zeros(1,length(SNR_dB));

for k = 1:length(SNR_dB)
    sigma = 10^(-SNR_dB(k)/20);

    r = (2*bits-1) + sigma*rand(1,N,'n');
    ber_bpsk(k) = max(sum(bool2s(r>0) ~= bits)/N, 1e-6);

    r = bits + sigma*rand(1,N,'n');
    ber_bask(k) = max(sum(bool2s(r>0.5) ~= bits)/N, 1e-6);

    r1 = bits + sigma*rand(1,N,'n');
    r2 = (1-bits) + sigma*rand(1,N,'n');
    ber_bfsk(k) = max(sum(bool2s(r1>r2) ~= bits)/N, 1e-6);
end

clf;
plot2d(SNR_dB', [ber_bask' ber_bfsk' ber_bpsk'], style=[2 3 5], logflag="nl");
legend('BASK','BFSK','BPSK');
xtitle('BER vs SNR','SNR (dB)','BER');
xgrid();
