clear all;
close all;

cwnd = csvread('cwnd');

figure(2);
grid on;
scatter(cwnd(:,1), cwnd(:,2));
xlabel('Time (seconds)');
ylabel('Congestion Window Size');
title('TCP Congestion Window Size Over Time');
