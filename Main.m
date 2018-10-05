
%%     Coded by Rafsan Uddin Beg Rizan              %%
%%     CSE 12batch                                  %%
%%     Patuakhali Science and Technology University %%

clc;
clear all;
close all;

%% Arduino setup
a_uno= arduino('com4','uno');
servo1 = servo(a_uno, 'D8');
servo2 = servo(a_uno, 'D2');
lock1 = servo(a_uno, 'D9');
lock2 = servo(a_uno, 'D3');
%% Take picture from Webcam
vid = videoinput('winvideo', 1, 'RGB24_1280x720');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

preview(vid);
src.FocusMode = 'manual';

src.Focus = 5;

%% Close all gate
servo1_angle=1;
writePosition(servo1,servo1_angle);
pause(1);

lock1_angle=.5;
writePosition(lock1,lock1_angle);
pause(1);


servo2_angle=.4;
writePosition(servo2,servo2_angle);
pause(1);

lock2_angle=.8;
writePosition(lock2,lock2_angle);
pause(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Uncomment of you want to do manual snapshot
% chack_value=input('Enter 0 to take picture 0 :');
% if chack_value==0
%   image_read = getsnapshot(cam);
% end

nFrame = 1; % Frame number initialization

%% Processing Loop
while(1)
    
    in=input('Press 0 to take photo :');
    if(in==0)
        image_read = getsnapshot(vid);
        image_red = image_read(:,:,1); % Red channel
        image_green = image_read(:,:,2); % Green channel
        image_blue = image_read(:,:,3); % Blue channel
        
        %% Resize the image
        image_red=imresize(image_red,[200 200]);
        image_green=imresize(image_green,[200 200]);
        image_blue=imresize(image_blue,[200 200]);
        
        % subplot(2,2,1);
        % imshow(image_red);
        % subplot(2,2,2);
        % imshow(image_green);
        % subplot(2,2,3);
        % imshow(image_blue);
        
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
        
        %% Controling arduino
        if determine_class ==1
            
            servo1_angle=.3;
            writePosition(servo1,servo1_angle);
            pause(1);
            lock1_angle=1;
            writePosition(lock1,lock1_angle);
            pause(1);
            
            
            
            servo2_angle=.4;
            writePosition(servo2,servo2_angle);
            pause(1);
            
            lock2_angle=.8;
            writePosition(lock2,lock2_angle);
            pause(1);
            msgbox('Detected Class : Fully Ripe');
        end
        
        
        if determine_class ==2
            
            servo2_angle=1;
            writePosition(servo2,servo2_angle);
            pause(1);
            lock2_angle=.2;
            writePosition(lock2,lock2_angle);
            pause(1);
            
            servo1_angle=1;
            writePosition(servo1,servo1_angle);
            pause(1);
            
            lock1_angle=.5;
            writePosition(lock1,lock1_angle);
            pause(1);
            msgbox('Detected Class : Medium Ripe');
            
        end
        
        %% Skip class 4
        if determine_class == 3
            %%msgbox(strcat('Detected Class :',num2str(determine_class)));
            %%disp(determine_class);
            servo1_angle=1;
            writePosition(servo1,servo1_angle);
            pause(1);
            
            lock1_angle=.5;
            writePosition(lock1,lock1_angle);
            pause(1);
            
            
            servo2_angle=.4;
            writePosition(servo2,servo2_angle);
            pause(1);
            
            lock2_angle=.8;
            writePosition(lock2,lock2_angle);
            pause(1);
            
            msgbox('Detected Class : Green');
        end
        
        
        
        
        %% Skip class 4
        if determine_class == 4
            %%msgbox(strcat('Detected Class :',num2str(determine_class)));
            %%disp(determine_class);
            servo1_angle=1;
            writePosition(servo1,servo1_angle);
            pause(1);
            
            lock1_angle=.5;
            writePosition(lock1,lock1_angle);
            pause(1);
            
            
            servo2_angle=.4;
            writePosition(servo2,servo2_angle);
            pause(1);
            
            lock2_angle=.8;
            writePosition(lock2,lock2_angle);
            pause(1);
            
        end
        nFrame = nFrame+1;
    else
        disp('Please press 0 not other key');
        servo1_angle=1;
        writePosition(servo1,servo1_angle);
        pause(1);
        
        lock1_angle=.5;
        writePosition(lock1,lock1_angle);
        pause(1);
        
        
        servo2_angle=.4;
        writePosition(servo2,servo2_angle);
        pause(1);
        
        lock2_angle=.8;
        writePosition(lock2,lock2_angle);
        pause(1);
    end
    
    if in==9
        break;
    end
    
end
%% Clearing Memory
delete(vid);
clear all;
close all hiden;
close all force;
clc;