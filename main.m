% Read Image
img_path = './Test_Images/';
files = dir([img_path, '*.tif']);

psnr_file = fopen('psnr.txt', 'w');

for i = 1 : length(files)
    
    cim = imread([img_path, files(i).name]);
    
    nim = imnoise(cim, 'gaussian', 0, 0.01); % Add Noise
    dnim = uint8(GBsimple(nim)); % Group-Based Method
    save([files(i).name, '_0.01.mat'], 'cim', 'nim', 'dnim');
    
    fprintf(psnr_file, files(i).name);
    fprintf(psnr_file, ' 0.01 nim: %.3f dB  dnim: %.3f dB \n', ...
    psnr(nim, cim), psnr(dnim, cim));

    nim = imnoise(cim, 'gaussian', 0, 0.1); % Add Noise
    dnim = uint8(GBsimple(nim)); % Group-Based Method
    save([files(i).name, '_0.1.mat'], 'cim', 'nim', 'dnim');

    fprintf(psnr_file, files(i).name);
    fprintf(psnr_file, ' 0.1 nim: %.3f dB  dnim: %.3f dB \n', ...
    psnr(nim, cim), psnr(dnim, cim));

    nim = imnoise(cim, 'gaussian', 0, 0.3); % Add Noise
    dnim = uint8(GBsimple(nim)); % Group-Based Method
    save([files(i).name, '_0.3.mat'], 'cim', 'nim', 'dnim');
    
    fprintf(psnr_file, files(i).name);
    fprintf(psnr_file, ' 0.3 nim: %.3f dB  dnim: %.3f dB \n', ...
    psnr(nim, cim), psnr(dnim, cim));

end

fclose(psnr_file);