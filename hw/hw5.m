close all;
clear all;

% Schwartz 4-2

C = 1200;
lp = 48;
len = 1500;
v = 150000;
tproc = 30e-3;
pb = 1e-5;

[normdr1, l1] = normdr_snw(C, lp, len, v, tproc, pb); 

figure(1);
plot(l1, normdr1);
xlabel('l (bits)');
ylabel('D/C (normalized data rate)');
title('Normalized data rate vs. bit length l');
hold on;
grid on;
grid minor;

C = 9600;
[normdr2, l2] = normdr_snw(C, lp, len, v, tproc, pb); 
plot(l2, normdr2, 'r--');

legend('C = 1200bps', 'C = 9600bps')
print('-dpng', '-r300', 'hw5_1_dr.png');
