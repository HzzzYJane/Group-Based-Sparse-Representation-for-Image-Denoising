function x = ADMMlasso(patch_in, std_im)
    
    patch_in = double(patch_in);
    
    b_mean = repmat(mean( patch_in, 2 ), 1, size(patch_in, 2));
    
    patch_in = patch_in - b_mean;
    
    b_cov= patch_in * patch_in'/(size(patch_in, 2)-1);

    [A, ~, ~] = svd(b_cov); % U = Dictionary
    
    std_patch = mean(std(patch_in));
    lambda = std_im * std_patch / 25;
    
    x = A'*patch_in;
    z = 0;
    y = 0;
    
    loss = @(x)(0.5*norm(A*x - patch_in, 2) + lambda*norm(x, 1));
    
    admm_par = 1;

    for i = 1 : 100
        
        f = loss(x);
        
        x = (A'*A + (1/admm_par)*eye(size(A,1)))^(-1)*(A'*patch_in + (1/admm_par)*(z-y));
        
        z = sign(x+y).*max(abs(x+y) - lambda,0);
        
        y = y + (1/admm_par)*(x - z);
        
%         fprintf("Step: [%d]. Loss Function: [%.3f]\n", i, loss(x));
        
        if abs(loss(x) - f) < 10e-6
            
            break
        end
        
    end
    
    x = A * x; % Recover Image from Sparse Coefficient
    
    x = x + b_mean; % Final Estimation
    
end
© 2020 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
