I = imread('satomi.jpg');                % 读取文件
J2 = imnoise(I, 'salt & pepper', 0.04); % 叠加密度为0.04的椒盐噪声。
filter1 = medfilt3(J2,[3 3 1]);          % 中值,窗口大小为3×3
h = fspecial('average');         % 均值,窗口大小为3×3
filter2 = imfilter(J2, h);
figure
subplot(2, 1, 1), imshow(J2), title("加椒盐噪图片");                     % 显示图像
subplot(2, 2, 3), imshow(filter1), title("中值滤波");                    
subplot(2, 2, 4), imshow(filter2), title("均值滤波");