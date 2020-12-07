addpath SemanticSegOfMultispectralImagesUsingDeepLearningExample;%Skripty pro pohodlenjsi praci

% Tridy (slo by nacist z gTruth.mat)
classNames = ["forest","field","road","building","grass"];
cmap = jet(numel(classNames)); % veci pro hezke zobrazeni     
N = numel(classNames);
ticks = 1/(N*2):1/N:1;

%%
pathToNets ='nets/' ;% tam je ukryta sit
ss = dir(fullfile(pathToNets, 'deeplabv3mapy-*'));%Najdu vsechny site (na zacatku je jen jedna)
net = load(fullfile(pathToNets, ss(end).name)).net;%nacte tu posledni (asi tu nejlepsi)

predictPatchSize = [512 512];% po jak velkych kusech se bude dit segmentace
Im = imread('mapa5.png');

A6 = cat(3,Im, ones(size(Im,[1 2])));%potrebujeme pridat dalsi vrstvu (funguje tak sample skript)
segmentedImage = segmentImage(A6,net,predictPatchSize);%To je pomocna funkce

segmentedImage = medfilt2(segmentedImage,[7,7]);%

%zobrazeni
cmap_new = cmap([3 5 4 1 2],:);%preskladani, aby barvy sedely (zelene stromy atd)
B = labeloverlay(histeq(Im),segmentedImage,'Transparency',0.1,'Colormap',cmap_new);
figure
subplot 121;
imshow(B)

colorbar('TickLabels',cellstr(classNames),'Ticks',ticks,'TickLength',0,'TickLabelInterpreter','none');
colormap(cmap_new)
subplot 122; imshow(Im)