%% konvolucni neuronky a rozpoznavani cislic

imds_train = ...%vytvorte imds_train z databaze v matlabu

%% struktura site
layers = []

%% vlastnosti pro trenovani
options = trainingOptions()

%% trenovani
net = trainNetwork()

%% tvorba testovaciho datasetu
imds_test = imageDatastore()

%% klasifikace a pouziti tranformacni fce
preproc_imds_test = transform(imds_test,@upravitObr )
coSiNeuronkaMysli = classify(net,preproc_imds_test)

%% funkce pro transformaci obrazku
function img = upravitObr(img)

img = 
end
