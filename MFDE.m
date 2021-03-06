function Out_MFDE=MFDE(x,m,c,tau,Scale)
%
% This function calculates the multiscale fluctuation-based dispersion entropy (MFDE) of a univariate signal x
%
% Inputs:
%
% x: univariate signal - a vector of size 1 x N (the number of sample points)
% m: embedding dimension
% c: number of classes (it is usually equal to a number between 3 and 9 - we used c=6 in our studies)
% tau: time lag (it is usually equal to 1)
% Scale: maximu number of scale factors
%
%Outputs:
%
% Out_MFDE: a vector of size 1 * Scale - the MFDE of x
%
% EXAMPLE: MFDE(rand(1,1000),2,6,1,10)
%
% Ref:
% [1] H. Azami, S. Arnold, S. Sanei, Z. Chang, G. Sapiro, J. Escudero, and A. Gupta, "Multiscale Fluctuation-based
% Dispersion Entropy and its Applications to Neurological Diseases", IEEE ACCESS, 2019.
% [2] H. Azami, and J. Escudero, "Amplitude-and Fluctuation-Based Dispersion Entropy", Entropy, vol. 20, no. 3, p.210, 2018.
%
% If you use the code, please make sure that you cite the references [1] and [2].
%
% Hamed Azami
% hazami@mgh.harvard.edu and hmd.azami@gmail.com
%
%  17-April-2019
%%

Out_MFDE=NaN*ones(1,Scale);

Out_MFDE(1)=FDispEn_NCDF(x,m,c,tau);

sigma=std(x);
mu=mean(x);

for j=2:Scale
    xs = Multi(x,j);
    Out_MFDE(j)=FDispEn_NCDF_ms(xs,m,c,mu,sigma,tau);
end


function M_Data = Multi(Data,S)
%  generate the consecutive coarse-grained time series
%  Input:   Data: time series;
%           S: the scale factor
% Output:
%           M_Data: the coarse-grained time series at the scale factor S

L = length(Data);
J = fix(L/S);

for i=1:J
    M_Data(i) = mean(Data((i-1)*S+1:i*S));
end