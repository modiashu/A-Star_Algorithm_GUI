%% File name: AStar.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Implements two functions
%               1. AStar: Implements A* algorithm
%               2. Intialization: Implements initialization of data 
%                                 structures and variables used in A* 
%                                 algorithm
% Pseudo code can be found at:
% https://en.wikipedia.org/wiki/A*_search_algorithm
%
%  Date: Oct 30, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AStar function defination
function[valid] = AStar()
    global networkData;
    global startNode;
    global destNode;
    global openNodes;
    global parentLinkMap;
    global costTable;
    global closedNodes;
    global p;
    global heuristic;
    global graphPlot;
    global showSteps;
    valid = false;
    Intialization();
    
    while ~isempty(openNodes)
        % Get node s.t. f(n) value is lowest
        minF_n = inf;
        minId = 0;
        for i=1:numel(openNodes)
            % Get value of f(n) = g(n) + h(n);
            F_n = costTable.gValue(strcmp(costTable.nodeName,openNodes(i))) + ...
                costTable.hValue(strcmp(costTable.nodeName,openNodes(i)));
            if(F_n < minF_n)
                minF_n = F_n;
                minId = find(strcmp(costTable.nodeName,openNodes(i)));
            end
        end
        
        % For debugging purpose
        %[val,id] = min(costTable.gValue+costTable.hValue);
        
        currentNode = costTable.nodeName(minId);
        
        % Highlight start and destination node
        highlight(graphPlot,startNode, 'NodeColor','green');
        highlight(graphPlot,destNode, 'NodeColor','red');
            
        % Highlight node and edge; showSteps variable is being set from GUI
        % application interface
        if(showSteps)
            highlight(graphPlot,currentNode, 'NodeColor', 'm');
            if(~(isempty( parentLinkMap(char(currentNode)))))
                % highlight edge
                highlight(graphPlot, parentLinkMap(char(currentNode)),currentNode, 'EdgeColor','m', 'LineWidth', 2, 'LineStyle', '-.');
            end
            pause(1);
        end
        
        %disp('--'); %For debugging purpose
        %disp(currentNode); %For debugging purpose
        if(strcmp(currentNode, destNode))
            valid = true;
            fprintf('\n');
            disp('--Destination Found--');
            TracePath();
            return;
        end
        
        % Remove current node form open node list
        openNodes(find(strcmp(openNodes(:),currentNode))) = [];
        
        % Move current node to closed node list
        closedNodes = [closedNodes currentNode];
        
        % Find children of current node
        indexCurrentNode = find(strcmp([networkData{:}],currentNode));
        
        % If there is no children/connection then continue
        if(strcmp('0',networkData{indexCurrentNode,2}))
            continue;
        end
        currentNodeChildren = networkData{indexCurrentNode,3}{1,1};
        
        % Add children to open nodes
        for i=1:numel(currentNodeChildren)
            % Check if pesent in the closed list
            if(~isempty(find(strcmp(closedNodes(:),currentNodeChildren{i}))))
               continue;
            end
            
            % Check if already exist in the list; if not then add
            if(isempty(find(strcmp(openNodes(:),currentNodeChildren{i}))))
                openNodes = [openNodes currentNodeChildren{i}];
            end
            
            % Calculate h_n, g_n for children
            if 1 == heuristic
                tempG_n = costTable.gValue(strcmp(costTable.nodeName,currentNode)) + ...
                    p.Edges.Weight(findedge(p,currentNode,currentNodeChildren{i}));
            elseif 2 == heuristic
                    tempG_n = costTable.gValue(strcmp(costTable.nodeName,currentNode)) + 1;
            end
            
            % Check if this tempG_n is less than existing gValue; if yes then
            % update
            if( tempG_n >= costTable.gValue(strcmp(costTable.nodeName,currentNodeChildren{i})))
                continue;
            end

            % Update parent node map
            parentLinkMap(char(currentNodeChildren{i})) = currentNode;

            % Update gValue with new tempG_n
            costTable{find(strcmp(costTable.nodeName,currentNodeChildren{i})),'gValue'} = tempG_n;

            % Update heuristic value for this children
            indexCurChild = find(strcmp([networkData{:}],currentNodeChildren{i}));
            indexDest = find(strcmp([networkData{:}],destNode));

            if 1 == heuristic
                x1 = str2double(networkData(indexCurChild,4));
                y1 = str2double(networkData(indexCurChild,5));
                x2 = str2double(networkData(indexDest,4));
                y2 = str2double(networkData(indexDest,5));

                h_n=Euclidean(x1,y1,x2,y2);
            elseif 2 == heuristic
                h_n = 1;
            end
            
            costTable{find(strcmp(costTable.nodeName,currentNodeChildren{i})),'hValue'} = h_n;
            
        end
    end
end

%% Intialization function defination
function Intialization()
    global closedNodes;
    global openNodes;
    global parentLinkMap;
    global startNode;
    global networkData;
    global costTable;
    
    closedNodes = {};
    openNodes = {startNode};
    parentLinkMap = containers.Map;
    
    nodeName = networkData(:,1);
    [nodeCount,~]=size(nodeName);
    
    % Initialize cost values to max value
    gValue = Inf(nodeCount,1);
    hValue = Inf(nodeCount,1);
    % start node has no parent
    parentLinkMap(startNode) = '';
    
    ind = find(strcmp(nodeName(:,1),startNode));
    gValue(ind) = 0;
    hValue(ind) = 0;% distance value can be calulated here rather than 0.
    costTable = table(nodeName, gValue, hValue);
    %costTable(costTable.nodeName=='A1',1)
end