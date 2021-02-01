clc;clear all;
format short

L1 = 13.5; L2=15.5; L3=13.5;

M1=10;
M2=14.8;
M3=14;
d1=L1;
a3=L2;
a4=L3;
PHIH=pi;

x=5;y=3;z=5;
s2=sqrt((x^2+y^2)/(a3^2));
c2=1-sqrt((1-s2^2));

q2o=atan2(s2,c2);
q1o=atan2(y,x);
q3o=(PHIH-q1o-q2o);

x=8;y=12;
s2=sqrt((x^2+y^2)/(a3^2));
c2=1-sqrt((1-s2^2));
q2f=atan2(s2,c2);
q1f=atan2(y,x);
q3f=(PHIH-q1f-q2f);

T01=[cos(q1o) -sin(q1o) 0 0;
sin(q1o) cos(q1o) 0 0;
0 0 1 d1;
0 0 0 1];

T12=[sin(q2o) cos(q2o) 0 0;
0 0 1 0;
cos(q2o) -sin(q2o) 0 0;
0 0 0 1];

T23=[cos(q3o) -sin(q3o) 0 a3;
sin(q3o) cos(q3o) 0 0;
0 0 1 0;
0 0 0 1];

T34= [1 0 0 a4;
0 1 0 0; 
0 0 1 0;
0 0 0 1];

T02=T01*T12;
T03=T01*T12*T23;
T04=T01*T12*T23*T34;

axis([0 45 0 45 0 45]);

Ax1=[T01(1,4),T02(1,4)];
Ay1=[T01(2,4),T02(2,4)];
Az1=[0,T02(3,4)];
Ax2=[T02(1,4),T03(1,4)];
Ay2=[T02(2,4),T03(2,4)];
Az2=[T02(3,4),T03(3,4)];
Ax3=[T03(1,4),T04(1,4)];
Ay3=[T03(2,4),T04(2,4)];
Az3=[T03(3,4),T04(3,4)];
Ax4=[-.1,.1];
Ay4=[-.1,.1];
Az4=[-.1,.1];

p1=line(Ax1,Ay1,Az1,'LineWidth',[3],'Color','Y');
p2=line(Ax2,Ay2,Az2,'LineWidth',[3],'Color','k');
p3=line(Ax3,Ay3,Az3,'LineWidth',[3],'Color','R');
p4=line(Ax4,Ay4,Az4,'LineWidth',[12],'Color','B');

drawnow
pause()

n=1;
tf=1
g=9.81

for t=0:0.01:tf

a1o=q1o;
a11=0;
a12=(3/tf^2)*(q1f-q1o);
a13=(-2/tf^3)*(q1f-q1o);

a2o=q2o;
a21=0;
a22=(3/tf^2)*(q2f-q2o);
a23=(-2/tf^3)*(q2f-q2o);

a3o=q3o;
a31=0;
a32=(3/tf^2)*(q3f-q3o);
a33=(-2/tf^3)*(q3f-q3o);

q1=a1o+a11*t+a12*t^2+a13*t^3;
q2=a2o+a21*t+a22*t^2+a23*t^3;
q3=a3o+a31*t+a32*t^2+a33*t^3;

dq1=a11+2*a12*t+3*a13*t^2;
dq2=a21+2*a22*t+3*a23*t^2;
dq3=a31+2*a32*t+3*a33*t^2;

ddq1=2*a12+6*a13*t;
ddq2=2*a22+6*a23*t;
ddq3=2*a32+6*a33*t;

c1=cos(q1);
s1=sin(q1);

x=c1*s2*a3;
y=s1*s2*a3;
z=c2*a3+d1;

T01=[cos(q1) -sin(q1) 0 0;
sin(q1) cos(q1) 0 0;
0 0 1 d1;
0 0 0 1];

T12=[sin(q2) cos(q2) 0 0;
0 0 1 0;
cos(q2) -sin(q2) 0 0;
0 0 0 1];

T23=[cos(q3) -sin(q3) 0 a3;
sin(q3) cos(q3) 0 0;
0 0 1 0;
0 0 0 1];

T34= [1 0 0 a4;
0 1 0 0; 
0 0 1 0;
0 0 0 1];

T02=T01*T12;
T03=T01*T12*T23;
T04=T01*T12*T23*T34;

M=[0.158 0 0;
    0 2.830 2.835*c2;
    0 0.945*c2 0]

V=[0;
    -1.89*s2*dq2*dq1-0.945*s2*dq2^2-0.8447*g*c1*dq1-2.401*g*cos(q1+q2)*(dq1+dq2);
    -0.945*s2*dq2*dq1-8.447*g*c1*dq1-2.401*g*cos(q1+q2)*(dq1+dq2)+0.945*(dq1^2)*s2+0.945*dq1*dq2*s2];

G=[0;
    8.447*g*c1+2.401*g*cos(q1+q2);
    2.401*g*cos(q1+q2)]

T=M*[ddq1;ddq2;ddq3]+V+G;

axis([0 45 0 45 0 45]);

Ax1=[T01(1,4),T02(1,4)];
Ay1=[T01(2,4),T02(2,4)];
Az1=[0,T02(3,4)];
Ax2=[T02(1,4),T03(1,4)];
Ay2=[T02(2,4),T03(2,4)];
Az2=[T02(3,4),T03(3,4)];
Ax3=[T03(1,4),T04(1,4)];
Ay3=[T03(2,4),T04(2,4)];
Az3=[T03(3,4),T04(3,4)];
Ax4=[-.1,.1];
Ay4=[-.1,.1];
Az4=[-.1,.1];

set(p1,'X',Ax1,'Y',Ay1,'Z',Az1);
set(p2,'X',Ax2,'Y',Ay2,'Z',Az2);
set(p3,'X',Ax3,'Y',Ay3,'Z',Az3);
set(p4,'X',Ax4,'Y',Ay4,'Z',Az4);

o1(n,1)=Ax3(2);
o1(n,2)=Ay3(2);
o1(n,3)=Az3(2);
o2(n,1)=t;
o3(n,1)=T(1,1);
o3(n,2)=T(2,1);
o3(n,3)=T(3,1);
drawnow
pause(0.0001)
n=n+1;
end
hold on;
plot3(o1(:,1),o1(:,2),o1(:,3),'r');
figure
plot(o2(:,1),o3(:,1),'r');
hold on;
plot(o2(:,1),o3(:,2),'b ');
hold on;
plot(o2(:,1),o3(:,3),'k');

