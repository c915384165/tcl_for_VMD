load zangles-up.dat
load zangles-down.dat
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
fid=fopen('zangle-distri.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type zangle-distri.dat