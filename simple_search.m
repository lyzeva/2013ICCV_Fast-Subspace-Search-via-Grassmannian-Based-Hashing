% ann= simple_search(H, L)
function [ann, mindq, evals]= simple_search(H, L)
	p= numel(H.keys);
	[Q, R]= qr(L, 0);
	mindq= inf;
	ann= [];
	evals= 0;
	for i= 1:p
		P= H.proj{i}* Q;
		T= compute_all_dist(P, H.d, [size(L,2)]);
		T= H.quant(T).';
		% this is a direct search over the keys.
		T= repmat(T, [H.M, 1]); 
		idx= find(all(T== H.keys{i},2)).';
		cols= [];
		for j= idx
			cols= [cols, H.nidx(j)+ (1:H.ns(j))];
		end
		evals= evals+ numel(idx);
		if numel(idx)> 0
			P= Q.'* H.nLs(:,cols);
			T= compute_all_dist(P, size(L, 2), H.ns(idx));
			[mindq, ann]= min(T);
			ann= idx(ann);
			break;
		end
	end
	if numel(ann)> 0 && numel(H.pidx)> 0
		ann= H.pidx(ann);
	end
end
