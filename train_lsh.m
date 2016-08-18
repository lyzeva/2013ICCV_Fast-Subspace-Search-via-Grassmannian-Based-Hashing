% H= train_lsh(H, Ls, ns)
%    train_lsh(H, Ls, n)
function H= train_lsh(H, Ls, ns)
	if nargin~= 3
		error('train_lsh expects 3 arguments');
	end
	N= size(Ls, 1);
	if N~= H.N
		error('Ambient dimension mismatch');
	end
	if numel(ns)> 1
		M= numel(ns);
		ns= ns(:);
		% put Ls with dim == 1 first
		noidx= ns> 1;
		Ls= [Ls(:, ~noidx), Ls(:, noidx)];
		ns= [ns(~noidx); ns(noidx)];
		pidx= (1:M);
		pidx= [pidx(~noidx), pidx(noidx)]; 
	else
		pidx= [];
		M= floor(size(Ls, 2)/ ns);
		if M* ns~= size(Ls, 2)
			error('Number of columns not divisible by n');
		else
			ns= ones(M, 1)* ns;
		end
	end
	
	% to do: handle case when Ls are not orthogonal
	if 1
		% handle Ls that are not orthogonal
		csum= sum(Ls.* Ls);
		H.nLs= Ls.* repmat(1./ sqrt(csum), [N 1]);
		% cols are now unit-length. Not enough for dims> 1
		H.nLs= col_set_proc(H.nLs, ns, ns> 1, @make_orth);
		P= H.G* H.nLs;
	else
		H.nLs= Ls;
		P= H.G* Ls;
	end
	
	H.T= compute_all_dist(P, H.d, ns);
	H.pidx= pidx;
	H.Ls= Ls;
	H.M= M;
	H.ns= ns;
	H.nidx= cumsum(ns) - ns;
end

function X= make_orth(X)
    [X, R]= qr(X, 0);
end
