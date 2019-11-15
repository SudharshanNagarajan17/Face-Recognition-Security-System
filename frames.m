clear all
clc
%%
vidLocation = char(load('C:\Users\sudha\Documents\MATLAB\a.txt'));
vidFilename = char(load('C:\Users\sudha\Documents\MATLAB\b.txt'));
location = 'C:\Users\sudha\Documents\MATLAB\video\';
filePattern = fullfile(location, '*.jpg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(location, baseFileName);
    delete(fullFileName);
end
obj1 = VideoReader([vidLocation,'\',vidFilename]);
%%
n=0;
i=0;
while hasFrame(obj1)
    n=n+1;
    this_frame = readFrame(obj1);
    if(mod(n,400)==0)
        i=i+1;
        imwrite(this_frame,[location,sprintf('%d.jpg',i)]);
    end
end
%%


a=dir([location,'*.jpg']);
n=size(a,1);

iii=1;
while(iii<=n)
  filename = sprintf('%d.jpg',iii);
  FDetect = vision.CascadeObjectDetector;
  NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',75);
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
%{
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
%}
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','g');
end

%%
BB = step(EyeDetect,I);
%{
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
%}
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
end

%%
BB = step(NoseDetect,I);
%{
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
%}
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','b');
end

%%
title('Feature Detection');
hold off;
iii=iii+1;
end