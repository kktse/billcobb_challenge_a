M=importdata('marc2.txt');
descr=char(M.textdata(1));
inx=findstr(descr,'WB=');
wb = str2double(descr(inx+3:inx+6))  
t=M.data(:,1);
dt    = t(2)-t(1);
speed = M.data(:,2);
steer = M.data(:,3);
yawvel= M.data(:,4);
t(1,:)     = []; %Don't include the time (0) data
steer(1,:) = [];  
yawvel(1,:)= [];
nfft = pow2(round(log2(length(steer)))); 
[yawvtxy,f]= tfestimate(steer,yawvel,rectwin(nfft),nfft/2,nfft,1/dt); % yawv by steer transfer function
inx=find(f > 3.0 | f < .01);
f(inx)=[];
yawvtxy(inx)=[];
delta_f=f(2)-f(1);
yawv_gain       = 100.*abs(yawvtxy);
yawv_phase      = angle(yawvtxy).*180/pi;
u= 0.277778*mean(speed)
K= 1/(yawv_gain(1)/100)- 9.806*180/pi*wb/1000/u/u  
[W,z]=damp(rsys);
subplot(2,1,1)
plot(f,yawv_gain)
ylabel('Yaw Velocity by Steer Gain (deg/sec/100 degSWA)')
ylim([0 30])
grid on
text(.02,22,['f(0)= ' num2str(yawv_gain(1),4)],'fontweight','bold') 
text(.02,18,['Understeer= ' num2str(K,3) ' deg/g'],'fontweight','bold') 
[mx,inx]=max(yawv_gain)
text(f(inx),mx,['Peak = ' num2str(mx,3)],'fontweight','bold') 
text(f(inx),15,['Peak/S.S Ratio = ' num2str(mx/yawv_gain(1),4) ],'fontweight','bold') 
text(f(inx),10,['\zeta = ' num2str(z(1),3)],'fontweight','bold') 
text(f(inx),5,['Peakf = ' num2str(f(inx),2) ' Hz.'],'fontweight','bold') 
vref(f(inx))
options    = optimset('MaxFunEvals',1000000,'TolFun',.0000001,'Display','off');
YM0        = [0  3. yawv_gain(1) .1 .1];  
[YM,error] = lsqcurvefit('splane2_fit',YM0 ,f,yawv_gain,[ ],[ ],options);
disp('YawVelocity by Steer:')
rsys        = tf([YM(1:3)],[YM(4:5) 1]) 
[num,den]  = tfdata(rsys,'v');
cn2=sprintf('%5.4f',num(1));
cn1=sprintf('%5.4f',num(2));
cn0=sprintf('%5.4f',num(3));
cd2=sprintf('%5.4f',den(1));
cd1=sprintf('%5.4f',den(2));
cd0=sprintf('%5.4f',1.);
subplot(2,1,2)
plot(f,yawv_phase)
ylabel('Yaw Velocity by Steer Phase (deg)')
ylim([-90 0])
grid on
title(descr)
xlabel('Frequency (Hz.)')
w=f*2*pi;
mytexstr = ['$\frac{R(s)}{\delta(s)}$ = $\frac{'   cn2 's^2 + ' cn1 's + ' cn0 '}{' cd2 's^2 + ' cd1 's + ' cd0 '}$'];
h = text('string',mytexstr,'interpreter','latex','fontsize',20,'units','norm','pos',[.05 .15]);
text(f(inx),-10,['Bandwidth = ' num2str(bandwidth(rsys)/2/pi,2) ' Hz.'],'fontweight','bold') 
text(f(inx),-22,['\tau_r = ' num2str(2/bandwidth(rsys) ,2) ' sec.'],'fontweight','bold') 

