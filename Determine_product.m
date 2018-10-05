%%     Coded by Rafsan Uddin Beg Rizan              %%
%%     CSE 12batch                                  %%
%%     Patuakhali Science and Technology University %%

%% Testing Product.
clc;
clear all;
close all;

%% Arduino setup
% a_uno= arduino('com4','uno');
% servo1 = servo(a_uno, 'D4');
% servo2 = servo(a_uno, 'D3');

%% Take picture from Webcam
cam = videoinput('winvideo', 1, 'RGB24_1280x720');
src = getselectedsource(cam);
cam.FramesPerTrigger = 1;
preview(cam);
src.FocusMode = 'manual';
src.Focus = 25;
src.FrameRate = '15.0000';
preview(cam);


while 1
    chack_value=input('Enter 0 to take picture 0 :');
if chack_value==0
    
  image_read = getsnapshot(cam);
  imshow(image_read);


%% Uncomment to take picture from computer
% [fname, path]=uigetfile('*','Image to find the class');
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




%% Finding out the product class
Feature_test=FeatureStatistical (image_red,image_green,image_blue);


%% Compare with Database
load db.mat
Feature_train=db(:,1:6);
Class_train= db(:,7);

for(i=1:size(Feature_train,1))
    distance(i,:)=sum(abs(Feature_train(i,:)-Feature_test));
end
minnimum_distance_for_rejection=min(distance);


minimum=find(distance==min(distance),1);
determine_class=Class_train(minimum);


msgbox(strcat('Detected Class :',num2str(determine_class)));
chack_value=1
else (chack_value==-1)
   disp('Exiting');
   break;
end

end

