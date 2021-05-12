imname = "gray_satomi.jpg";
I = imread(imname);
J = imadjust(I, [0.2, 0.6], [0, 1]);% 灰度拉伸，把0.2-0.6的均匀拉伸到0-1，而小于0.2的直接设为0，大于0.6的直接设为1
H = histeq(I);                      % 直方图均衡化
figure
subplot(2, 2, 1), imshow(J), title("灰度拉伸");
subplot(2, 2, 2), imshow(H), title("直方图均衡化");
subplot(2, 2, 3), imhist(I), title("灰度分布直方图");
subplot(2, 2, 4), imhist(H), title("直方图均衡化");