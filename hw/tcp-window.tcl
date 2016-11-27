set ns [new Simulator]
set n0 [$ns node]
set n1 [$ns node]
$ns at 0.0 "$n0 label Sender"
$ns at 0.0 "$n1 label Receiver"
set nf [open tcp-window.nam w]
$ns namtrace-all $nf
set f [open tcp-window.tr w]
$ns trace-all $f
$ns duplex-link $n0 $n1 0.2Mb 100ms DropTail
$ns duplex-link-op $n0 $n1 orient right
$ns queue-limit $n0 $n1 10
Agent/TCP set nam_tracevar_ true
set tcp [new Agent/TCP]
# Set the max congestion window large enough
$tcp set maxcwnd_ 64
# Set the receiver buffer large enough
$tcp set window_ 64
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns add-agent-trace $tcp tcp
$ns monitor-agent-trace $tcp
$tcp tracevar cwnd_
$ns at 0.1 "$ftp start"
$ns at 40.0 "$ns detach-agent $n0 $tcp"
$ns at 40.0 "$ns detach-agent $n1 $sink"
$ns at 40.5 "finish"
proc finish {} {
global ns nf
$ns flush-trace
close $nf
puts "running nam..."
exec nam tcp-window.nam &
exit 0
}

$ns run
