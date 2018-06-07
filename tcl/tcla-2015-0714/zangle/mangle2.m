min=0;
max=180;
lin=37
x=linspace(min,max,lin);
yy=hist(y,x);
yy=yy/length(y);
bar(x,yy);
