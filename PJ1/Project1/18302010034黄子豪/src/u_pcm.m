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
