% cat tcp-window.nam | grep "cwnd_" | cut -f3,13 -d " " > cwnd

clear all;
close all;

cwnd = csvread('cwnd');

figure(2);
grid on;
scatter(cwnd(:,1), cwnd(:,2));
xlabel('Time (seconds)');
ylabel('Congestion Window Size');
title('TCP Congestion Window Size Over Time');
