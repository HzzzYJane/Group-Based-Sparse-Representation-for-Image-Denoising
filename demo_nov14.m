cim = imresize(imread('mri.png'), 0.25); % Read Original Image

nim = imnoise(cim); % Add Noise

dnim = uint8(GBsimple(nim)); % Group-Based Method

% Visualization

subplot(1,3,1);
imshow(nim,[]);
title('Noised Image')
subplot(1,3,2);
imshow(dnim, []);
title('Denoised Image')
subplot(1,3,3);
imshow(cim,[]);
title('Ground-Truth Image')

% Compute PSNR

fprintf("PSNR: \nNoised Image: %.3f dB \nDenoised Image: %.3f dB \n", ...
    psnr(nim, cim), psnr(dnim, cim));


h = figure;
subplot(1, 3, 1);
imshow(uint8(img));
title('Original')

subplot(1, 3, 2);
imshow(uint8(noisy_img));
title(['Noisy, PSNR = ', num2str(noisy_psnr, '%.2f')]);

subplot(1, 3, 3);
imshow(uint8(denoised_img));
title(['Denoised, PSNR = ', num2str(denoised_psnr, '%.2f')]);

