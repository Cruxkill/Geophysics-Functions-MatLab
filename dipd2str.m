function strout=dipd2str(V)
%Turn Dip direction data into alphabetic direction
%   dipd2str(V) takes the data on V (vector or scalar) and turns the values
%   given into 'N', 'S', 'E' or 'W' depending on dip direction.
    strout=V;
    for i=1:length(V)
        if V(i)<90
            strout(i)='N';
        elseif V(i)==90
            strout(i)='E';
        elseif V(i)<270
            strout(i)='S';
        elseif V(i)==270
            strout(i)='W';
        elseif V(i)<=360
            strout(i)='N';
        end
    end
end