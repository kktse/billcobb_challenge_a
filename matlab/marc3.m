M=importdata('marc3.txt');
descr=char(M.textdata(1));
inx=findstr(descr,'SR=');
SR = str2double(descr(inx+3:inx+6));
inx=findstr(descr,'WB=');
WB = str2double(descr(inx+3:inx+6))/1000;
inx=findstr(descr,'WF=');
WF = str2double(descr(inx+3:inx+6))
inx=findstr(descr,'WR=');
WR = str2double(descr(inx+3:inx+5))
A  =WB*WR/(WF+WR)
B  =WB-A
% t       = M.data(:,1);
ayg     = M.data(:,2);
run     = M.data(:,3);
beta    = M.data(:,4);
speed   = M.data(:,5);
steer   = M.data(:,6);
inx=find(diff(run) > .5)-1;
inx=[1;inx];
steer       =reshape(steer,[],length(inx));
ayg         =reshape(ayg  ,[],length(inx));
beta        =reshape(beta, [],length(inx));
speed       =reshape(speed,[],length(inx));
steer   =steer(end,:);
ayg     =ayg(end,:);
beta    =beta(end,:);
speed   = speed(end,:);
subplot(1,2,1)
plot( speed, beta,'ro-','LineWidth',2);
utan=interp1(beta,speed,0.);
xlabel('Speed (kph)')
ylabel('Sideslip Angle (deg)')
grid on
vref( utan)
ut= utan/3.6;
dr = 180/pi * 9.806 * B ./( ut.^2)
text(1.01*utan ,.1 ,['Tangent speed = ' sprintf('%5.2f', utan ) ' kph'])
href(0)
subplot(1,2,2)
grid on
xlabel('Lateral Acceleration (g)')
ylabel('Cornering Compliances & Understeer (deg/g)')
ssg=gradient( beta)./gradient( ayg );
DR = -ssg ;
swg = gradient( steer) ./gradient( ayg ); % swg=steering wheel gradient
K = swg./SR ; % rsg = rear steer
hold on
DF = DR + K;
plot( ayg ,DF,'ro-','LineWidth',2)
plot( ayg ,DR,'bo-','LineWidth',2)
plot( ayg ,K ,'go-','LineWidth',2)
vref(0)
href(0)
ylim([-2 18])
legend('DF','DR','K','Location','Best')
title(descr)
