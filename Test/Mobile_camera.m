%%%Using IP address to connect your android mobile camera

%%Install MATLAB support package for IP Cameras

%%Install IP Webcam app in your android mobile

%%Go to IP Webcam app in your mobile and Start server(Begin serving video stream)

%Give value for the variabe x

x = false;

% x = false means x = 0

%Note your mobile IP address

%If you will use public Wi-Fi connection when you will connect VPN with
%your mobile or
%computer for security purpose


%Enter the noted IP address in url

url = ('http://192.168.43.1:8080/shot.jpg?rnd=350264');

%Use vision.VideoPlayer to get the video player 

video=vision.VideoPlayer();

%If the entered url is correct the variabe x is not false it means x get
%some value

%We use the following while loop to get video from the IP address 

while ~x
    
    a=imread(url);
    
    %imread is use to read the RGB value from the mobie camera
    
    step(video,a);
    
    %image command is used to get images from the RGB value
    
    b=image(a);
    
end