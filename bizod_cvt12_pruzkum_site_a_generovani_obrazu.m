%%Pruzkum site a generovani obrazu
%% nacteni site a obrazku

%% analyze network

%% aktivace na treti konvolucni vrstve

aktivace %??

aktivace_4d = reshape(aktivace,size(aktivace,1) , size(aktivace,2) , 1 , size(aktivace,3) );
aktivace_4d = imadjustn (mat2gray (aktivace_4d));% uprava pro zobrazeni aby jas nepretekal

figure
montage(aktivace_4d);
%% === zlobivy obrazek ===

%% na sqeezenetu klasifikovat

%klasifikuje to jako ___ s __% pravdepodobnosti
% je to nejak na obrazku poznat, ze by to mohla byt tato trida?

%% kombinace s kytkou
% napoveda: A*alfa + I*(1-alfa);
%% klasifikace s kombinaci

%% imshow kombinace s vysledkem klasifikace

