function X= col_set_proc(X, cs, pred, f)
	lidx= cumsum([0; cs]);
	pidx= find(pred);
	for i= 1:numel(pidx)
		j= pidx(i);
		cols= lidx(j)+ (1:cs(j));
		X(:, cols)= f(X(:,cols));
	end
end
