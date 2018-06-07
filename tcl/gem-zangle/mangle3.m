load zangles-7F1C2O-8F1S3O-up-1.dat
load zangles-7F1C2O-8F1S3O-up-2.dat
y1=zangles_7F1C2O_8F1S3O_up_1;
y2=zangles_7F1C2O_8F1S3O_up_2;
y=(y1;y2);
min=0;
max=180;
lin=37;
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
fid=fopen('zangle-distri.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type zangle-distri.dat