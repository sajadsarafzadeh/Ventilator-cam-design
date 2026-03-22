%in the name of god 
%Sajjad Sarafzadeh 
%St code: 810698267

clear
clc
close all
%biometric values
weight=76;   %kg
height=1.78;   %meters
bmi=weight/height^2;
volume=0.007*weight;    %liters
%normal human breathes 13 times in every minutes so we have so the angular
%velocity of cam is 13 rpm:
T=60/13;   %time period
w=13*(2*pi/60);
%the section area of piston is 80^2 mm^2 so we have:
h=volume/0.8^2*100;    %mm
%time ranges
t1=0.2*T;
t2=0.2*T;
t3=0.3*T;
t4=0.3*T;
%angles
B1=w*t1;
B2=w*(t1+t2);
B3=w*(t1+t2+t3);
B4=w*(t1+t2+t3+t4);
syms th
%cyclouid full rise and return
th1=0:0.01:B1;
S1=h.*(th1./B1-1/(2*pi).*sin(2*pi.*th1./B1));
S2=h*ones(1,126);
th2=linspace(B2,B3,189);
S3=h.*(1-(th2-B2)/(B3-B2)+1/(2*pi).*sin(2*pi.*(th2-B2)./(B3-B2)));
S4=zeros(1,189);
% S=zeros(1,630);
% S(1:126)=S1;
% S(127:252)=S2;
% S(253:441)=S3;
% S(442:630)=S4;
S=[S1,S2,S3,S4];
th=linspace(0,2*pi,630);
figure;
plot(th,S)
xlabel('angle (rad)')
ylabel('S (meters)')
title('dicplacement')
grid on
%velocity 
V1=h./B1.*(1-cos(2*pi.*th1./B1));
V2=zeros(1,126);
V3=-h/(B3-B2)*(1-cos(2*pi*(th2-B2)/(B3-B2)));
V4=zeros(1,189);
% V=zeros(1,630);
% V(1:126)=V1;
% V(127:252)=V2;
% V(253:441)=V3;
% V(442:630)=V4;
V=[V1,V2,V3,V4];
% V=diff(S);
figure;
plot(th,V)
xlabel('angle (rad)')
ylabel('V (meters/second)')
title('velocity')
grid on
%acceleration
A1=2*pi*h/B1^2*sin(2*pi.*th1./B1);
A2=zeros(1,126);
A3=-2*pi*h/(B3-B2)^2*sin(2*pi.*(th2-B2)./(B3-B2));
A4=zeros(1,189);
% A=zeros(1,630);
% A(1:126)=A1;
% A(127:252)=A2;
% A(253:441)=A3;
% A(442:630)=A4;
A=[A1,A2,A3,A4];
% A=diff(V);


figure;
plot(th,A)
xlabel('angle (rad)')
ylabel('A (milimeters/second^2)')
title('acceleration')
grid on

R=300;
u=(R+S).*sin(th)+V.*cos(th);
z=(R+S).*cos(th)-V.*sin(th);
% u=(R+S).*sin(th);
% z=(R+S).*cos(th);
figure;
plot(u,z)
% xlim([-500 700])
% ylim([-500 500])
title('cam profile')
grid on
hold on
plot(0,0, 'b*')
% hold on
% uu=(R).*sin(th);
% zz=(R).*cos(th);
% plot(uu,zz)
