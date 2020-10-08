%% MATLAB veci 
% 
% * *TAB*       pro doplneni nazvu funkce, ci promenne.
% * *F1*        napoveda v kontextovem okne
% * *close all* zavre vsechny figury
% * *ctrl + D*  otevre promennou nebo funkci
% * *F9*        spusti oznacenou cast kodu
% * *ctrl + Enter* spusti kod aktualni bunky
% * *subplot 235* rozdeli figuru do gridu o 2 radcich 3 sloupcich a vpisuje
% do pate bunky
 
%% zobrazit obrazek
A = imread('saturn.png');% obrazek je v matlabu 
which('saturn.png') %zobrazi cesu
imshow(A)%zobrazi obrazek

%% obrazek v jine slozce
addpath('Slozka'); % v pripade, ze neni obrazek ve slozce
A = imread('kytka256.jpg');
imshow(A);
%% rozdelit na barevne kanaly
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);
Ag = rgb2gray(A);

imshow(R)% je to sedive, protoze je to jen jedna matice

figure;title('jednotlive slozky jako gray')
subplot(2,2,1);imshow(A)
subplot(2,2,2);imshow(R)
subplot(2,2,3);imshow(G)
subplot(2,2,4);imshow(Ag)

% oku lahodici zobrazeni 
nuly=zeros(size(Ag));
R1=cat(3,R,nuly,nuly); %doplneni nulovymi maticemi
G1=cat(3,nuly,G,nuly);
B1=cat(3,nuly,nuly,Ag);

figure;title('jednotlive slozky barevne')
subplot(2,2,1);imshow(A)
subplot(2,2,2);imshow(R1)
subplot(2,2,3);imshow(G1)
subplot(2,2,4);imshow(B1)

%% zmenit barvu prohozenim kanalu

subplot 121 
imshow(A)
NoveBarvy = cat(3,G,B,R);
subplot(1,2,2)
imshow(NoveBarvy);

%% RGB2GRAY vs Prumer ve 3. rozmeru 
Gray = rgb2gray(A); % prevede na sedoton
Gray_prumer = mean(A,3);
subplot 121,
imshow(Gray);title('sedoton funkci rgb2gray')
subplot 122,
imshow(uint8(Gray_prumer));title('sedoton prumerovanim')

%% jak zjistit jestli jsou obrazky stejne
% je to vazeny prumer
numel(Gray());
RovnaSe = Gray == Gray_prumer;
imshow(RovnaSe) % tam kde je to stejne jsou bile pixely

%% kolik procent pixelu je stejnych
f = sum(RovnaSe,'all');
procentoStejnych = f/ numel(Gray) *100;
disp(['Stejnych pixelu: ' num2str( procentoStejnych) ' %' ]);

%% Metrika pro zachyceni rozdilnosti obrazu mean-sqared error
h = immse(double(Gray),Gray_prumer) % umocneny prumerny rozdil v hodnotach jasu

%% Cernobili (binarni) obraz

for ii = 0:0.05:1
 BW = imbinarize(Gray,ii); % menim prah pro binarizaci
 imshow(BW);
end
 
%% indexovy obraz
[Aind,cmap] = rgb2ind(A,3);% prevedu na 3 barvy
cmap(1,:) = 0; %prvni
cmap(2,:) = 1;%a druhou zmenim na cernou a bilou
imshow(Aind,cmap)

%% bonus: ukladani do gifu
img = imread('coloredChips.png');
%imshow(img)
img_gray = rgb2gray(img);
krok = 1;
for ii = 0:5:255
    
   curr_obr = (img_gray<ii)*255;%aby se to rozlezlo od 0 do 255
   [A,map] = gray2ind(curr_obr,2); 
   
    if krok == 1 %prvni snimek se uklada jinak nez ostatni 
        imwrite(A,map,'testAnimated.gif','gif','LoopCount',Inf,'DelayTime',0.001);
    krok = 0;
    else
        imwrite(A,map,'testAnimated.gif','gif','WriteMode','append','DelayTime',0.001);
    end 
end
 

 
 








