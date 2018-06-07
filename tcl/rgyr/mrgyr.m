load rgyr.dat
y=rgyr
min=0;
max=6;
lin=max*10
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
fid=fopen('rgyr-distri.dat','wt+');
fprintf(fid,'%g %g\n',[x;yy]);
fclose(fid);
clear all
type rgyr-distri.dat