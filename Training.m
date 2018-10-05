%%     Coded by Rafsan Uddin Beg Rizan              %%
%%     CSE 12batch                                  %%
%%     Patuakhali Science and Technology University %%

%% Taking an Image for training.
clc;
clear all;
close all;

%% Take picture from Webcam

vid = videoinput('winvideo', 1, 'RGB24_1280x720');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

preview(vid);
src.FocusMode = 'manual';

src.Focus = 5;

chack_value=input('Enter 0 to take picture 0 :');
if chack_value==0
  image_read = getsnapshot(vid);
end
delete(vid);

%% To take from picture computer file

% [fname, path]=uigetfile('*','Open a Image to training');
% fname =strcat(path,fname);
% image_read=imread(fname);


image_red = image_read(:,:,1); % Red channel
image_green = image_read(:,:,2); % Green channel
image_blue = image_read(:,:,3); % Blue channel




%% Resize the image 
image_red=imresize(image_red,[200 200]);
image_green=imresize(image_green,[200 200]);
image_blue=imresize(image_blue,[200 200]);
subplot(2,2,1);
imshow(image_red);
subplot(2,2,2);
imshow(image_green);
subplot(2,2,3);
imshow(image_blue);
title('Input product image');
class=input('Enter the class of the image (1-3) :');

%% Feature Extraction
Feature=FeatureStatistical (image_red,image_green,image_blue);
try
    load db;
    Feature=[Feature class];
    db=[db;Feature];
    save db.mat db
catch
    db =[Feature class];
    save db.mat db
end




 