addpath('imgs') %prida slozku s obrazky
A = imread('kytka256.jpg');
%segmentace
%% [0.4] segmentace kytky s pomoci graythresh
% pouzijte imbinarize 

%% [0.5] Segmentace pøevedením do HSV
%prevedte do hsv,odstinovou matici segmentujte pomoci otsu metody 
%vysledkem bude barevna kytka na sedotonovem pozadi
%colorThresholder se vam hodi pro pochopeni
%nemusite to delat pomoci k-means

%% cell.tif
% vyzkousejte si pro pochopeni, 
% kompletni navod je na mathworks
% https://www.mathworks.com/help/images/detecting-a-cell-using-image-segmentation.html
% nemusite sem vyplnovat

%% [1.1] Hledání pøerušované èáry na silnici
S = imread('zauta.jpg');
%naleznete prerusovanou caru na silnici a barevne ji v sedotonovem obrazu 
% oznacte
%pouzijte podobnych postupu jako v prikladu s bunkou. 
