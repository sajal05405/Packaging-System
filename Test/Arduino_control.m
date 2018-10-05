clc;
clear all;
a= arduino('COM4','uno');
s1 = servo(a, 'D3');
s2 = servo(a, 'D2');
for i = 1:15
    angle=input('Angle .1-1:');
       writePosition(s2, angle);
       pause(2);    
end


% for i = 1:15
%     angle=input('Angle .1-1:');
%        writePosition(s2, angle);
%        pause(2);    
% end

clear all;
      
