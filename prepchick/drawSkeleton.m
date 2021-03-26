function drawSkeleton(hAx, px, py, ps, scorebar)

global jointId;
global skeletonPair;

% joints
plot(px(ps>=scorebar), py(ps>=scorebar), '*');            
for jj = 1:1:size(skeletonPair,1)
    if all(ps(skeletonPair(jj,:))>=scorebar)
       plot(px(skeletonPair(jj,:)),py(skeletonPair(jj,:)));
    end
end