%%     Coded by Rafsan Uddin Beg Rizan              %%
%%     CSE 12batch                                  %%
%%     Patuakhali Science and Technology University %%

function [Feature]=FeatureStatistical (image_red,image_green,image_blue)
%% RED
image_red = gpuArray(image_red);
image_standard_deviation_red= std2(image_red);
image_mean_red=mean2(image_red);

%% GREEN
image_green = gpuArray(image_green);
image_standard_deviation_green= std2(image_green);
image_mean_green=mean2(image_green);

%% BLUE
image_blue = gpuArray(image_blue);
image_standard_deviation_blue= std2(image_blue);
image_mean_blue=mean2(image_blue);





Feature= [ image_standard_deviation_red, image_mean_red,  image_standard_deviation_green, image_mean_green , image_standard_deviation_blue, image_mean_blue];
end
