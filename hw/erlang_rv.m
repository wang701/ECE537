function X = erlang_rv(k, mu, n)
	%{
		This function generates Erlang random variables based on k numbers of i.i.d
		exponential random variables.

		Input:
			k - phase
			mu - mean for each exponential random variable
			n - number of Erlang random variables to generate
	%}
	for m = 1:n
		Y = (-mu) * log(rand(k, 1)); % Generate exponential r.v.s
		X(m) = sum(Y); % Sum them up to get Erlan r.v.
	end
end
