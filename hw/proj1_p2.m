close all;
clear all;

X1 = erlang_rv(4, 1/6/4, 1000);
X2 = erlang_rv(50, 1/6/50, 1000);

% Determine P(X <= x) for k = 4
x1 = [0:0.001:max(X1)];
for m = 1:length(x1)
	occur = sum(X1 > x1(m));
	P_x1(m) = occur / length(X1);
end

% Determine P(X <= x) for k = 50 
x2 = [0:0.001:max(X2)];
for m = 1:length(x2)
	occur = sum(X2 > x2(m));
	P_x2(m) = occur / length(X2);
end

figure(1);
plot(x1, P_x1);
hold on;
grid on;
plot(x2, P_x2, 'r--');
xlim([0 max(x1)]);
xlabel('x');
ylabel('P(X > x)');
title('P(X > x) for Erlang R.V.');
legend('k = 4', 'k = 50');
print('-dpng', '-r300', 'proj1_p2_px.png');

% define parameters
lambda = 5;
mu = 6;
rho = lambda / mu;
t = 0;
end_time = 10000;

m = 1; % index
	
co(m) = customer(0, 0, 0);
n = 0;

while t < end_time
	if length(co) - 1 == 0
		at = (-1 / lambda) * log(rand);
		sst = at;
	else
		at = at + (-1 / lambda) * log(rand);
		se = co(m-1).se;
		sst = max(at, se);
	end

	st = erlang_rv(4, 1/mu/4, 1);

	co(m) = customer(at, sst, st);

	m = m + 1;
	t = at;
end

% Find the expected delay
tt_sum = 0;
for m = 1:length(co)
	tt_sum = tt_sum + co(m).w + co(m).st;
end
E_t = tt_sum / length(co);

% Determine the number of packets at each time instance 
q_length = zeros(ceil(co(length(co)).se)+1, 1);
for m = 1:length(co)
	for t = ceil(co(m).at):floor(co(m).se) % These are the minutes that customer was waiting
		q_length(t+1) = q_length(t+1) + 1;
	end
end

% Deterimine the count for each number of packets in the system
for ind = 0:max(q_length)
	each_q_length_cnt(ind+1) = sum(q_length == ind);
end

% Find the expected number of packets
E_n = mean(q_length);

% Find the expected delay using Little's Law
E_t_f = E_n / lambda;

% Find the probability for each of the count
P_n = each_q_length_cnt / sum(each_q_length_cnt);

figure(2);
plot(0:max(q_length), P_n);
xlabel('number of packets (n)');
ylabel('Probability P_n');
title('P_n vs. number of packets n');
grid on;
print('-dpng', '-r300', 'proj1_p2_pn_vs_n.png');

fprintf('The expected delay from simulation: %f\n', E_t);
fprintf('The expected delay from formula: %f\n', E_t_f);
fprintf('The expected number of packets in the queue from simulation: %d\n', ...
	E_n);

clear co;

% define parameters
lambda = 1:0.6:6;
mu = 6;

for ind = 1:length(lambda)
	t = 0;
	end_time = 10000;

	m = 1; % index
	co(m) = customer(0, 0, 0);

	while t < end_time
		if length(co) - 1 == 0
			at = (-1 / lambda(ind)) * log(rand);
			sst = at;
		else
			at = at + (-1 / lambda(ind)) * log(rand);
			se = co(m-1).se;
			sst = max(at, se);
		end

		st = erlang_rv(50, 1/mu/50, 1);

		co(m) = customer(at, sst, st);

		m = m + 1;
		t = at;
	end

	% Find the expected delay
	tt_sum = 0;
	for m = 1:length(co)
		tt_sum = tt_sum + co(m).w + co(m).st;
	end
	E_t = tt_sum / length(co);

	% Determine the number of packets at each time instance 
	q_length = zeros(ceil(co(length(co)).se)+1, 1);
	for m = 1:length(co)
		for t = ceil(co(m).at):floor(co(m).se) % These are the minutes that customer was waiting
			q_length(t+1) = q_length(t+1) + 1;
		end
	end

	clear co;

	% Find the expected number of packets
	E_n_ek(ind) = mean(q_length);
end

figure(3);
plot(lambda/mu, E_n_ek, '*-');
grid on;
hold on;

clear co;

% define parameters
lambda = 1:0.6:6;
mu = 6;

for ind = 1:length(lambda)
	t = 0;
	end_time = 10000;

	m = 1; % index
	co(m) = customer(0, 0, 0);

	while t < end_time
		if length(co) - 1 == 0
			at = (-1 / lambda(ind)) * log(rand);
			sst = at;
		else
			at = at + (-1 / lambda(ind)) * log(rand);
			se = co(m-1).se;
			sst = max(at, se);
		end

		st = 1/mu;

		co(m) = customer(at, sst, st);

		m = m + 1;
		t = at;
	end

	% Find the expected delay
	tt_sum = 0;
	for m = 1:length(co)
		tt_sum = tt_sum + co(m).w + co(m).st;
	end
	E_t = tt_sum / length(co);

	% Determine the number of packets at each time instance 
	q_length = zeros(ceil(co(length(co)).se)+1, 1);
	for m = 1:length(co)
		for t = ceil(co(m).at):floor(co(m).se) % These are the minutes that customer was waiting
			q_length(t+1) = q_length(t+1) + 1;
		end
	end

	% Deterimine the count for each number of packets in the system
	for index = 0:max(q_length)
		each_q_length_cnt(index+1) = sum(q_length == index);
	end

	clear co;

	% Find the expected number of packets
	E_n_d(ind) = mean(q_length);
end

plot(lambda/mu, E_n_d, 'ro-');
title('Utilization vs. Expected Number of Packets in the Queue');
xlabel('Utilization \rho');
ylabel('E[n]');
legend('M/E_k/1 with k = 50','M/D/1 with D = 1/6');
print('-dpng', '-r300', 'proj1_p2_en.png');
