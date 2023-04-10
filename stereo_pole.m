function stereo_pole(Attitude,Dip,DipD)
%Plots the stereographic projection of a plane using a Wulff stereonet and
%plots it as a pole.
%   stereo_pole(Attitude,Dip,DipD) plots a plane over a Wulff stereonet
%   and evaluates the direction of the dip angle in order to choose the
%   right major circle. Attitude and Dip are both on degrees while DipD is 
%   a logical parameter that can only be 'N' or 'S' and single quotes shall
%   be respected. Attitude, Dip and DipD can be vectors in order to 
%   evaluate different planes on a single figure, but these vectors have to
%   be the same lenght, in case the plane is at 0,180 or 360, DipD must be 
%   'E' or 'W'.

    North=cell(length(DipD),1);
    East=cell(length(DipD),1);
    legh=zeros(length(DipD),1);
    message2=cell(length(DipD),1);
%    legvar=cell(length(DipD),1);
    for i=1:length(DipD)
        if DipD(i)=='N'
           North{i}=true;
        elseif DipD(i)=='S'
           North{i}=false;
        elseif DipD(i)=='E'
           East{i}=true;
        elseif DipD(i)=='W'
           East{i}=false;
        end
    end
    figure
    if length(Attitude)==1
        ftitle='Pole to a plane over the Wulff projection';
    else
        ftitle='Poles to planes over the Wulff projection';
    end
    set(gcf,'units','normalized','position',[0 0 1 1],'name',ftitle,'NumberTitle','off')
    MSZ=2;                                           
    xh = [-sind(Attitude) sind(Attitude)];yh = [-cosd(Attitude) cosd(Attitude)];
    axis([-1 1 -1 1]);axis('square');
    rectangle('Position',[-1 -1 2 2],'Curvature',[1 1],'FaceColor','w')            
    axis off;hold on;
    if Dip==90
        plot(xh,yh,'-k');
    else
        psi = 90;
        for i=1:length(Dip)
            rdip = Dip(i)+(90-(2*Dip(i)));                          
            radip = atand(tand(rdip)*sind(psi));
            rproj = tand((180/2 - radip)/2);
            %rproj0 = tand((180/2 - atand(tand(rdip).*sind(0)))/2);
            x1 = rproj .* sind(psi+Attitude(i));
            x2 = rproj .* (-sind(psi-Attitude(i)));
            y1 = rproj .* cosd(psi+Attitude(i));
            y2 = rproj .* cosd(psi-Attitude(i));
            if Attitude(i)==0||Attitude(i)==360
                if East{i}==true
                    legh(i)=plot(x2,y2,'ok','MarkerSize',MSZ,'MarkerFaceColor','k');
                elseif East{i}==false
                    legh(i)=plot(x1,y1,'ok','MarkerSize',MSZ,'MarkerFaceColor','k');
                end
            elseif Attitude(i)==180
                if East{i}==true
                    legh(i)=plot(x1,y1,'ok','MarkerSize',MSZ,'MarkerFaceColor','k');
                elseif East{i}==false
                    legh(i)=plot(x2,y2,'ok','MarkerSize',MSZ,'MarkerFaceColor','k');
                end
            else
                if rproj * cosd(180/2+Attitude(i))>rproj * cosd(180/2-Attitude(i));
                    %p1 is N p2 is S
                    if North{i}==true
                        legh(i)=plot(x2,y2,'ok','MarkerSize',MSZ,'MarkerFaceColor','k');
                    elseif North{i}==false
                        legh(i)=plot(x1,y1,'ok','MarkerSize',MSZ,'MarkerFaceColor','k');
                    end
                elseif rproj * cosd(180/2+Attitude(i))<rproj * cosd(180/2-Attitude(i))
                        %p2 is N p1 is S
                    if North{i}==true
                        legh(i)=plot(x1,y1,'ok','MarkerSize',MSZ,'MarkerFaceColor','k');
                    elseif North{i}==false
                        legh(i)=plot(x2,y2,'ok','MarkerSize',MSZ,'MarkerFaceColor','k');
                    end
                end
            end            
            message=sprintf('(%d) Strike: %.2fº Dip: %.2fº%c\n',i,Attitude(i),Dip(i),DipD(i));
            message2{i}=horzcat(message);
        end
%       legvar
        %leg=legend(legh,message2);
        %set(leg,'location','northeastoutside')
    end
    coordinates={'N';'E';'S';'W'};verthor={'VerticalAlignment';'HorizontalAlignment';'VerticalAlignment';'HorizontalAlignment'};
    al={'Bottom';'Left';'Top';'Right'};xtext= [0 1 0 -1];ytext= [1 0 -1 0];
    for i=1:4
        text(xtext(i),ytext(i),coordinates(i),verthor(i),al(i))
    end
    text(-2.4,0,message2(1:end/2),'HorizontalAlignment','Left','BackgroundColor','w','FontSize',8)
    text(-1.7,0,message2(end/2+1:end),'HorizontalAlignment','Left','BackgroundColor','w','FontSize',8)
end