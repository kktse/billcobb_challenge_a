M=importdata('marc5.csv');
descr=char(M.textdata(1));
inx=findstr(descr,'SR='); 
SR = str2double(descr(inx+3:inx+6)) 
inx=findstr(descr,'WB=');
WB = str2double(descr(inx+3:inx+6))/1000 
inx=findstr(descr,'WF=');
WF = str2double(descr(inx+3:inx+7))
inx=findstr(descr,'WR=');
WR = str2double(descr(inx+3:inx+7))
A  =WB*WR/(WF+WR)
B  =WB-A
nruns= M.data(end,3)
time    = reshape(M.data(:,1),[],nruns);
ayg     = reshape(M.data(:,2),[],nruns);
% run     = reshape(M.data(:,3),[],nruns);
beta    = reshape(M.data(:,4),[],nruns);
speed   = reshape(M.data(:,5),[],nruns);
steer   = reshape(M.data(:,6),[],nruns);
yawvel  = reshape(M.data(:,7),[],nruns);
ACKPG     = 9.806*180/pi*WB./mean(speed/3.6).^2;
K  = gradient(steer(end,:)/SR)./gradient(ayg(end,:)) -ACKPG;
DR =    -gradient(beta(end,:))./gradient(ayg(end,:)) +B/WB*ACKPG;  
DF = DR + K;
figure('menubar','none','numbertitle','off','name','Vehicle Dynamics Professionals Facebook Group Challenge: Step Steer Test Procedure')
subplot(2,2,1);hold on,grid on

plot( ayg(end,:) ,DF,'m-','LineWidth',2)
plot( ayg(end,:) ,DR,'b-','LineWidth',2)
plot( ayg(end,:) ,K ,'g-','LineWidth',2)
ylim([-2 18])
title(descr)
xlabel('Steady State Lateral Acceleration (g)')
ylabel({'Cornering Compliances';'& Understeer (deg/g)'})
legend('Front Cornering Compliance','Rear Cornering Compliance','Understeer')   %,'Oversteer','Location','Best')
href(0)
for n=1:nruns
    [swa_OS(n) ,swa_Ts(n) ,swa_Tr(n)] =stepspecs(t,steer(:,n),[],50);
    [yawv_OS(n),yawv_Ts(n),yawv_Tr(n)]=stepspecs(t,yawvel (:,n),[],90);
    [beta_OS(n),beta_Ts(n),beta_Tr(n)]=stepspecs(t,beta(:,n),[],90);
    [ayg_OS(n) ,ayg_Ts(n) ,ayg_Tr(n)]=stepspecs(t,ayg (:,n),[],90);
end
subplot(2,2,2);hold on,grid on
plot(ayg(end,:),swa_Tr,'ko-',ayg(end,:),yawv_Tr + swa_Tr,'mo-',ayg(end,:),beta_Tr + swa_Tr,'bo-',ayg(end,:),ayg_Tr  + swa_Tr,'ro-')
xlabel('Steady State Lateral Acceleration (g)')
ylabel('10% - 90% Rise Time (sec)')
ylim([0 .8])
legend('Steer Angle','Yaw Velocity','Sideslip','Lateral Acceleration') 
subplot(2,2,3);hold on,grid on
plot(ayg(end,:),yawv_OS,'mo-',ayg(end,:),beta_OS,'bo-',ayg(end,:),ayg_OS ,'ro-')
xlabel('Steady State Lateral Acceleration (g)')
ylabel('% Overshoot')
ylim([0 25])
legend('Yaw Velocity','Sideslip','Lateral Acceleration') 
subplot(2,2,4);hold on;grid on
plot(ayg(end,:),yawv_Ts,'mo-',ayg(end,:),beta_Ts,'bo-',ayg(end,:),ayg_Ts ,'ro-')
xlabel('Steady State Lateral Acceleration (g)')
ylabel('Settling Time (sec)')
ylim([0 .8])
legend('Yaw Velocity','Sideslip','Lateral Acceleration')