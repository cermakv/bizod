addpath('imgs')
%% nacteni neuronky
net = 
%% nacteni videa
v = VideoReader('kancl2.mp4');

%% 4D strukture

%% klasifikace

%% vytazeni hodnot u klavesnice a nejcastejsi tridy

%% diskuze k vysledku

%% veci, ktere se mohou hodit
net.Layers(1).InputSize;
v.FrameRate
net.Layers(end).ClassNames
analyzeNetwork(net)

