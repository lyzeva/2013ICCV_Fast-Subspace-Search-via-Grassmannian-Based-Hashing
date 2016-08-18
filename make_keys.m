% H= make_keys(H, k, L, quantizer)
function H= make_keys(H, k, L, quantizer)
	if nargin~= 4
		error('make_keys expects 4 arguments');
	end
	if H.K~= k* L
		error('mismatch between available hashes and table size');
	end
	T= quantizer(H.T).'; % M-by-K now
	keys= {};
	proj= {};
	for i= 1:L
		keys{i}= T(:,(i-1)*k+1:i*k);
		proj{i}= H.G((i-1)*k*H.d+1:i*k*H.d,:);
	end
	H.keys= keys;
	H.proj= proj;
	H.quant= quantizer;
end
