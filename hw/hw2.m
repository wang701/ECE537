clear all;
close all;

% generate exponential distribution samples
lambda_exp = 0.1;
X = -(1/lambda_exp)*log(rand(1000,1));

x = [0:0.01:10];
cdf = zeros(100,1);
cdf_acc = 1 - exp(-lambda_exp*x);

for m = 1:1001
	occur = sum(X <= x(m));
	cdf(m) = occur / 1000;
end

figure;
grid on;
hold on;
plot(x, cdf);
plot(x, cdf_acc, '--');
legend('Empirical cdf', 'Actual cdf');
xlabel('x');
ylabel('P({X <= x})');
title('Exponential Distribution Cdf Estimation using N = 1000');
print('-dpng', '-r300', 'hw2_8_exp_n1000.png');
hold off;

% generate poisson distribution samples
lambda_poi = 10;

for l = 1:100
	k = 1;
	produ = 1;
	while produ >= exp(-lambda_poi)
		produ = produ * rand;
		k = k + 1;
	end
	Y(l) = k;
end

x = [0:0.2:20];
cdf_acc = poisscdf(x, lambda_poi);

for l = 1:101
	occur = sum(Y <= x(l));
	cdf(l) = occur / 100;
end

figure;
grid on;
hold on;
scatter(x, cdf, '*');
scatter(x, cdf_acc);
legend('Empirical cdf', 'Actual cdf');
xlabel('k');
ylabel('P({X <= k})');
title('Poisson Distribution Cdf Estimation using N = 100');
print('-dpng', '-r300', 'hw2_8_poi_n100.png');
hold off;

% model poisson pmf
a = 0;
b = 1000;

for m = 1:1001
	U = a + (b-a).*rand(1000,1);
	Z(m) = sum(U >= 10 & U <= 20);
end

pmfZ = accumarray(Z(:),1)./numel(Z);

figure;
grid on;
plot(pmfZ, '*');
xlabel('k');
ylabel('P({X = k})');
title('Poisson Pmf Estimation using N = 1000');
print('-dpng', '-r300', 'hw2_9_poi_pmf_n1000.png');
