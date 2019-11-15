clear all
clc

location = char(load('C:\Users\sudha\Documents\MATLAB\a.txt'));
filename = char(load('C:\Users\sudha\Documents\MATLAB\b.txt'));

FDetect = vision.CascadeObjectDetector;
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',50);
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',125);
EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',3);

I = imread([location,filename]);

figure,
imshow(I); hold on

%%
BB = step(FDetect,I);
nf=size(BB,1);
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','r');
end

%%
BB = step(MouthDetect,I);
a=125;
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
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','g');
end

%%
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
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
end

%%
BB = step(NoseDetect,I);
a=50;
while(size(BB,1)>nf)
    a=a+5;
    NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',a);
    BB = step(NoseDetect,I);
end
while(size(BB,1)<nf && a>0)
    a=a-1;
    NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',a);
    BB = step(NoseDetect,I);
end
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','b');
end

%%
title('Feature Detection');
hold off;