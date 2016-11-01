clear all;
close all;

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

	st = (-1 / mu) * log(rand);

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

% P_n based on formula
P_n_f = (1-rho) * ((rho).^(0:max(q_length)));

figure(1);
plot(0:max(q_length), P_n);
hold on;
plot(0:max(q_length), P_n_f, 'r--');
xlabel('number of packets (n)');
ylabel('Probability P_n');
title('P_n vs. number of packets n');
legend('simulation result', 'formula result');

fprintf('The expected delay from simulation: %f\n', E_t);
fprintf('The expected delay from formula: %f\n', E_t_f);
fprintf('The expected number of packets in the queue from simulation: %d\n', ...
	E_n);
