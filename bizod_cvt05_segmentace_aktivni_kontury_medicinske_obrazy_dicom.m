addpath('imgs')
%% [0.2] nacist obrazek v dicomu ctslice
%Jaky je to rez?
%Co je na snimku zobrazeno?
%Z jakeho je to pristroje?

%prevedte pomoci mat2gray

info = dicominfo("ctslice.dcm");
Y = dicomread(info);
Ygray = mat2gray(Y);
imshow(Ygray);

%Jaky je to rez?
% transverzální rez plic z CT
info.SliceThickness

%Co je na snimku zobrazeno?
% Na snimku jsou zobrazeny plice
info.AdmittingDiagnosesDescription
info.BodyPartExamined

%Z jakeho je to pristroje?

info.Modality
%vyrobce
info.Manufacturer
%seriove cislo zarizeni
info.DeviceSerialNumber


%% [0.3] slice2.dcm
%Ceho je to snimek? Jaky je to rez?

info = dicominfo("slice2.dcm");
X = dicomread(info);
Ygray2 = mat2gray(X);
imshow(Ygray2);

info.Modality % OT = other
% nevime, ceho je to snimek - neuvedeno v informacích
% leva srdeci komora, transverzalni rez

%% [0.3] zjistit informace o slice2 - kdy byl snimek porizen
% snimek byl porizen YYYY-MM-DD
info.ContentDate %(The date the image pixel data creation started) 
                 %snimek byl porizen 2016-12-28

%% [2] segmentujte levou plici

%na snimku ctslice
%pro inicialni segmentaci vyuzijte fci roipoly
%pro upravu segmentace vyuzijte napr. bwfill
%upravte parametry fce activecontour, tak aby seg. byla co nejlepsi


mask = roipoly(Ygray2);
bw = activecontour(Ygray2,mask,500);
bw2 = bwfill(bw,'holes');
imshow(Ygray2+bw2);

%% [0.3] --- MRI hlavy - Nacist a zobrazit
%soubor mri
%kouknete co vse obsahuje
%zobrazte pomoci fce montage (vcetne mapy)
%predelejte na 3D (misto 4D. Bude se s tim lepe pracovat)

D2 = reshape(D,[128 128 27]);% jde to pze, 3. rozmer je 1
D3 = mat2gray(D2);%roztahnu rozsah
montage(D(:,:,:,:),map);

%% [0.3] transverzalni rez (useknuta hlava)
P = D(:,:,:,13);
imshow(P,[]);%transverzalni rez ze 4D dat

%% [0.3] sagitalni rez (skrze usi "koukam")
rez_sagitalni = D3(:,50,:);%vyzobnu snimek v sagitali rovine
rez_sagitalni = reshape(rez_sagitalni,128,27);
rez_sagitalni = imresize(rez_sagitalni,[128,128]);% zvetsim,aby to lepe vypadalo
 
imshow(rez_sagitalni);


%% [0.3] frontalni (koronarni)(vrstvy obliceje)
%orotuju cely objekt, potom si snimek vyzvednu z posledniho rozmeru
R3 = makeresampler({'cubic','nearest','neares'},'fill');
T4 = maketform('affine',[-2.5 0 0; 0 1 0; 0 0 -0.5; 68.5 0 61]);
C = tformarray(D,T4,R3,[4 2 1],[1 2 4],[66 128 45],[],0);
C2 = padarray(C,[6 0 0 0],0,'both');
figure, imshow(C2(:,:,:,44),map)







