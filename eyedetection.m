clear all
clc

location = char(load('C:\Users\sudha\Documents\MATLAB\a.txt'));
filename = char(load('C:\Users\sudha\Documents\MATLAB\b.txt'));

EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',3);
FDetect = vision.CascadeObjectDetector;


I = imread([location,filename]);

BB = step(FDetect,I);
nf=size(BB,1);

BB = step(EyeDetect,I);
a=3;
while(size(BB,1)>nf)
    a=a+1;
    EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',a);
    BB = step(EyeDetect,I);
end
while(size(BB,1)<nf && a>0)
    a=a-1;
    EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',a);
    BB = step(EyeDetect,I);
end
figure,
imshow(I); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','b');
end
title('Eyes Detection');
hold off;