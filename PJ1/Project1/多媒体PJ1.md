# 多媒体PJ1

By 黄子豪 18302010034

## 量化效果图

![image-20201102151336091](C:\Users\LENOVO\AppData\Roaming\Typora\typora-user-images\image-20201102151336091.png)

## 代码说明

均匀量化：

```matlab
function [a_quan]=u_pcm(a,n)
%U_PCM  	uniform PCM encoding of a sequence
%       	[A_QUAN]=U_PCM(A,N)
%       	a=input sequence.
%       	n=number of quantization levels (even). (这里就实现了可变的量化级数)
%		a_quan=quantized output before encoding. (量化编码后的输出)

% todo: 
amax = max(abs(a)); % 找到采样点的最大值
a_quan = a ./ amax; % 将采样点映射到(-1, 1)
for i = -1 : 2 / n : 1 % 将(-1, 1)分成n段，即量化级数
    a_quan_point = a_quan(a_quan >= i & a_quan < (i + 2 / n)); % 获取在(i, i + 2 / n)范围内的采样点
    a_quan(a_quan >= i & a_quan < (i + 2 / n)) = amax * (max(a_quan_point) + min(a_quan_point)) / 2; % 将这些采样点设为（最大值 + 最小值） / 2
end
end

```

把输入范围等分成n份，步长为2/n，在这个区间范围内的点值都设为这个区间的最大值和最小值之和的一半

$$\mu$$律非均匀量化：

```matlab
function [z]=ulaw(y,u)
%		u-law nonlinearity for nonuniform PCM
%		X=ULAW(Y,U).
%		Y=input vector.

% todo: 
z = sign(y) .* log(1 + u * abs(y ./ max(abs(y)))) ./ log(1 + u); % ppt上的公式
end
```

这里直接对于整个输入向量采用$$\mu$$律非均匀量化公式

```matlab
function [a_quan]=ula_pcm(a,n,u)
%ULA_PCM 	u-law PCM encoding of a sequence
%       	[A_QUAN]=MULA_PCM(X,N,U).
%       	X=input sequence.
%       	n=number of quantization levels (even).     	
%		a_quan=quantized output before encoding.
%       U the parameter of the u-law

% todo: 
%这里先u律压缩再逆运算，模仿的是先压缩再扩张
x = ulaw(a, u);     % u律压缩
y = u_pcm(x, n);    % 均匀量化
a_quan = inv_ulaw(y, u); % u律压缩逆运算
end
```

然后还是过一遍上面的均匀量化

最后实施信号扩张，还原原来的信号量

```matlab
function x=inv_ulaw(y,u)
%INV_ULAW		the inverse of u-law nonlinearity
%X=INV_ULAW(Y,U)	X=normalized output of the u-law nonlinearity.

% todo: 
x = sign(y) .* (((1 + u) .^ (abs(y)) - 1) ./ u); % 公式，ulaw的反函数
end
```



## 非均匀量化的优点

- 改善小信号的量化信噪比：经过非线性变换后，量化噪声对大、小信号的影响差不多

-  总体量化误差低：小信号出现的频率一般高于大信号，非均匀量化在小信号范围内提供更多的量化级，使小信号能取得更小的量化误差。

  所以综合而言，非均匀量化能大大减少量化信号所需的编码位数。