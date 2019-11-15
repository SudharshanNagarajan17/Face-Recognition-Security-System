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
obj = VideoReader([vidLocation,'\',vidFilename]);
%%
n=0;
i=0;
while hasFrame(obj)
    n=n+1;
    this_frame = readFrame(obj);
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
  
  EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',3);
  I = imread([location,filename]);

  figure,
  imshow(I); hold on

%%
BB = step(EyeDetect,I);
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
end

%%
title('Feature Detection');
hold off;
iii=iii+1;
end