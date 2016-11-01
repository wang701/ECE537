function co = customer(at, sst, st)
	%{
		This function takes in arrival time, service start time, and service time
		of a customer to compute other parameters to give out a struct of customer
		that has all these time parameters.

		Input:
			at - arrival time
			sst - service start time
			st - service time
		Output:
			co: a MATLAB struct of a customer that has different time parameters
				at - arrival time
				sst - service start time
				st - service time
				se - service end time
				w - wait time
	%}
	c = struct('at', [], 'sst', [], 'st', [], 'se', [], 'w', []);

	c.at = at;
	c.sst = sst;
	c.st = st;
	c.se = st + sst;
	c.w = sst - at;

	co = c;
end
