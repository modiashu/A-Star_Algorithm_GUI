%% File name: mouseButtonUpCallback.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Event handling subroutine which is called when mouse button
%               is released. This registers only button release event.
%               If node is clicked using right button then it is excluded
%               from the a* algorithm calculation. If already excluded node
%               is clicked then it is added back in network data for path
%               finding consideration.
%  Date: Oct 30, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mouseButtonUpCallback(src,evt,arg1,arg2)
    global graphPlot;
    global selectedNode;
    global networkData;
    Cursor = get (gca, 'CurrentPoint');
    %disp('Released location ::');
    %disp(C);
    
    xCordNew = Cursor(1,1); 
    yCordNew = Cursor(1,2);
    
    % disp(selectedNode);
    
    %% Find the selected node and update its new location
    if(~isempty(selectedNode))
        index = find(strcmp(graphPlot.NodeLabel(:),selectedNode));

        graphPlot.XData(index) = xCordNew;
        graphPlot.YData(index) = yCordNew;

        % Update networkData with new coordinates
        indexNodeInNetData = find(strcmp([networkData{:}],selectedNode));
        networkData{indexNodeInNetData,4} = num2str(xCordNew);
        networkData{indexNodeInNetData,5} = num2str(yCordNew);
            
        % If double clicked then node is being excluded
        switch get(src,'SelectionType')
            case 'normal'
                % Node movement i.e. change node's new location
%                 graphPlot.XData(index) = xCordNew;
%                 graphPlot.YData(index) = yCordNew;
                UpdateGraph();
            case 'alt'
                % Double clicked, exclude that node from the path finding
                % algorithm. If alrady excluded then add it.
                disp('double click');
                set(src,'SelectionType','normal');
                NodeExclusionInclusion(selectedNode);
        end

        selectedNode = [];
    end
end