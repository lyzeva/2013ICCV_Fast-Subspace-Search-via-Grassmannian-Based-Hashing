function T= compute_all_dist(P, d, ns)
	ecols= sum(ns== 1);
	M= numel(ns);
	K= floor(size(P, 1)/ d);
	if K* d~= size(P, 1)
		error('P rows must a multiple of d');
	end
	if d> 1
		% hard case for ns> 1
		if ecols> 0
			T= P(:, 1:ecols);
			T= reshape(T.* T, [d, K* ecols]);
			T= reshape(sqrt(sum(T)), [K, ecols]); 
			if ecols< M
				T= [quarded_acos(T), zeros(K* d, M- ecols)];
			else
				T= guarded_acos(T);
				return;
			end
		else
			T= zeros(K, M);
		end
		nidx= cumsum(ns) - ns;
		for i= ecols+1:M
			cols= nidx(i)+ (1:ns(i));
			X= P(:,cols);
			md= min(d, ns(i));
			for j= 1:K
				ms= svd(X((j-1)*d+1:j*d,:));
				T(j,i)= norm(guarded_acos(ms(1:md)));
			end
		end
	else
		% easy case for all ns
		if ecols> 0
			if ecols< M
				T= [abs(P(:, 1:ecols)), zeros(K* d, M- ecols)];
			else
				T= guarded_acos(abs(P));
				return;
			end
		else
			T= zeros(K* d, M);
		end
		nidx= cumsum(ns) - ns;
		for i= ecols+1:M
			cols= nidx(i)+ (1:ns(i));
			X= P(:,cols);
			T(:,i)= sqrt(sum(X.* X, 2));
		end
		T= guarded_acos(T);
	end
end

function X= guarded_acos(X)
	X= acos(min(1, X));
end
