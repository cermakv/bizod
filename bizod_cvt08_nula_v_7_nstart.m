%% Natrenovat sit pro rozpoznani cislic a vzhodnotit 0 a 7.
% https://zodoc.tech/posts/en/training_of_convolutional_neural_network_for_classification_of_handwritten_digits
% http://yann.lecun.com/exdb/mnist/
%%  7 v 0 na neuronkach
dataFolder = fullfile(toolboxdir('nnet'),'nndemos','nndatasets','DigitDataset');
imds_train = imageDatastore(dataFolder, ...
    'IncludeSubfolders',true, ....
    'LabelSource','foldernames');
%imds7_0_train = subset(imds_train,find(ismember( imds_train.Labels, categorical([7,0]))));

%%
layers = [
    imageInputLayer([28 28 1]) % input layer (grayscale image with size of 28x28 pixels)
    convolution2dLayer(5,16,'Padding', 'same') % 16 convolution filters with size of 5
    batchNormalizationLayer % normalization layer
    reluLayer %relu for additional non-linearity (input lower than 0 is changed to 0, otherwise it still unchanged)
    
    convolution2dLayer(8,20,'Padding', 'same') % 16 convolution filters with size of 5
    batchNormalizationLayer % normalization layer
    leakyReluLayer %relu for additional non-linearity (input lower than 0 is changed to 0, otherwise it still unchanged)
    
    fullyConnectedLayer(10) % 10 - number of neurons 
    softmaxLayer % normalization
    classificationLayer 
];

%% specify options
options = trainingOptions('sgdm',...% type of solver
    'Verbose', false,...% dont output in command window
    'Plots', 'training-progress',...% plot nice graph with training progress
    'MaxEpoch',5)%use every training image 5 times
%%
net = trainNetwork (imds_train, layers, options); % training of CNN

%%
%% tvorba datasetu pro testovani
imds_test = imageDatastore('imgs/7v0','IncludeSubfolders',true,'LabelSource','foldernames');
vsechny_obr = imds_test.readall();
%% tvorba tranformacniho datasetu a klasifikace
preproc_imds_test = transform(imds_test,@upravitObr )
coSiNeuronkaMysli = classify(net,preproc_imds_test)
%% zobrazeni co dela tranformace
montage(preproc_imds_test.readall())

%% to jen trochu mimo
cm = confusionchart(imds_test.Labels,categorical(string(coSiNeuronkaMysli)));
%convert to string bcs it "breaks" the connection to all original classes
    

%% funkce pro tranformaci
function data = upravitObr(data)
p0b = ~imbinarize(rgb2gray(data));

img = regionprops(p0b,'Image').Image;
dv = 5;%kolikatina obrazku bude vyuzita jako padding
img = padarray(img,[round(size(img,1)/dv) round(size(img,2)/dv)]);
data = imresize(uint8(img*255),[28 28]);
end