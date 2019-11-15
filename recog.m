clear all
clc

[fname path]=uigetfile('.jpg','open for training');
fname=strcat(path,fname);
im=imread(fname);
imshow(im);

c=input('1-10');
F=FeatureStatical(im);
try
    load db;
    F=[F c];
    db=[db;F];
    save db.mat db
catch
    db=[F c];
    save db.mat db
end
