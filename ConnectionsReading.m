%% File name: ConnectionsReading.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: This file is used to read location details.
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Connections file Reading
function [valid]=ConnectionsReading(fileName)
    global networkData;
    valid = true;
    fileID = fopen(fileName,'r');
    if(-1 == fileID)
        disp(sprintf('Not Found: %s', fileName));
        valid = false;
        return;
    end
    lineCount = 0;
    while ~feof(fileID)
        %% Read line
        line = fgets(fileID);
        elements = strsplit(line); %Read information from line
        beginNode = elements{1,1}; %Read first element i.e. node name
        lineCount = lineCount+1; %This is required to index Graph cell
        
        %% Check for end of data
        if(strcmp(beginNode, 'END'))
            break;
        end
        
        %% Update Graph cell 
        %Insert node name in graph
        networkData(lineCount,1) = {beginNode};  
        
        % Read connected node names
        numberConnections = elements{1,2};
        
        %Insert number of connections
        networkData(lineCount,2) = {numberConnections};  
        
        for i = 3:3+str2double(numberConnections)-1
            %disp(elements{1,i});
            connections(1,i-2) = {elements(1,i)};
            %Graph{lineCount,i} = elements{1,i};
        end

        %Insert list of connections
        networkData{lineCount,3} = {connections};
        connections(:)=[];
        
        %% Temporary code
    %     NodeInfo = {{beginNode, connections}};
    %     Graph(lineCount,:) = {NodeInfo};
    %     
    %     %Empty connections list before inserting new list 
    %     connections(:)=[];
    %     NodeInfo(:) = [];
    end
end