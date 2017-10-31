%% File name: TracePath.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Displayes found path by backtracking.
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function defination
function TracePath()
    global parentLinkMap;
    global startNode;
    global destNode;
    global graphPlot;
    global path;
    
    path = {destNode};
    nodeItr = destNode;
    while(~(isempty( parentLinkMap(char(nodeItr)))))
        path = [parentLinkMap(char(nodeItr)) '->' path];
        
        % Highlight path found
        highlight(graphPlot, parentLinkMap(char(nodeItr)),nodeItr, 'EdgeColor','g', 'LineWidth', 4);
        nodeItr = parentLinkMap(char(nodeItr));
    end
    
    highlight(graphPlot,startNode, 'NodeColor','green');
    highlight(graphPlot,destNode, 'NodeColor','red');
        
    disp('Path is as follows:');
    %fprintf('Start ->');
    for str = path
        fprintf('%s ',str{1});
    end
    %disp('End');
    fprintf('\n ');
end