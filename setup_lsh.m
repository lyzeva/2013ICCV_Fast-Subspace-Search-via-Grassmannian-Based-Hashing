% H= setup_lsh(Ls, ns, k, L, d, quantizer)
% Prepare the data structure H used for queries, given
% a database of subspaces represented as columns of the matrix Ls.
% The vector ns gives the dimension of each subspace, so
% sum(ns) must equal the number of columns.
% a total of k* L  d-dimensional subspaces will be generated
% to provide L hash tables, where each key is k-elements.
% The function quantizer must take a matrix of pairwise
% distances between subspaces and generate integer keys
% out of each distance. The default splits the interval [0,pi/2]
% into 60 segments of with pi/120, so each key is a k-tuple
% of integers between 0 and 119 inclusive.
% Searc is performed y the function simple_search(...)
function H= setup_lsh(Ls, ns, k, L, d, quantizer)
	if nargin< 6
		quantizer= @(X)(floor((120/pi-eps)*X));
	end
	if nargin< 5
		d= 1;
	end
	N= size(Ls, 1);
	H= hash_set(N, k* L, d);
	H= train_lsh(H, Ls, ns);
	H= make_keys(H, k, L, quantizer);
end
