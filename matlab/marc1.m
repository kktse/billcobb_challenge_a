M=importdata('marc1.txt');
descr=char(M.textdata(1));
inx=findstr(descr,'WB=');
wb = str2double(descr(inx+3:inx+6)); 
t=M.data(:,1);
dt = t(2)-t(1);
speed=M.data(:,2)*.27778;
yawvel=M.data(:,3)*pi/180;
urg = speed.*yawvel/9.806;
curv= yawvel./speed;
urg(1:1/dt/2)=[];
curv(1:1/dt/2)=[];
pp=polyfit(urg,curv,5);
ppd=polyder(pp); 
K= -wb/1000*180/pi*polyval(ppd,urg);
plot(urg,K,'b','linewidth',2)
xlabel('Steady State Lateral Acceleration (g)')
ylabel('Understeer (deg/g)')
title(M.textdata(1))
grid on
ylim([-2 18]);
vref(0.15)
text(.175,3,[num2str(interp1(urg,K,.15),3) ' deg/g @ 0.15g'],'fontweight','bold') 