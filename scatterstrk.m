function scatterstrk(xdata,ydata,wide,direction,color)
%Adds strike information to points in a scatter plot
hold on;axis equal;%ratio=(max(ydata)-min(ydata))/(max(xdata)-min(xdata));
x1=zeros(numel(direction),1);x2=zeros(numel(direction),1);y1=zeros(numel(direction),1);y2=zeros(numel(direction),1);
for i=1:numel(direction)
    y1(i)=(ydata(i)+wide*cosd(direction(i)));
    y2(i)=(ydata(i)+wide*cosd(direction(i)+180));
    x1(i)=(xdata(i)+wide*sind(direction(i)));
    x2(i)=(xdata(i)+wide*sind(direction(i)+180));
    plot([x1(i),x2(i)],[y1(i),y2(i)],color)
end
