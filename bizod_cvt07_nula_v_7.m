%Muze se hodit
addpath(genpath('imgs/7v0'));%prida vcetne podslozek
imds = imageDatastore('imgs/7v0','IncludeSubfolders',true,'LabelSource','foldernames');
vsechny_obr = imds.readall();
%% Algoritmus 1 - pocty pixelu v horni a dolni polovine
%okrouhne bily okraj
%spocita pixely v horni a dolni polovine
%jejich pomer je cca stejny u nuly
% u sedmicky je vyssi

kopieVsechny = vsechny_obr;
for ii = 1:length(vsechny_obr)
    aktualni = vsechny_obr{ii};
    p0b = ~imbinarize(rgb2gray(aktualni));
    stats = regionprops(p0b,'FilledImage');
    p0b = stats.FilledImage;
    pulka = round(size(p0b,1)/2);
    horniPulka = sum(p0b(1:pulka,:),'all');
    dolniPulka = sum(p0b(pulka+1:end,:),'all');
    pomer = horniPulka/dolniPulka;
    kopieVsechny{ii} = insertText(aktualni,[1 1],num2str(pomer),'FontSize',36);
    
end
montage(kopieVsechny);title('Pomer pixelu v horni/dolni polovine')
%% Dalsi napady (souckmi):
%Pocet protnuti transverzalnim rezu
%kulatost
