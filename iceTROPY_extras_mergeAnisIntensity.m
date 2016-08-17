% Script to produce an video showing +ve anisotropy only where
% intensity is sufficiently high. (This is a test.)

imAnisF = 'C:\dSTORMdat\2013_05_30_GFPAnisData\a2Stack2_anisotropy.tif';
imIntF = 'C:\dSTORMdat\2013_05_30_GFPAnisData\a2Stack2_intensity.tif';

imOut = zeros(201,501,10);

for lpF = 1:10
    
    imAnis = imread(imAnisF,lpF);
    imInt  = imread(imIntF, lpF);
    
    imAnis(imInt < 2000) = 0;
    
    imOut(:,:,lpF) = imAnis;
    
    imwrite(imAnis,['masked\frame', int2str(lpF), '.png' ],'png')
end

