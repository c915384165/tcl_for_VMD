load zangles-up-10-00-200.dat
load zangles-down-10-00-200.dat
y2=180-zangles_down_10_00_200
y1=zangles_up_10_00_200
y=[y1;y2]
min=0;
max=180;
lin=37
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
fid=fopen('zangle-distri-10-00-200.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type zangle-distri-10-00-200.dat

load zangles-up-10-10-200.dat
load zangles-down-10-10-200.dat
y2=180-zangles_down_10_10_200
y1=zangles_up_10_10_200
y=[y1;y2]
min=0;
max=180;
lin=37
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
fid=fopen('zangle-distri-10-10-200.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type zangle-distri-10-10-200.dat

load zangles-up-10-20-200.dat
load zangles-down-10-20-200.dat
y2=180-zangles_down_10_20_200
y1=zangles_up_10_20_200
y=[y1;y2]
min=0;
max=180;
lin=37
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
fid=fopen('zangle-distri-10-20-200.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type zangle-distri-10-20-200.dat

load zangles-up-10-30-200.dat
load zangles-down-10-30-200.dat
y2=180-zangles_down_10_30_200
y1=zangles_up_10_30_200
y=[y1;y2]
min=0;
max=180;
lin=37
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
fid=fopen('zangle-distri-10-30-200.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type zangle-distri-10-30-200.dat

load zangles-up-10-40-200.dat
load zangles-down-10-40-200.dat
y2=180-zangles_down_10_40_200
y1=zangles_up_10_40_200
y=[y1;y2]
min=0;
max=180;
lin=37
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
fid=fopen('zangle-distri-10-40-200.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type zangle-distri-10-40-200.dat

load zangles-up-10-50-200.dat
load zangles-down-10-50-200.dat
y2=180-zangles_down_10_50_200
y1=zangles_up_10_50_200
y=[y1;y2]
min=0;
max=180;
lin=37
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
fid=fopen('zangle-distri-10-50-200.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type zangle-distri-10-50-200.dat