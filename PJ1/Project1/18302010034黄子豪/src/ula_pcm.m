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