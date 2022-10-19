function pn = decoder(sound)
[y, fs] = audioread(sound);
tsamp = 0.01;
t = linspace(0,tsamp,tsamp*fs+1);
M = length(t);
N = floor(length(y)/M);
ys = reshape(y(1:(N*M)),M,N);
fL = [697 770 852 941];
fH = [1209 1336 1477 1633];
omega = 2*pi*fL';
w = exp(1j*omega*t);
yL = abs(w*ys)/M;
omega = 2*pi*fH';
w = exp(1j*omega*t);
yH = abs(w*ys)/M;
ndx = 1:4;
y1 = ndx*(yL>0.15);
y2 = ndx*(yH>0.15);
ndx = find(diff(y1)>0);
n1 = y1(ndx+2);
n2 = y2(ndx+2);
L=n2==0; n1(L)=[]; n2(L)=[];
[n1' n2']
key = ['147*'; '2580'; '369#'; 'ABCD'];
for k=1:length(n1)
    pn(k) =key(n2(k),n1(k));
end
end

