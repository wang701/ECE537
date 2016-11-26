#!/usr/bin/env python

with open('tcp-window.tr', 'r') as f:
    for line in f:
        event, time, fn, tn, pkt_type, pkt_size, flags, fid, s_addr, d_addr, \
        seq_num, pkt_id = line.split(' ')
        if event == 'r' and tn == '0':
            print time, tn, seq_num
