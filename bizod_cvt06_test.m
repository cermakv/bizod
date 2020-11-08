%% --- Segmentace Lucni boudy - reseni

%% Nacteni a prevedeni na gray a HSV
addpath('imgs');
A = imread('lucni.jpg');
Ag = rgb2gray(A);

%%  prozkoumani histogramu 
imhist(Ag) % na histogramu jsou 3 peaky, chci vydolovat ten prvni
m = multithresh(Ag,2);% proto 2 prahy
%% binariaze a morfilogicke operace
Vb = ~imbinarize(Ag,double(min(m))/255);%vemu ten mensi prah

VbClose = imclose(Vb,strel('rectangle',[8 12]));%"priplacne" vezicky k chate
VbOpen = imopen(VbClose,strel('disk',1));%odstrani male objekty
BW = imclose(VbOpen,strel('disk',10));%zalepi diry (i ty co nejsou uplne diry)
BW = bwareafilt(BW,1);% vezme ten nejvetsi objekt
imshowpair(A,BW)


%% --- Alternativni reseni (pouziti aktivnich kontur)
%zvetsim chalupu, tak aby tam s jistotou byla cela
mask = imdilate(Vb,strel('disk',10));
mask = bwareafilt(mask,1);
imshow(mask)
%% necham presne k chalupe doiterovat aktivni kontury
BW = activecontour(uint8(Vb*255),mask,100,'edge','SmoothFactor',0.3);
BW = bwareafilt(BW,1);

imshowpair(A,BW);