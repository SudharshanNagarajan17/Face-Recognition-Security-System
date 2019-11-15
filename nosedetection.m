clear all
clc

location = char(load('C:\Users\sudha\Documents\MATLAB\a.txt'));
filename = char(load('C:\Users\sudha\Documents\MATLAB\b.txt'));

NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',8);

I = imread([location,filename]);

BB = step(NoseDetect,I);

figure,
imshow(I); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','b');
end
title('Nose Detection');
hold off;