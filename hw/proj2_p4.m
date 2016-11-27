clear all;
close all;

cwnd = csvread('cwnd_reno');

figure(2);
grid on;
scatter(cwnd(:,1), cwnd(:,2));
xlabel('Time (seconds)');
ylabel('Congestion Window Size');
title('TCP Reno Congestion Window Size Over Time');
