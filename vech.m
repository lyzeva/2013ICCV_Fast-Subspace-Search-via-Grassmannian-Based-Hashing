function x= vech(A)
    n= size(A,1);
    M= triu(ones(n))+diag(diag(ones(n)));
    idx= find(M(:));
    A= A- diag(diag(A)) + diag(diag(A)/sqrt(2));
    x= A(idx);
end
