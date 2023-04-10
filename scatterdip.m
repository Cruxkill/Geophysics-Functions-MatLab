function scatterdip(xdata,ydata,wide,direction,color)
%Adds dip information to points in a scatter plot
hold on;axis equal;%ratio=(max(ydata)-min(ydata))/(max(xdata)-min(xdata));
x1=zeros(numel(direction),1);x2=zeros(numel(direction),1);y1=zeros(numel(direction),1);y2=zeros(numel(direction),1);
for i=1:numel(direction)
    y1(i)=ydata(i)+(wide/2)*cosd(direction(i)+90);
    y2(i)=(ydata(i));
    x1(i)=xdata(i)+(wide/2)*sind(direction(i)+90);
    x2(i)=(xdata(i));
    plot([x1(i),x2(i)],[y1(i),y2(i)],color)
end