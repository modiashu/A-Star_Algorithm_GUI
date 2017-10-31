%% File name: NodeExclusionInclusion.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Depending upon the type of action directed by function 
%               mouseButtonDownCallback(), this subroutine is called.
%
% Functions: 1. NodeExclusionInclusion: Main function
%            2. Exclude: Create a list of nodes need to be excluded
%            3. Include: Removes node from a list of nodes need to be excluded
%            4. RemoveNodes: Removed node from network data
%            5. AddNode: Adds node to networkData
%
%  Date: Oct 30, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ output_args ] = NodeExclusionInclusion( node )
%% Logic to decide whether to add or exclude node
    global excludedNodes;
    disp(node);
    
    % Check if node needs to be excluded or included.
    %
    % "copyNetworkData" is the dataset which holds original data loaded
    % from connections and locations file.
    %
    % Whereas "networkData" holds the data on which A* algorithm is used to
    % find path from start node to end node.
    
    indexCurrentNode = find(strcmp([excludedNodes],node));
    
    if((isempty(indexCurrentNode)))
        disp('Not in excludedNodes list, so exclude node from netowrk data');
        Exclude(node);
    else
        disp('Found in excludedNodes list, so include node');
        Include(node, indexCurrentNode);
    end
   
end

function Exclude(node)
    %% Node needs to be excluded from networkData
    global excludedNodes;
    disp('Exclude city');
    
    % Update node to exclusion list
    if(isempty(excludedNodes))
        excludedNodes = node;
    else
        excludedNodes = [excludedNodes node];
    end
    
    %% Exclude node connections from network data
    RemoveNodes();
    
    %% Need to update graph contents and refresh graph plot
    UpdateGraph();

end

function Include(node, ind)
    %% Node needs to be included in networkData
    global excludedNodes;
    disp('Include city');
    excludedNodes = excludedNodes(find(~(strcmp(excludedNodes,node))));
    
    AddNode(node);
    %% Need to update graph contents and refresh graph plot
    UpdateGraph();
end

function RemoveNodes()
    %% Removed node from networkData
    global networkData;
    global excludedNodes;
    for excldNo=1:size(excludedNodes,2)
        for row = 1:size(networkData,1)
            cellNo = 1;
            while cellNo <= str2double(networkData{row,2})
                if strcmp(excludedNodes(1,excldNo), networkData{row,3}{1,1}{1,cellNo})
                    networkData{row,3}{1,1}(:,cellNo)=[];
                    networkData{row,2}=num2str(str2double(networkData{row,2})-1);
                    cellNo=cellNo-1;
                end
                cellNo=cellNo+1;
            end
        end
    end
end

function AddNode(node)
    %% Uses copyNetworkData to add nodes back to networkData
    global networkData;
    global copyNetworkData;
    for row = 1:size(copyNetworkData,1)
        cellNo = 1;
        while cellNo <= str2double(copyNetworkData{row,2})
            if strcmp(node, copyNetworkData{row,3}{1,1}{1,cellNo})
                networkData{row,3}{1,1}{end+1}= node;
                networkData{row,2}=num2str(str2num(networkData{row,2})+1);
            end
            cellNo=cellNo+1;
        end
    end
end