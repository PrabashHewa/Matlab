clc; clear all 
for q=1:100000 
    nbits = 128; 
nsamples = 1; 
x = random_binary(nbits,nsamples)+ i*random_binary(nbits,nsamples); 
y=x'; 
for tq = 1:2:length(y) 
    y1(tq)=y(tq); 
    y1(tq+1)=-conj(y(tq+1)); y2(tq)=y(tq+1);
    y2(tq+1)=conj(y(tq));
end 
k=128; M=4; t=k/M; 
for N=1:M i=1; j=1; 
    papr1(i) = OFDM_PAPR(y1); 
    papr2(i) = OFDM_PAPR(y2); 
    papr3(q)=(papr1(1)+papr2(1))/2; i=i+1; s1=y1;s2=y2;
    wa=s1((N-1)*t+1:N*t); 
    s1((N-1)*t+1:N*t)=s2((N-1)*t+1:N*t); 
    s2((N-1)*t+1:N*t)=wa; 
    papr1(i)= OFDM_PAPR(s1); 
    papr2(i) = OFDM_PAPR(s2); 
    i=i+1; j=j+1; s1=y1;s2=y2; 
    s1((N-1)*t+1:N*t)=-s1((N-1)*t+1:N*t);
    s2((N-1)*t+1:N*t)=-s2((N-1)*t+1:N*t); 
    papr1(i) = OFDM_PAPR(s1);
    papr2(i) = OFDM_PAPR(s2); 
    i=i+1; s1=y1;s2=y2; 
    wa=s1((N-1)*t+1:N*t); 
    s1((N-1)*t+1:N*t)=-s2((N-1)*t+1:N*t);
    s2((N-1)*t+1:N*t)=-wa; 
    papr1(i)= OFDM_CCDF(s1); 
    papr2(i) = OFDM_CCDF(s2); 
    avae=max(papr1,papr2); 
    [xcc,dl]=min(avae); 
    PAPR(N,:)=[papr1(dl) papr2(dl)]; 
end 
avaer=(PAPR(:,1)+PAPR(:,2))/2;
avaer=avaer'; 
[xc,dll]=min(avaer); 
PAPRo(q,:)=[PAPR(dll,1) PAPR(dll,2)];
PAPRoo(q)=(PAPR(dll,1)+PAPR(dll,2))/2; 
end 
%%%%%%%%%%% CCDF For CARI Signal%%%%%%%%%%%% 
th1=[]; pp12=[]; 
for papr0=3:0.5:14 nu=0; 
    for j=1:length(PAPRoo) 
        if PAPRoo(j)>=papr0 nu=nu+1; 
        end 
    end 
    nu=nu; 
    th3=nu/length(PAPRoo);
    th1=[th1 th3]; 
    dB=10*log10(papr0); 
    pp12=[pp12 dB]; 
end 
semilogy(pp12 ,th1 ,'o--m','LineWidth',2.5) 
hold on
%%%%%%% CCDF For Original Signal (Simulation)%%%%%% 
th=[]; 
for papr0=3:0.5:14 pg=0; 
    for j=1:length(papr3)
        if papr3(j)>=papr0 pg=pg+1;
        end 
    end 
    th4=pg/length(papr3); 
    th=[th th4]; 
end 
semilogy(pp12 ,th ,'>--g','LineWidth',2.5) 
hold on 
%%%%%%%% CCDF For Original Signal (Analysis)%%%%%%%%%% 
ccdf1=[]; 
for papr0=3:0.5:14 
    ccdf2 =1-(1-exp(-papr0))^k; 
    ccdf1=[ccdf1 ccdf2]; 
end
semilogy(pp12 ,ccdf1 ,'s--b','LineWidth',2.5), grid; 
hold on 
xlabel('PAPR0(dB)') 
ylabel('Pr(PAPR>PAPR0)') 
legend('CCDF SS-CARI','CCDF Simulation','CCDF analysis')