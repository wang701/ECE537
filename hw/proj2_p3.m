clear all;
close all;

ack_seqnum = csvread('ack_seqnum_reno');
tcp_seqnum = csvread('tcp_seqnum_reno');

figure(1);
hold on;
grid on;
scatter(ack_seqnum(:,1), ack_seqnum(:,2), '+');
scatter(tcp_seqnum(:,1), tcp_seqnum(:,2));
xlabel('Time (seconds)');
ylabel('Sequence Number');
legend('ACK packets', 'TCP packets');
title({'Sequence Number for TCP Reno Packets Sent and', ...
       'ACK Packets Received at n_0'});
