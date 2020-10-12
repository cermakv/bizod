A = imread('kytka256.jpg');

%% Zmena jasu
subplot 131; imshow(A-50);%jas se snizi odectenim
subplot 132; imshow(A);
subplot 133; imshow(A+50);

%% Vymaz casti
Avymaz = A;
Avymaz(150:200,130:180,:) = 0;
imshow(Avymaz)
%% Barevny pruh
Ag = rgb2gray(A);
Ag3 = cat(3,Ag,Ag,Ag);
Ag3(120:150,:,:) =A(120:150,:,:); 
imshow(Ag3)
%% ***** Histogramy *****
[counts, x] = imhist(Ag);%navrat hodnot (pro dalsi pouziti)
imhist(Ag)%rovnou zobrazi graf
%% Ekvalizace histogramu
P = imread('pout.tif');
subplot 221;imshow(P)%obrazek se spatnym histogramem
subplot 222;imhist(P)

Peq = histeq(P);%ekvalizace

subplot 223;imshow(Peq)
subplot 224;imhist(Peq)
%% "deekvalizace" histogramu
Ad = Ag/2+50;
subplot 221;imshow(Ag)
subplot 222;imhist(Ag)

subplot 223;imshow(Ad)
subplot 224;imhist(Ad)

%% Prosvecovacka ("adaptivni ekvalizase")

C=imread('dental_x-ray.png');

imshow(C);

[x,y, ~] = ginput(1); %vytvori gui pro kliknuti do obrazu

C(y-100:y+100,x-100:x+100) = histeq(C(y-100:y+100,x-100:x+100));
imshow(C)

%% adaptivni ekvalizace
subplot 211;imshow(C)
Cadapt = adapthisteq(C);
subplot 212;imshow(Cadapt)



