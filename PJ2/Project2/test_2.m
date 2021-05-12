imname = "satomi.jpg";
I = imread(imname);
I = im2double(I);                   % 将image转换为double型，方便计算
grayI = 0.29900 * I(:, :, 1) + 0.58700 * I(:, :, 2) + 0.11400 * I(:, :, 3); % 文档上的公式，进行三维空间到一维空间的映射
v = var(grayI(:));                  % 计算灰度图片的方差
imwrite(grayI, "gray_" + imname);   % 将灰度图片保存在gray_imname

figure
subplot(2, 1, 1), imshow(I), title("原图");
subplot(2, 1, 2), imshow(grayI), title("灰度图");

fprintf("灰度图保存在：gray_%s\n", imname);
fprintf("灰度图的方差为：%f\n", v);