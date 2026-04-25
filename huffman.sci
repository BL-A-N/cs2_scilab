clear; clc;
symbols = ['A' 'B' 'C' 'D' 'E'];
probs = [0.4 0.2 0.2 0.1 0.1];
n = length(probs);
 
codes = list(); grp = list();
for i = 1:n, codes(i) = ''; grp(i) = i; end
 
p = probs;
while length(p) > 1
    [sp, idx] = gsort(p, 'g', 'i');
    i1 = idx(1); i2 = idx(2);
    for k = grp(i1), codes(k) = '0' + codes(k); end
    for k = grp(i2), codes(k) = '1' + codes(k); end
    keep = setdiff(1:length(p), [i1 i2]);
    new_grp = list();
    for k = 1:length(keep), new_grp(k) = grp(keep(k)); end
    new_grp($+1) = [grp(i1) grp(i2)];
    p = [p(keep) p(i1)+p(i2)];
    grp = new_grp;
end
 
avg_len = 0;
for i = 1:n, avg_len = avg_len + probs(i)*length(codes(i)); end
H = -sum(probs .* log2(probs));
 
disp('Symbol | Prob | Code');
for i = 1:n
    printf('  %s   | %.2f | %s\n', symbols(i), probs(i), codes(i));
end
printf('\nEntropy    = %.4f bits\n', H);
printf('Avg Length = %.4f bits\n', avg_len);
printf('Efficiency = %.2f%%\n', H/avg_len*100);
