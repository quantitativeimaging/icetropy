function [ flagRegd ] = iceTROPY_registration( fullFileReg )
% Gets user to specify registration of PAR and PPD images, with cpselect()
%   Typically the user may specify corners or fluorescent beads to do this

imReg = imread(fullFileReg);
flagFlipudReg = evalin('base','flagFlipudReg');

[imRegBG, imRegPAR, imRegPPD] =iceTROPY_segmentation(imReg, flagFlipudReg);
BGreg = mean(imRegBG(:));

% The cpselect tools likes "doubles" so in case we are handling 
% 32 bit FITS files (which we may well be), modify the data as follows
imRegPAR = double ( imRegPAR - BGreg );
imRegPPD = double ( imRegPPD - BGreg );
imRegPAR = imRegPAR ./ max(imRegPAR(:));
imRegPPD = imRegPPD ./ max(imRegPPD(:));

% In cpselect(in,base), "in" is to be warped to "base"
[input_points, base_points] = cpselect(imRegPAR, imRegPPD, ...
                                       'Wait',true);

mytform = cp2tform(input_points, base_points, 'projective');
                                   
assignin('base','base_points', base_points);
assignin('base','input_points',input_points);
assignin('base','mytform',mytform);

flagRegd = 1;
end

