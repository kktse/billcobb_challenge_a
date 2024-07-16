M=importdata('marc4.txt');
descr=char(M.textdata(1));
inx=findstr(descr,'SR='); 
SR = str2double(descr(inx+3:inx+6)) 
inx=findstr(descr,'WB=');
WB = str2double(descr(inx+3:inx+6))/1000 
inx=findstr(descr,'WF=');
WF = str2double(descr(inx+3:inx+6))
inx=findstr(descr,'WR=');
WR = str2double(descr(inx+3:inx+5))
A  =WB*WR/(WF+WR)
B  =WB-A
ayg     = M.data(:,2);
beta    = M.data(:,3);
speed   = M.data(:,4);
steer   = M.data(:,5);
u       = speed/3.6;
ACKPG   = 9.806*180/pi*WB/mean(u)^2 
subplot(1,1,1)
hold on
sp=csaps(ayg,steer/SR,.999);
spd=fnder(sp)
K = fnval(spd,ayg)-ACKPG;
sp= csaps(ayg,beta,.999);
spd = fnder(spd,ayg);
DR = fnval(spd,ayg) - B/WB*ACKPG;
DF = DR + K;
plot( ayg ,DF,'m-','LineWidth',2)
plot( ayg ,DR,'b-','LineWidth',2)
plot( ayg ,K ,'g-','LineWidth',2)
grid on
ylim([-2 6])
title(descr)
inx=find(K < 0);
plot(ayg(inx),K(inx),'r-','LineWidth',2)
xlabel('Lateral Acceleration (g)')
ylabel('Cornering Compliances & Understeer (deg/g)')
legend('Front Cornering Compliance','Rear Cornering Compliance','Understeer','Oversteer','Location','Best')
href(0)
