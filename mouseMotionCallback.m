%% File name: mouseMotionCallback.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Event handling subroutine which is called when mouse is
%               moved over figure object.
%  Date: Oct 30, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mouseMotionCallback(src,evt,arg1,arg2)
    global graphPlot;
    global selectedNode;
    global networkData;
    Cursor = get (gca, 'CurrentPoint');
    
    xCordNew = Cursor(1,1); 
    yCordNew = Cursor(1,2);
    
    if((0<=xCordNew)&&(0<=yCordNew))
        title(gca, ['(X-cord,Y-cord) = (', num2str(Cursor(1,1)), ', ',num2str(Cursor(1,2)), ')']);
    end
    %disp(selectedNode);
    
    %% Find the selected node and update its new location
    index = find(strcmp(graphPlot.NodeLabel(:),selectedNode));
    
    graphPlot.XData(index) = xCordNew;
    graphPlot.YData(index) = yCordNew;

     % Update networkData with new coordinates
     if(~(isempty(selectedNode)))
        indexNodeInNetData = find(strcmp([networkData{:}],selectedNode));
        networkData{indexNodeInNetData,4} = num2str(xCordNew);
        networkData{indexNodeInNetData,5} = num2str(yCordNew);

        UpdateGraph();
     end
   %src.Color = 'green';
   %src.LineStyle = arg1;
   %src.Marker = arg2;
   
   %disp('clicked');
   %disp(get(gca,'CurrentPoint'));
end