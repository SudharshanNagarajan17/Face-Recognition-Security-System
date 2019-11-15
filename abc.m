clear all
clc

location = char(load('C:\Users\sudha\Documents\MATLAB\a.txt'));
filename = char(load('C:\Users\sudha\Documents\MATLAB\b.txt'));
retType = num2str('');
save('C:\Users\sudha\Documents\MATLAB\ret.txt','retType','-ascii');

%%
a=dir(['C:\Users\sudha\Documents\MATLAB\facedb\','*.jpg']);
n=size(a,1);

FDetect = vision.CascadeObjectDetector;

I = imread([location,filename]);

BB = step(FDetect,I);

if (size(BB,1) ~= 1)
    retType = num2str('notUnique');
    save('C:\Users\sudha\Documents\MATLAB\ret.txt','retType','-ascii');
    return;
end

J = imcrop(I, BB(1, :));
J = imresize(J, [110, 110], 'bicubic');
imwrite(J,[location,'temp.jpg']);
filename = 'temp.jpg';

%%
FDetect = vision.CascadeObjectDetector;
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',4);
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',125);
EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',3);

I = imread([location,filename]);

%%
BB = step(MouthDetect,I);
a=125;
while(size(BB,1)==0 && a>0)
    a=a-5;
    MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',a);
    BB = step(MouthDetect,I);
end
while(size(BB,1)>1)
    a=a+25;
    MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',a);
    BB = step(MouthDetect,I);
end

mr1 = ceil(BB(2));
mr2 = mr1 + BB(3);
mc1 = ceil(BB(1));
mc2 = mc1 + BB(4);

%%
BB = step(EyeDetect,I);
a=3;
while(size(BB,1)==0 && a>0)
    a=a-1;
    EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',a);
    BB = step(EyeDetect,I);
end
while(size(BB,1)>1)
    a=a+1;
    EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',a);
    BB = step(EyeDetect,I);
end

er1 = ceil(BB(2));
er2 = er1 + BB(3);
ec1 = ceil(BB(1));
ec2 = ec1 + BB(4);

%%
BB = step(NoseDetect,I);
a=5;
while(size(BB,1)==0 && a>0)
    a=a-1;
    NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',a);
    BB = step(NoseDetect,I);
end
while(size(BB,1)>1)
    a=a+1;
    NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',a);
    BB = step(NoseDetect,I);
end

nr1 = ceil(BB(2));
nr2 = nr1 + BB(3);
nc1 = ceil(BB(1));
nc2 = nc1 + BB(4);

%%
ey=(ec1+ec2)/2;
ex1=er1;
ex2=er2;
ex3=(er1+er2)/2;

ny=(nc1+nc2)/2;
nx=(nr1+nr2)/2;

my=(mc1+mc2)/2;
mx1=mr1;
mx2=mr2;
mx3=(mr1+mr2)/2;

%%
a1=ex2-ex1
b1=mx2-mx1
c1=sqrt((ex3-nx)^2+(ey-ny)^2)
d1=sqrt((ex1-nx)^2+(ey-ny)^2)
e1=sqrt((ex2-nx)^2+(ey-ny)^2)
f1=sqrt((nx-mx3)^2+(ny-my)^2)
g1=sqrt((nx-mx1)^2+(ny-my)^2)
h1=sqrt((nx-mx2)^2+(ny-my)^2)
i1=sqrt((ex3-mx1)^2+(ey-my)^2)
j1=sqrt((ex3-mx2)^2+(ey-my)^2)
k1=sqrt((ex1-mx1)^2+(ey-my)^2)
l1=sqrt((ex2-mx2)^2+(ey-my)^2)

%%
clearvars -except a1 b1 c1 d1 e1 f1 g1 h1 i1 j1 k1 l1 I
%%
location = 'C:\Users\sudha\Documents\MATLAB\facedb\';
a=dir([location,'*.jpg']);
n=size(a,1);
if(n==0)
    retType = num2str('dbEmpty');
    save('C:\Users\sudha\Documents\MATLAB\ret.txt','retType','-ascii');
    return;
end
final=Inf;
for i=1:n
    filename = sprintf('%d.jpg',i);
    FDetect = vision.CascadeObjectDetector;
    NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',5);
    MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',125);
    EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',3);

    I2 = imread([location,filename]);
    %%
    BB = step(MouthDetect,I2);
    a=125;
    while(size(BB,1)==0 && a>0)
        a=a-5;
        MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',a);
        BB = step(MouthDetect,I2);
    end
    while(size(BB,1)>1)
        a=a+25;
        MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',a);
        BB = step(MouthDetect,I2);
    end
    mr1 = ceil(BB(2));
    mr2 = mr1 + BB(3);
    mc1 = ceil(BB(1));
    mc2 = mc1 + BB(4);

    %%
    BB = step(EyeDetect,I2);
    a=3;
    while(size(BB,1)==0 && a>0)
        a=a-1;
        EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',a);
        BB = step(EyeDetect,I2);
    end
    while(size(BB,1)>1)
        a=a+1;
        EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',a);
        BB = step(EyeDetect,I2);
    end

    er1 = ceil(BB(2));
    er2 = er1 + BB(3);
    ec1 = ceil(BB(1));
    ec2 = ec1 + BB(4);

    %%
    BB = step(NoseDetect,I2);
    a=5;
    while(size(BB,1)==0 && a>0)
        a=a-1;
        NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',a);
        BB = step(NoseDetect,I2);
    end
    while(size(BB,1)>1)
        a=a+5;
        EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',a);
        BB = step(EyeDetect,I2);
    end
    
    nr1 = ceil(BB(2));
    nr2 = nr1 + BB(3);
    nc1 = ceil(BB(1));
    nc2 = nc1 + BB(4);

    %%
    ey=(ec1+ec2)/2;
    ex1=er1;
    ex2=er2;
    ex3=(er1+er2)/2;

    ny=(nc1+nc2)/2;
    nx=(nr1+nr2)/2;

    my=(mc1+mc2)/2;
    mx1=mr1;
    mx2=mr2;
    mx3=(mr1+mr2)/2;

    %%
    a2=ex2-ex1
    b2=mx2-mx1
    c2=sqrt((ex3-nx)^2+(ey-ny)^2)
    d2=sqrt((ex1-nx)^2+(ey-ny)^2)
    e2=sqrt((ex2-nx)^2+(ey-ny)^2)
    f2=sqrt((nx-mx3)^2+(ny-my)^2)
    g2=sqrt((nx-mx1)^2+(ny-my)^2)
    h2=sqrt((nx-mx2)^2+(ny-my)^2)
    i2=sqrt((ex3-mx1)^2+(ey-my)^2)
    j2=sqrt((ex3-mx2)^2+(ey-my)^2)
    k2=sqrt((ex1-mx1)^2+(ey-my)^2)
    l2=sqrt((ex2-mx2)^2+(ey-my)^2)
    
    %%
    diff1=sqrt((a1-a2)^2+(b1-b2)^2+(c1-c2)^2+(d1-d2)^2+(e1-e2)^2+(f1-f2)^2+(g1-g2)^2+(h1-h2)^2+(i1-i2)^2+(j1-j2)^2+(k1-k2)^2+(l1-l2)^2)
    diff2=sqrt((abs(a1-a2)+abs(b1-b2)+abs(c1-c2)+abs(d1-d2)+abs(e1-e2)+abs(f1-f2)+abs(g1-g2)+abs(h1-h2)+abs(i1-i2)+abs(j1-j2)+abs(k1-k2)+abs(l1-l2))^2)
    diff3=sqrt((abs(a1-a2)+abs(b1-b2)+abs(c1-c2)+abs(d1-d2))^2+(abs(e1-e2)+abs(f1-f2)+abs(g1-g2)+abs(h1-h2))^2+(abs(i1-i2)+abs(j1-j2)+abs(k1-k2)+abs(l1-l2))^2)
    diff4=sqrt((abs(a1-a2)+abs(b1-b2)+abs(c1-c2)+abs(d1-d2)+abs(e1-e2)+abs(f1-f2))^2+(abs(g1-g2)+abs(h1-h2)+abs(i1-i2)+abs(j1-j2)+abs(k1-k2)+abs(l1-l2))^2)
    diff5=sqrt((abs(a1-a2)+abs(b1-b2))^2+(abs(c1-c2)+abs(d1-d2))^2+(abs(e1-e2)+abs(f1-f2))^2+(abs(g1-g2)+abs(h1-h2))^2+(abs(i1-i2)+abs(j1-j2))^2+(abs(k1-k2)+abs(l1-l2))^2)
    tfinal=(diff1+diff2+diff3+diff4+diff5)/5
    if(tfinal<final)
        final=tfinal;
        M=I2;
    end
end

%%
final
figure
subplot(1,2,1)
imshow(I)
title('Query face')
subplot(1,2,2)
imshow(M)
title('Best match')