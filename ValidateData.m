%% File name: TracePath.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Validates origin and destination nodes.
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function defination
function [valid]=ValidateData
    global networkData;
    global startNode;
    global destNode;
    valid = true(1);
    %% Check validity of nodes
    if(isempty(find(strcmp([networkData{:}],startNode))))
        disp('Start node given is not valid');
        valid = false(1);
        return;
    elseif(isempty(find(strcmp([networkData{:}],destNode))))
        disp('Destination node given is not valid');
        valid = false(1);
        return;
    end

end