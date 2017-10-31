%% File name: UpdateGraph.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Function creates arrays required to create a directional
%               graph. Also highlights the excluded nodes and registers
%               mouse event handles.
%  Date: Oct 30, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function UpdateGraph()
    %% UpdateGraph main function
    global excludedNodes;
    global sourceNodes;
    global terminatingNodes;
    global edgeWeight;
    global graphPlot;
    global p;
    [sourceNodes, terminatingNodes, edgeWeight] = CreateGraphEntities();
    CreateDirectionalGraph();
    
     %% Blackout excluded nodes
    for excldNo=1:numel(excludedNodes)
        highlight(graphPlot,excludedNodes(excldNo), 'NodeColor', 'black','Marker','*','MarkerSize',10);

        % To get all connections from/to excluded nodes
        excludeEndNode = p.Edges.EndNodes(strcmp(p.Edges.EndNodes(:,1),excludedNodes(excldNo)),2);
        excludeStartNode = p.Edges.EndNodes(strcmp(p.Edges.EndNodes(:,2),excludedNodes(excldNo)),1);

        highlight(graphPlot, excludedNodes(excldNo),excludeEndNode, 'EdgeColor','black', 'LineWidth', 1, 'LineStyle',':');
    end

    %% Graph handles and object handles
    set (graphPlot, 'ButtonDownFcn', @mouseButtonDownCallback);
    set (gcf, 'WindowButtonMotionFcn', @mouseMotionCallback);
    set (gcf, 'WindowButtonUpFcn', {@mouseButtonUpCallback});
end
