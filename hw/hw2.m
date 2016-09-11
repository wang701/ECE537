clear all;
close all;

% number of samples
N = 1000;
%{
% generate uniform distribution
a = 0;
b = 1;
U = a + (b-a).*rand(N,1);

% generate exponential distribution samples
lambda_exp = 0.1;
X = -(1/lambda_exp)*log(U);

x = [0:0.01:10];
cdf = zeros(1000,1);
cdf_acc = 1 - exp(-lambda_exp*x);

for m = 1:1001
	occur = sum(X <= x(m));
	cdf(m) = occur / N;
end

figure(1)
grid on;
hold on;
plot(x, cdf);
plot(x, cdf_acc, '--');
legend('Empirical cdf', 'Actual cdf');
xlabel('x');
ylabel('P({X <= x})');
title('Exponential Distribution Cdf Estimation using N = 1000');
print('-dpng', '-r300', 'hw2_8_exp_n1000.png');
%}

%{
% generate uniform distribution
a = 0;
b = 1;
U = a + (b-a).*rand(N,1);

% generate poisson distribution samples
lambda_poi = 10;
U = zeros(100,100);

for m = 1:101
	U(m) = a + (b-a).*rand(N,1);
end
%}

% generate uniform distribution
a = 0;
b = 100;
U = a + (b-a).*rand(N,1);

interval_lb = a + (b-a).*rand(N,1);
interval_hb = interval_lb + 10;

occur_pmf = zeros(1000,1);
occur = zeros(1000,1);

for m = 1:1000
	occur(m) = sum(U <= interval_hb(m) & U >= interval_lb(m));
	occur_cdf(m) = occur(m) / 1000;
end

scatter(occur, occur_pmf, '*');
