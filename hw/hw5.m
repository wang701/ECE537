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
semilogx(l1, normdr1);
xlabel('l (bits)');
ylabel('D/C (normalized data rate)');
title('Normalized data rate vs. bit length l');
hold on;
grid on;
grid minor;

C = 9600;
[normdr2, l2] = normdr_snw(C, lp, len, v, tproc, pb); 
semilogx(l2, normdr2, 'r--');

legend('C = 1200bps', 'C = 9600bps', 'Location', 'NorthWest');
print('-dpng', '-r300', 'hw5_1_dr.png');

% Schwartz 4-7

% a)
C = 4800;
l = (lp+1):1:10000;
p = (l + lp) .* pb;
tp = 50e-3;
tI = (l + lp) ./ C;
tout = 2*tp + 2.*tI;
tT = tout + tI;
a = tT ./ tI;
normdr_terr_4800 = (l./(l+lp)).*((1-p)./(1 + (a-1).*p));

figure(2);
semilogx(l, normdr_terr_4800, 'r--');
xlabel('l (bits)');
ylabel('D/C (normalized data rate)');
title('Normalized data rate vs. bit length l');
hold on;
grid on;
grid minor;

% b)
C = 48e3;
l = (lp+1):1:10000;
p = (l + lp) .* pb;
tp = 50e-3;
tI = (l + lp) ./ C;
tout = 2*tp + 2.*tI;
tT = tout + tI;
a = tT ./ tI;
normdr_terr_48k = (l./(l+lp)).*((1-p)./(1 + (a-1).*p));

semilogx(l, normdr_terr_48k, 'r--');

% c)
C = 48e3;
l = (lp+1):1:10000;
p = (l + lp) .* pb;
tp = 700e-3;
tI = (l + lp) ./ C;
tout = 2*tp + 2.*tI;
tT = tout + tI;
a = tT ./ tI;
normdr_sat_48k = (l./(l+lp)).*((1-p)./(1 + (a-1).*p));

semilogx(l, normdr_sat_48k);
legend('Terrestrial Link', 'Terrestrial Link', 'Satellite Link', ...
'Location', 'NorthWest');

% add annotation
x1 = 200;
y1 = 0.92;
txt1 = 'C = 4800 bps';
text(x1, y1, txt1);

x2 = 1126;
y2 = 0.84;
txt2 = 'C = 48 kbps';
text(x2, y2, txt2);

x3 = 1126;
y3 = 0.60;
txt3 = 'C = 48 kbps';
text(x3, y3, txt3);
print('-dpng', '-r300', 'hw5_3_dr.png');

% Schwartz 4-8
l_opt = (lp/2) * (sqrt(1 - (4/(lp*log(1-pb))))-1)
