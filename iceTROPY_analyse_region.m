% iceTROPY_analyse_region
%   2014 June 13, EJR
%
%
%

% 1. INPUTS
flagInvertSelection   = 0;   % To select outside a polygon

flagSelectPolygon     = 0;
flagSelectByThreshold = 1;

% Settingf for threhold selection:
brighnessPercentThreshold = 40;
radiusDilation  = 15;


%    The user must select the region of interest
if(flagSelectPolygon)
  figure(2)  % Make sure figure 2 (the anisotropy output of iceTROPY) is open
  myPolyMask = roipoly;
end
if(flagSelectByThreshold)
  figure(2)
  imIntZeroed = imageIntensity - min(imageIntensity(:));
  myThreshold = (brighnessPercentThreshold/100)*max(imIntZeroed(:));
  myThreshMask  = imIntZeroed > myThreshold;
  
  se3        = strel('disk',radiusDilation);
  myPolyMask = imdilate(myThreshMask,se3);
end


% 2. PROCESS

mySelectedAnisotropies = imageAnisotropy(myPolyMask);

meanAnis = mean(mySelectedAnisotropies);
stdAnis  = std(mySelectedAnisotropies);


% 3. OUTPUTS:
disp(['Mean selected anisotropy: ', num2str(meanAnis)]);
% disp(['Std dev selected anisotropy: ', num2str(stdAnis) ]);

figure(5) 
 hist(mySelectedAnisotropies(:), 0:0.01:0.4 );
 title('Thresholded anisotropy histogram','FontSize',14)
 xlim([0 0.4]) % May need to rescale for 2-photon measurements
 % ylim([0 10000])
 ylabel('Pixels','FontSize',14);
 xlabel('Anisotropy','FontSize',14);
 set(gca,'FontSize',14);
 
figure(6)
 imageAnisMasked = imageAnisotropy;
 imageAnisMasked(not(myPolyMask)) =0;
 imagesc(imageAnisMasked);
   myCols = colormap;
   myCols(1,:) = [0,0,0]; % A bit of a bodge...
   colormap(myCols);
   colorbar
 title('Thresholded anisotropy image','FontSize',14)
 axis image
 caxis([0 0.4])