% load dates
load test-1.dat
load test-2.dat
load test-3.dat
load test-4.dat
load test-5.dat
load test-6.dat
load test-7.dat
load test-8.dat
load test-9.dat
% set dates
date1=test_1;
date2=test_2;
date3=test_3;
date4=test_4;
date5=test_5;
date6=test_6;
date7=test_7;
date8=test_8;
date9=test_9;
% set x
x=date1(:,1)*2;
% set y smooth 
% 1
y12=smooth(date1(:,2));
figure(1)
plot(x,y12)
% 2
y22=smooth(date2(:,2));
figure(2)
plot(x,y22)
% 3
y32=smooth(date3(:,2));
figure(3)
plot(x,y32)
% 4
y42=smooth(date4(:,2));
figure(4)
plot(x,y42)
% 5
y52=smooth(date5(:,2));
figure(5)
plot(x,y52)
% 6
y62=smooth(date6(:,2));
figure(6)
plot(x,y62)
% 7
y72=smooth(date7(:,2));
figure(7)
plot(x,y72)
% 8
y82=smooth(date8(:,2));
figure(8)
plot(x,y82)
% 9
y92=smooth(date9(:,2));
figure(9)
plot(x,y92)

% ysum12=y12+y22;
% y=(date1(:,2)+date2(:,2)+date3(:,2)+date4(:,2)+date5(:,2))/5
ymix=[date1(:,2) date2(:,2) date3(:,2) date4(:,2) date5(:,2) date6(:,2) date7(:,2) date8(:,2) date9(:,2)]
% ymix=[date1(:,2) date2(:,2)  date4(:,2) date5(:,2)  date7(:,2) date8(:,2) ]

% 所有的 y列平滑后 汇总
smooth_ymix_each=[y12 y22 y32 y42 y52 y62 y72 y82 y92]
% 平均值
yyy=smooth(mean(smooth_ymix_each,2))
ymix_av=mean(ymix,2)
% zmix 
zmix=[date1(:,3) date2(:,3) date3(:,3) date4(:,3) date5(:,3) date6(:,3) date7(:,3) date8(:,3) date9(:,3)]
% plot(x,smooth(y));
% plot(x,mean(y,2));
figure(10)
% plot(x,yyy);
plot(x,ymix_av);
figure(11)
plot(x,smooth(ymix_av));


% ymix
% mean(z)
% clear all
yprint=[x smooth(ymix_av)]
fid=fopen('msd.dat','wt+');
% fprintf(fid,'%g %g\n',yprint);
fprintf(fid,'%g %g\n',yprint');
fclose(fid);

zzz=mean(zmix(:))
std_zzz=std(zmix(:))