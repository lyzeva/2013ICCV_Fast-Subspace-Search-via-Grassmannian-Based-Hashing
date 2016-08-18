function [ann, dq, evals]= exact_search(H, L)
	[Q, R]= qr(L, 0);
	P= Q.'* H.nLs;
	T= compute_all_dist(P, size(L, 2), H.ns);
	[dq, ann]= min(T);
	if numel(H.pidx)> 0
		ann= H.pidx(ann);
	end
	evals= H.M;
end
