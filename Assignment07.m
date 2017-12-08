%% Tymothy Anderson
% CEC495a Assignment 07

clear all
close all

I1 = imread('base.jpg');
I3 = imread('sub.jpg');

% Generate points of interest structures
Ipts1 = OpenSurf(I1);
Ipts3 = OpenSurf(I3);

% Grab just the descriptor vectors
for k = 1:length(Ipts1)
    D1(:,k) = Ipts1(k).descriptor;
end

for j = 1:length(Ipts3)
    D3(:,j) = Ipts3(j).descriptor;
end

%% Compare base and sub images

BaseLength = length(Ipts1);
SubLength = length(Ipts3);

for i = 1:BaseLength
    subtract = ( repmat(D1(:,i), [1 SubLength]) - D3).^2;
    distance = sum(subtract);
    [SubValue(i) SubIndex(i)] = min(distance);
end

% Sort matches
[value, index] = sort(SubValue);

% Associate index values
BaseIndex = index;
SubIndex = SubIndex(index);

% Generate positions of points
Pos1 = [ [Ipts1(BaseIndex).y]', [Ipts1(BaseIndex).x]' ];
Pos3 = [ [Ipts3(SubIndex).y]', [Ipts3(SubIndex).x]' ];

% Find distances
diffX = Pos3(:,2) - Pos1(:,2);
diffY = Pos3(:,1) - Pos1(:,1);

% Find angles
angles = atan2d( diffY, diffX );
angles = round(angles);
angle = mode(angles);
indexMode = find(angles > angle-1 & angles < angle+1);

% Plot points on both images
I = cat(2,I1,I3);
figure(1), imshow(I); hold on;

plot( [Pos1(indexMode,2) Pos3(indexMode,2) + size(I1,2)]', ...
    [Pos1(indexMode,1) Pos3(indexMode,1)]', 's-','linewidth',2);

hold off;

clear variables
%% Compare toys and toy images
I1 = imread('toys.jpg');
I3 = imread('toy.jpg');

Ipts1 = OpenSurf(I1);
Ipts3 = OpenSurf(I3);

% Grab just the descriptor vectors
for k = 1:length(Ipts1)
    D1(:,k) = Ipts1(k).descriptor;
end

for j = 1:length(Ipts3)
    D3(:,j) = Ipts3(j).descriptor;
end

BaseLength = length(Ipts1);
SubLength = length(Ipts3);

for i = 1:BaseLength
    subtract = ( repmat(D1(:,i), [1 SubLength]) - D3).^2;
    distance = sum(subtract);
    [SubValue(i), SubIndex(i)] = min(distance);
end

% Sort matches
[value, index] = sort(SubValue);

% Associate index values
BaseIndex = index;
SubIndex = SubIndex(index);

% Generate positions of points
Pos1 = [ [Ipts1(BaseIndex).y]', [Ipts1(BaseIndex).x]' ];
Pos3 = [ [Ipts3(SubIndex).y]', [Ipts3(SubIndex).x]' ];

% Find distances
diffX = Pos3(:,2) - Pos1(:,2);
diffY = Pos3(:,1) - Pos1(:,1);

% Find angles
angles = atan2d( diffY, diffX );
angles = round(angles);
angle = mode(angles);
indexMode = find(angles > angle-1 & angles < angle+1);

% Plot points on both images
I = cat(2,I1,I3);
figure, imshow(I); hold on;

plot( [Pos1(indexMode,2) Pos3(indexMode,2) + size(I1,2)]', ...
    [Pos1(indexMode,1) Pos3(indexMode,1)]', 's-','linewidth',2);