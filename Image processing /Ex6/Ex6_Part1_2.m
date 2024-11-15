%Part a
a = 0.5 * ones(128, 128);
% A = fft2(a);
% A_shifted = fftshift(A);
F = fft2(a);
Fc = fftshift(F);
H = ones(size(a));
G = H .* Fc;
gi = ifft2(ifftshift(G));
g = real(gi);


figure(1)
subplot(1,2,1)
imshow(a);
title('Constant value 0.5')
subplot(1,2,2)
% imshow(log(abs(A_shifted) + 1), []);
imshow(log(abs(Fc) + 0.0001));
title('Constant value 0.5 DFT')

%Part b
b = 0.5 * ones(128, 128);
b(54:73, 54:73) = 1;
% B = fft2(b);
% B_shifted = fftshift(B);
Fb = fft2(b);
Fcb = fftshift(Fb);
Hb = ones(size(b));
Gb = Hb .* Fcb;
gib = ifft2(ifftshift(Gb));
gb = real(gib);

figure(2)
subplot(1,2,1)
imshow(b);
title('white square in the middle')
subplot(1,2,2)
% imshow(log(abs(B_shifted) + 1), []);
imshow(log(abs(Fcb) + 0.0001));
title('white square in the middle DFT')

%Part c
[x, y] = meshgrid(linspace(0, 1, 128), linspace(0, 1, 128));
c = x;
% C = fft2(c);
% C_shifted = fftshift(C);
Fc = fft2(c);
Fcc = fftshift(Fc);
Hc= ones(size(c));
Gc = Hc .* Fcc;
gic = ifft2(ifftshift(Gc));
gc = real(gic);

figure(3)
subplot(1,2,1)
imshow(c);
title('Ramp in horizontal axis, constant in vertical axis')
subplot(1,2,2)
% imshow(log(abs(C_shifted) + 1), []);
imshow(log(abs(Fcc) + 0.0001))
title('Ramp in horizontal axis, constant in vertical axis DFT')

%Part d
d = zeros(128, 128);
d(64, 64) = 1;
% D = fft2(d);
% D_shifted = fftshift(D);
Fd = fft2(d);
Fcd = fftshift(Fd);
Hd = ones(size(d));
Gd = Hd .* Fcd;
gid = ifft2(ifftshift(Gd));
gd = real(gid);

figure(4)
subplot(1,2,1)
imshow(d);
title('Delta function at the center')
subplot(1,2,2)
% imshow(log(abs(D_shifted) + 1), []);
imshow(log(abs(Fcd) + 0.0001));
title('Delta function at the center DFT')

%Part e
a1 = 0:1:127;
a2=  0:1:127;
CosA = cos((2*pi*a1)/128);
CosB = cos((2*pi*a2)/128);
[x, y] = meshgrid(CosA, CosB);
e = 0.5*x + 0.5*y ;
% E = fft2(e);
% E_shifted = fftshift(E);
Fe = fft2(e);
Fce = fftshift(Fe);
He = ones(size(e));
Ge = He .* Fce;
gie = ifft2(ifftshift(Ge));
ge = real(gie);

figure(5)
subplot(1,2,1)
imshow(e);
title('Cosine signal')
subplot(1,2,2)
% imshow(log(abs(E_shifted) + 1), []);
imshow(log(abs(Fce) + 0.0001));
title('Cosine signal DFT')
