% d= subspace_dist(L1, L2)
% returns the distance between the subspaces represented by L1 and L2
% (both orthonormal) as measured by the norm of the vector of principal
% angles between the subspaces.
function d= subspace_dist(L1, L2)
	S= svd(L1.'* L2);
	k= min(size(L1,2), size(L2,2));
	d= norm(acos(S(1:k)));
end
