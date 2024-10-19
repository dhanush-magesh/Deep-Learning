clc
clear all
close all

DF1=[]

DF2=[]

for i = 1:6
    
%%= READ VIDEO           
str = int2str(i);
str = strcat(str,'.jpg');
a=imread(str) ;

% gray for first image 
[m n c]=size(a);
if c==3;
a=rgb2gray(a);
else
a=a;
end

a=imresize(a,[256 256]);



ref=imread('ref.jpg');

ref=imresize(ref,[256 256])

ori=imresize(a,size(ref(:,:,1)))


theta =subspace(double(ori),double(ref(:,:,1)));

tform = affine2d([cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1]);

nor = imwarp(ori,tform);


ori = a; 

Template=imresize(rgb2gray(imread('template.jpg')),[64 64]);

[m n o]=size(ori)

% this os only work for one window ....i need it for whole image
[m1 n1 o1]=size(Template)

for i=1:(m-m1+1)
    for j=1:(n-n1+1)
        out=ori(i:i+m1-1,j:j+n1-1);
        output=abs(out-Template);  % mean of image part under mask
   
    end 
end

match=(abs(ori-imresize(Template,size(a))))


% % % feature extraction

a1=imresize(match,[256 256]);

Image1=a1;
bsize1 = 8;
result1 = mat2cell(Image1, (8*bsize1)*ones(1,size(Image1,1)/(8*bsize1)), (8*bsize1)*ones(1,size(Image1,1)/(8*bsize1)));


for i=1:16

me1(i)=sum(sum((result1{i})));

end


% % % gradient features

gr=gradient(double(a))

ener=sum(sum(gr.^2));

en=entropy(gr)


FEAT=[me1 ener en];

DF1=[DF1 ;FEAT];


end
[f, p] = uigetfile('*.jpg;');
% in1=input('ENTER IMAGE :');

a=imread(f) ;

% gray for first image 
[m n c]=size(a);
if c==3;
a=rgb2gray(a);
else
a=a;
end

a=imresize(a,[256 256]);



ref=imread('ref.jpg');

ref=imresize(ref,[256 256])

ori=imresize(a,size(ref(:,:,1)))


theta =subspace(double(ori),double(ref(:,:,1)));

tform = affine2d([cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1]);

nor = imwarp(ori,tform);


ori = a; 

Template=imresize(rgb2gray(imread('template.jpg')),[64 64]);

[m n o]=size(ori)

% this os only work for one window ....i need it for whole image
[m1 n1 o1]=size(Template)

for i=1:(m-m1+1)
    for j=1:(n-n1+1)
        out=ori(i:i+m1-1,j:j+n1-1);
        output=abs(out-Template);  % mean of image part under mask
   
    end 
end

match=(abs(ori-imresize(Template,size(a))))


% % % feature extraction

a1=imresize(match,[256 256]);

Image1=a1;
bsize1 = 8;
result1 = mat2cell(Image1, (8*bsize1)*ones(1,size(Image1,1)/(8*bsize1)), (8*bsize1)*ones(1,size(Image1,1)/(8*bsize1)));


for i=1:16

me1(i)=sum(sum((result1{i})));

end


% % % gradient features

gr=gradient(double(a))

ener=sum(sum(gr.^2));

en=entropy(gr);


QF=[me1 ener en];




% xdata =  [DF1];
% 
% group = [1 -1 1 -1 1 -1 1 -1  ];
% svmStruct = svmtrain(xdata,group,'showplot',true);
% out = svmclassify(svmStruct,QF,'showplot',true)


figure,
subplot(3,3,1)

imshow(a)
title('original  MRI image ')

subplot(3,3,2)
imshow(a)
title('Median filtered MRI')

subplot(3,3,3)
imshow(nor)
title('registerd MRI image ')

subplot(3,3,4)
imshow(imresize(match,size(nor(:,:,1))))
title('matched  image ')


if out==1
    msgbox('NORMAL')   
else

msgbox('ALZHEIMER')
end
