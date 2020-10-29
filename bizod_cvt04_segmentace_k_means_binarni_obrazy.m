addpath('imgs') %prida slozku s obrazky
A = imread('kytka256.jpg');
%segmentace
%% [0.8] segmentace kytky s pomoci graythresh
% pouzijte imbinarize 
Ag = rgb2gray(A);
th = graythresh(A);

Agb = imbinarize(Ag, th);

%% [1] Segmentace pøevedením do HSV
%prevedte do hsv,odstinovou matici segmentujte pomoci otsu metody 
%vysledkem bude barevna kytka na sedotonovem pozadi
%colorThresholder se vam hodi pro pochopeni
%nemusite to delat pomoci k-means

A_hsv = rgb2hsv(A);

A_hsvH = A_hsv(:,:,1);
th = graythresh (A_hsvH);%nalezeny prah, kde je a neni kytka

A_hsvTh=A_hsvH<th;%tam kde neni kytka
A_hsv2= A_hsv;%kopie obrazu
A_hsv2(:,:,2) =A_hsv2(:,:,2) .* A_hsvTh; %tam kde neni kytka, tak se vynuluje saturace (druhy "kanal")

A2 = hsv2rgb(A_hsv2);%prevod z5 do rgb

imshow(A2,[])

%% cell.tif
% vyzkousejte si pro pochopeni, 
% kompletni navod je na mathworks
% https://www.mathworks.com/help/images/detecting-a-cell-using-image-segmentation.html
% nemusite sem vyplnovat

clc; close all; clear all;
 
cell = imread('cell.tif'); %nacteni obrazku
 
cell_edges= edge(cell,'prewitt',0.03); %detektce hran Prewittovou metodou
cell_dilated = imdilate(cell_edges,strel('disk',5)); %binarni dilatace diskovitym tvarem s parametrem 5
cell_filled =  imfill(cell_dilated,'holes'); % vyplneni der v obrazku
cell_bordercleared = imclearborder(cell_filled); % X obj. na hrane
cell_eroded = imerode(cell_bordercleared,strel('disk',5)); % binarni eroze obrazu
 
cell_segm=bwperim(cell_eroded); % binarni obraz obsahujici perimetr obrazu
cell_segm2=cell; % kopie puvodniho sedotonu
cell_segm2(cell_segm==1)=255; % tam kde je perimetr 1 dám bilou barvu v sedotonovem obrazku
subplot(2,4,1) %zobrazeni v subplotu
imshow(cell);title('puvodni')
subplot(2,4,2)
imshow(cell_edges);title('hrany')
subplot(2,4,3)
imshow(cell_dilated);title('dilatovany')
subplot(2,4,4)
imshow(cell_filled);title('vyplneny')
subplot(2,4,5)
imshow(cell_bordercleared);title('oddeleni objektu')
subplot(2,4,6)
imshow(cell_eroded);title('erodovany objekt')
subplot(2,4,7)
imshow(cell_segm2);title('zobrazeni perimetru v puvodnim')


%% --- [2.2] Hledání pøerušované èáry na silnici
A = imread('zauta.jpg');
%naleznete prerusovanou caru na silnici a barevne ji v sedotonovem obrazu 
% oznacte
%pouzijte podobnych postupu jako v prikladu s bunkou.
 
Ag = rgb2gray(A);
imshow(A)
iptsetpref ImshowBorder tight %nezobrazi sede okraje
%%
Bwobrazek = imbinarize(Ag, 230/255);
imshow(Bwobrazek)
 
%% odstraneni malych objektu
BezMalychObjektu = bwareaopen(Bwobrazek, 300);
imshow(BezMalychObjektu)
 
%% vycisteni hran obrazku
VycisteneHrany = imclearborder(BezMalychObjektu);
imshow(VycisteneHrany)
% VycisteneHrany = BezMalychObjektu;
%% vyhleda regiony
[B, L] = bwboundaries(VycisteneHrany,'noholes');
% L - cely obrazek, cislo = cislo regionu
% imshow(L,[])% pro pochopeni obsahu promenne L
% B - cells - kolik cells, tolik regionu - v kazde z nich zapsane
% souradnice
pocetRegionu = max(L(:)); % maximalni cislo je pocet regionu, pze kazdemu regionu odpovida jedno cislo
imshow(label2rgb(L,'jet','k'))%jet - colormapa, 'k' - cerna jako nulova barva

 
%% Pouziti region props
vlastnostiRegionu = regionprops(L,'all');
ekcentricity = [vlastnostiRegionu.Eccentricity]; % da pole jednotlivych regionu
 
caryInd = find(ekcentricity>0.98);% vrati ty regiony, kde je ecc vyssi nez 0.98 (tzn primka)
% eccentricity - jak moc se to podoba kruhu (0) a primce (1)
 
%% zobrazeni car – vysledku 
imshow(Ag);
for ii = 1:length(caryInd)%jedu po regionech, ktere splnili tu podminku
%     pixelyAktualniCary = B{caryInd(ii)};
    aktCara = vlastnostiRegionu(caryInd(ii));
    pixelList = aktCara.PixelList;
    
    line(pixelList(:,1), pixelList(:,2),'Color','r' )% udelam caru pres vsechny body, ktere obsahuje region
end
 
 
