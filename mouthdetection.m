clear all
clc

location = char(load('C:\Users\sudha\Documents\MATLAB\a.txt'));
filename = char(load('C:\Users\sudha\Documents\MATLAB\b.txt'));

MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',125);
FDetect = vision.CascadeObjectDetector;


I = imread([location,filename]);

BB = step(FDetect,I);
nf=size(BB,1);

a=125;
BB = step(MouthDetect,I);
while(size(BB,1)>nf)
    a=a+25;
    MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',a);
    BB = step(MouthDetect,I);
end
while(size(BB,1)<nf && a>0)
    a=a-5;
    MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',a);
    BB = step(MouthDetect,I);
end

figure,
imshow(I); hold on
for i = 1:size(BB,1)
 rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
end
title('Mouth Detection');
hold off;