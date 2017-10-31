%% File name: Euclidean.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Calculates euclidean distance; used as a heuristic.
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function defination
function [euclideanDist] = Euclidean(x1, y1, x2, y2)

    euclideanDist = sqrt((x1-x2)^2+(y1-y2)^2);
    
end