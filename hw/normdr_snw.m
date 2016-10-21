function [normdr, l] = normdr_snw(C, lp, len, v, tproc, pb) 

l = (lp+1):1:10000;
p = (l + lp) .* pb;
tp = len / v;
tI = (l + lp) ./ C;
tout = 2*tp + 2.*tI + tproc;
tT = tout + tI;
a = tT ./ tI;

normdr = (l./(l+lp)).*((1-p)./(1 + (a-1).*p));
