clear; clc;
bits = [1 0 1 1 0 1];
pn = [1 0 1 1 0 1 0 1];
Nc = length(pn);
 
data_bp = 2*bits - 1;
pn_bp = 2*pn - 1;
 
spread = data_bp .*. pn_bp;
despread = spread .* (ones(1,length(bits)) .*. pn_bp);
 
recovered = zeros(1,length(bits));
for i = 1:length(bits)
    recovered(i) = sum(despread((i-1)*Nc+1:i*Nc)) > 0;
end
 
subplot(4,1,1); plot(bits .*. ones(1,Nc));         title('Message');
subplot(4,1,2); plot(ones(1,length(bits)) .*. pn); title('PN Sequence');
subplot(4,1,3); plot(spread);                      title('DSSS Spread Signal');
subplot(4,1,4); plot(recovered .*. ones(1,Nc));    title('Recovered Message');
