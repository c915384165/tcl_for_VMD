load 4p-angle-test.dat
y=X4p_angle_test
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