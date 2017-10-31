%% File name: CreateGraphEntities.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Function creates data structure to store node details read 
%               from connections and locations file.
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function defination
function[sourceNodes, terminatingNodes, edgeWeight] = CreateGraphEntities()

    global networkData;
    
    % Create two list representing all connections
    [nodeCount,~] = size(networkData);

    % sourceNodes is the list of all node s.t. edge starts from
    sourceNodes = {zeros(nodeCount,1)};
    % terminatingNodes is the list of all node s.t. edge ends to
    terminatingNodes = {zeros(nodeCount,1)};

    % edgeWeight contains distance between nodes
    edgeWeight = zeros(nodeCount,1);

    % totalConnections is the edge count
    totalConnections = 0;

    % Extract all pair of connections; at each position of array sourceNodes
    % corresponding end node exists in terminatingNodes
    for i=1:nodeCount
        %totalConnections = totalConnections + 1;
        if(0 == str2double(networkData{i,2}))
            totalConnections = totalConnections + 1;
            sourceNodes(totalConnections,1) = networkData(i,1);
            %disp('Node without any outbound connections');
            terminatingNodes(totalConnections,1) = {networkData{i,1}};
            edgeWeight(totalConnections,1) = 0;
        else

            for j=1:str2double(networkData{i,2})
                 totalConnections = totalConnections + 1;
                sourceNodes(totalConnections,1) = networkData(i,1);
                terminatingNodes(totalConnections,1) = networkData{i,3}{1,1}{1,j};

                % Find indices and then coordinates
                indexOrig = find(strcmp([networkData{:}],networkData(i,1)));
                indexEnd = find(strcmp([networkData{:}],networkData{i,3}{1,1}{1,j}));

                x1 = str2double(networkData(indexOrig,4));
                y1 = str2double(networkData(indexOrig,5));
                x2 = str2double(networkData(indexEnd,4));
                y2 = str2double(networkData(indexEnd,5));

                % Create weight vector
                edgeWeight(totalConnections,1)=Euclidean(x1,y1,x2,y2);
            end
        end
    end
end