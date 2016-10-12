clear all;
close all;

% define parameters
lambda = 5;
mu = 6;
rho = lambda / mu;

% simulate M/M/1 queue
delta = 0.001; % simulation step in sec

M = 3600/delta; % # of simulation step for 1 hour
n = zeros(M,1); % # of packets at each simulation time step
n_cur = 0; % current # of packets in the system

for i = 1:M
	n_cur; % # of packets before the process
	n(i) = n_cur; % record the # of packet before the process

	if rand < lambda*delta % probability of an arrival occurred = lambda * delta
		n_cur = n_cur + 1;
	end

	if rand < mu*delta && n_cur > 0 % probability of departure occurred = mu * delta provided that there is a packet in the system
		n_cur = n_cur - 1;
	end
end

% P_n based on formula
P_n_f = (1-rho) * ((rho).^(0:max(n)));

% P_n based on simulation
for m = 0:max(n)
	y(m+1) = sum(n == m);
end
P_n = y / M;

% P_n based on simulation
for m = 0:max(n)
	y(m+1) = sum(n == (m - 1));
end
P_np = y ./ M;

% P_n based on simulation
for m = 0:max(n)
	y(m+1) = sum(n == m);
end
P_npp = y ./ M;

figure(1);
plot(n);
disp(mean(n));
title('Number of packets N(t) over t, lambda = 5, mu = 6');
xlabel('t');
ylabel('N(t)');
%{
figure(2);
h1 = histogram(n);
h1.Normalization = 'Probability';
title('Distribution of P_n, lambda = 5, mu = 4');
xlabel('n');
ylabel('P_n');
%}
figure(2);
hold on;
grid on;
plot(0:max(n), P_n_f);
plot(0:m, P_n, 'r--');
title('P_n estimation based on different approach');
legend('Based on formula', 'Based on simulation');
xlabel('n');
ylabel('P_n');

figure(3);
hold on;
grid on;
plot(0:m, P_np);
plot(0:m, P_npp, 'r--');
title('P_n prime vs. P_n double prime');
legend('P_n prime', 'P_n double prime');
xlabel('n');
ylabel('Distribution');
