%% File name: mouseButtonDownCallback.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Event handling subroutine which is called when mouse button
%               pressed down and not released. This registers only press
%               down event.
%  Date: Oct 30, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mouseButtonDownCallback(src,evt,arg1,arg2)
    Cursor = get (gca, 'CurrentPoint');
    %disp('Clicked location ::');
    %disp(C);

    xCord_clicked = Cursor(1,1); 
    yCord_clicked = Cursor(1,2);
    
    %% Find closest node
    
    % On large map scaled down to fit on axes plot, minDist value might
    % need to update to large value. This variable might need tuning.
    % Whenever node needs to be selected on click user may not be able to 
    % click at exact coordinates. Hence some range is decided, here as 5.
    minDist = 5; 
    [~, numberOfNodes] = size(evt.Source.NodeLabel);
    
    global selectedNode;% = {};
    for i = 1:numberOfNodes
        xCordNode = evt.Source.XData(i);
        yCordNode = evt.Source.YData(i);
        
        dist = Euclidean(xCord_clicked, yCord_clicked, xCordNode, yCordNode);
        
        if(dist < minDist)
            selectedNode = evt.Source.NodeLabel(i);
            minDist = dist;
        end
    end
    disp('single click');
    %disp(selectedNode);
    %%
    %src.Color = 'green';
    %src.LineStyle = arg1;
    %src.Marker = arg2;
    
    %disp('clicked');
    %disp(get(gca,'CurrentPoint'));
end
