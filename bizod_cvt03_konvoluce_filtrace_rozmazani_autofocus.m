addpath('imgs')
%pracujte s sedotonovou reprezentaci obrazu (je to jednodussi)
%pracujte s obrazkem kytka256.jpg
A = imread('kytka256.jpg');
Ag = rgb2gray(A);

%% vytvorte a vyfiltrujte signal
x = randi(10, 1, 10);
for i=1:length(x)-2 %"rucni" konvoluce
  konv1(i) = sum(x(i:i+2))/3;
end

y = [1/3 1/3 1/3];
konv2 = conv(x,y,'valid');

plot(x,'b')
hold on;
plot(2:length(konv1)+1,konv1,'r')
hold on;
plot(2:length(konv2)+1,konv2,'g')
legend('puvodni signal','rucni konvoluce','konvoluce')

%% Obraz M a jadro J 
M = [10 20 30;
     40 50 60;
     70 80 90];

J = [1/4 1/4;
     1/4 1/4];
 
kon2 = conv2(M,J,'valid');

%%

N = [-1 0 1 -1 0 1 -1 0 1];
kytkaKon = conv2(Ag, N);

imshow(kytkaKon)

%% Poskozeni obrazku vzexponovanym pixelem

Agposkozeny = Ag;
Agposkozeny(45:50,45:50) = 255;

N = zeros(10,10);
N = N+1/100;
 
subplot 131 ;imshow(Agposkozeny)
Agkonv = conv2(Agposkozeny, N);
AgkonvR = (uint8(Agkonv));
subplot 132;imshow(AgkonvR);title ('avg filtr')

% vyfiltrovani pixelu vhodnou maskou

AGposkGau = imgaussfilt(Agposkozeny, 5); 
subplot 133;imshow(AGposkGau);title('gauss filtr')

%% Rozmazte obrazek mimo kytku
Abin = uint8(rgb2gray(A)>128);% prahování obrazu

f_gaussian = fspecial('gaussian',20,4); % konstrukce gaussovského filtru
A_gaussian = imfilter(A,f_gaussian,'same');% uplatnìní filtru. 'same' -> stejná velikost i po filtraci
Abin_rgb = repmat(Abin,[1 1 3]);%nareplikování binárního obrazu do 3 rozmìrù (aby se tím dal násobit RGB obraz)
A_selective_blur = Abin_rgb.*A + (1-Abin_rgb).*A_gaussian; %nerozmazaná èást + rozmazaná èást

imshow(A_selective_blur)



%% Ktery ze 2 obrazku je ostrejsi
%doporucuji to delat pomoci hran a funkce edge.

Agrozm = imgaussfilt(Ag, 3.3);

%smerodatna odchylka
K = std2(Ag);
L = std2(Agrozm);
if (K > L) 
    disp("Podle smerodatne odchzlkz je Ag ostrejsi");
else
    disp("Podle smerodatne odchzlkz je Agrozm ostrejsi");
end

%pocet hran
K = sum(edge(Ag),'all');% druhy zpusob jak delat sum sum
L = sum(sum(edge(Agrozm)));
if (K > L) 
    disp("Podle poctu hran Ag je ostrejsi");
else
    disp("Podle poctu hran Agrozm je ostrejsi");
end
%% Hledani nejostrejsiho snimku ve videu.

v = VideoReader('podzimni_kvetena_focus_test.mp4');
o = 0;
nejostrajsiSnimek = [];
while hasFrame(v)
    frame = readFrame(v);
    frameG = rgb2gray(frame);
    sumedge_curr = sum(edge(frameG),'all');
    if (sumedge_curr) > o
        nejostrajsiSnimek = frame;
        o = sumedge_curr;
    end
end
imshow(nejostrajsiSnimek);
