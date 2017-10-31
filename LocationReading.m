%% File name: LocationReading.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: This file is used to read connection details.
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Node location file reading
function [valid] = LocationReading(fileName)
    global networkData;    
    valid = true;
    fileID = fopen(fileName,'r');
    if(-1 == fileID)
        disp(sprintf('Not Found: %s', fileName));
        valid = false;
        return;
    end
    while ~feof(fileID)
        %% read line
        line = fgets(fileID);
        elements = strsplit(line); %Read information from line
        node = elements{1,1}; %Read first element i.e. node name

        %% check for end of data
        if(strcmp(node, 'END'))
            break;
        end

        %% Get x and y coordinates        
        % Find node in the graph to insert x, y coordinates
        index = find(strcmp([networkData{:}],node)); 
        
        % If node is absent in network data then add the node
        if(1 == isempty(index))
            [entries columns]=size(networkData);
            networkData(entries+1,1) = {node};
            zeroChar = '0';
            networkData(entries+1,2) = {zeroChar};
            networkData{entries+1,3} = {};
            networkData{entries+1,4} =  elements{1,2};
            networkData{entries+1,5} = elements{1,3};
            
        else
            networkData{index,4} =  elements{1,2};
            networkData{index,5} = elements{1,3};
        end
        %% Temporary code for debugging
        %xCor = elements{1,2};
        %yCor = elements{1,3};
        %disp(xCor);disp(yCor)
    end
end