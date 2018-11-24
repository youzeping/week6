
clear;
clc;

% ====== parameter begin ======================= 
im_mul = double(imread('American_MUL.bmp'));
im_pan = double(imread('American_PAN.bmp'));
[ylen, xlen, c] = size(im_mul);

R = im_mul(:,:,1);
G = im_mul(:,:,2);
B = im_mul(:,:,3);

im_fus = zeros(ylen, xlen, 3);
% ====== parameter end =========================


% RGB ==> IHS ���任����
tran1 = [ 1/3,         1/3,         1/3;       
          -sqrt(2)/6,  -sqrt(2)/6,  sqrt(2)/3;      
          1/sqrt(2),   -1/sqrt(2),  0         ];
% IHS ==> RGB ��任����
tran2 = [ 1,  -1/sqrt(2),  1/sqrt(2);       
          1,  -1/sqrt(2),  -1/sqrt(2);      
          1,  sqrt(2),     0           ];

trans_in = [reshape(R, 1, ylen*xlen); ...
            reshape(G, 1, ylen*xlen); ...
            reshape(B, 1, ylen*xlen)];

% ���� RGB ==> IHS ���任
trans_res = tran1 * trans_in;
% ���� PAN �滻 I ����
trans_res(1,:) = reshape(im_pan, 1, ylen*xlen);
% ���� IHS ==> RGB ���任
trans_res = tran2 * trans_res;

% �ѱ任������浽 im_fus ��
im_fus(:,:,1) = reshape(trans_res(1, :), ylen, xlen);
im_fus(:,:,2) = reshape(trans_res(2, :), ylen, xlen);
im_fus(:,:,3) = reshape(trans_res(3, :), ylen, xlen);
im_fus = uint8(im_fus);

imwrite(im_fus, 'American_FUS.bmp');
American_FUS=imread('American_FUS.bmp');
imshow(American_FUS);

