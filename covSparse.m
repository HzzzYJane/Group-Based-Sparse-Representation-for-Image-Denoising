function patch_out = covSparse(patch_in)
    
    patch_in = double(patch_in);
    
    patch_in_mean = repmat(mean( patch_in, 2 ), 1, size(patch_in, 2));
    
    patch_in = patch_in - patch_in_mean;
    
    patch_in_cov= patch_in * patch_in'/(size(patch_in, 2)-1);

    [U, S, V] = svd(patch_in_cov);
    
    alpha = U' * patch_in;
    
    alpha = sign(alpha).*max(abs(alpha) - 50,0);
    
    patch_in = U * alpha;
    
    patch_out = patch_in + patch_in_mean;
    
end