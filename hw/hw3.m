clear all;
close all;

% define parameters
lambda = 5;

% generate poisson process
T = -log(rand)/lambda;
n = 0;

while T < 100 
	n = n + 1;
	S(n) = T; % the time t when n arrival occurs
	T = T - log(rand)/lambda;
end

for l = 1:100
	N(l) = sum(S >= 0 & S <= l);
end

grid on
figure(1);
plot(N);
title('Number of packets N(t) over t = [0, 100]');
xlabel('t');
ylabel('N(t)');
print('-dpng', '-r300', 'hw3_1_nt.png');

% generate r.v. X
for l = 0:99
	X(l+1) = sum(S >= l & S <= (l + 1));
end

figure(2);
h = histogram(X);
h.Normalization = 'Probability';
disp(mean(X));
title('Distribution of X');
xlabel('n');
ylabel('P_n');
print('-dpng', '-r300', 'hw3_2_pn.png');

% simulate M/M/1 queue
delta = 0.1; % simulation step in sec
mu = 4; % departure rate in packets per second

M = 1*3600/delta; % # of simulation step for 1 hour
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

figure(3);
plot(n);
disp(mean(n));
title('Number of packets N(t) over t, mu = 4');
xlabel('t');
ylabel('N(t)');
print('-dpng', '-r300', 'hw3_3_nt_m4.png');

figure(4);
h1 = histogram(n);
h1.Normalization = 'Probability';
title('Distribution of P_n, lambda = 5, mu = 4');
xlabel('n');
ylabel('P_n');
print('-dpng', '-r300', 'hw3_3_pn_l5m4.png');
