% H= hash_set(N, K, d)
%    hash_set(N, K)
% generate a set of hash functions
function H= hash_set(N, K, d)
	if nargin> 3 || nargin< 2
		error('has_set expects 2 or 3 arguments');
	end
	if nargin== 2
		d= 1;
	end
	% generate random N-vectors
	G= randn(N, K* d);
	% find column norms
	gn= sum(G.* G);
	tol= sqrt(eps)* N;
	sm= gn< tol;
	while any(sm)
		% extremely unlikely to ever enter here
		% even with very small N
		Gs= randn(N, sum(sm));
		G(:,sm)= Gs;
		gn(:,sm)= sum(Gs.*Gs);
		sm= gn< tol;
	end
	% normalize columns to unit-length
	G= G .* repmat(1./ sqrt(gn), [N 1]);
	% if d> 1 we are not done
	if d> 1
		for i=1:d:K* d
			G(:,i:i+d-1)= rand_qr(G(:,i:i+d-1));
		end
	end
	H= struct('G', G.', 'd', d, 'K', K, 'N', N);
end

function X= rand_qr(X)
	% thin QR
	[X, R]= qr(X, 0);
	R= diag(R);
	R(R> 0)= 1;
	R(R< 0)= -1;
	% unbiased unifrom sample constructed
	X= X* diag(R);
end
