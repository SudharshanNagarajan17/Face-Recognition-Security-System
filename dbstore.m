clear all
clc

location = char(load('C:\Users\sudha\Documents\MATLAB\a.txt'));
filename = char(load('C:\Users\sudha\Documents\MATLAB\b.txt'));

a=dir(['C:\Users\sudha\Documents\MATLAB\facedb\','*.jpg']);
n=size(a,1);

FDetect = vision.CascadeObjectDetector;

I = imread([location,filename]);

BB = step(FDetect,I);

h=figure;
for i = 1 : size(BB, 1) 
  J = imcrop(I, BB(i, :));
  subplot(3, 3, i);
  imshow(J);
  J = imresize(J, [110, 110], 'bicubic');
  imwrite(J,['C:\Users\sudha\Documents\MATLAB\facedb\',sprintf('%d.jpg',i+n)])
end
h.NextPlot='add';
a=axes;
ht=title('Faces stored in the DB');
a.Visible='off';
ht.Visible='on';