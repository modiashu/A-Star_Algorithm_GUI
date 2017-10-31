%% File name: CreateDirectionalGraph.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: This function creates a directional graph and plots it.
%  Date: Oct 30, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function CreateDirectionalGraph()    
%% Create directional graph and plot
    global networkData;
    global sourceNodes;
    global terminatingNodes;
    global edgeWeight;
    global p;
    p=digraph(sourceNodes,terminatingNodes,edgeWeight);
    % Node sequence in networkData and p.Nodes are different. So while plotting
    % (x,y) value from network data need to be carefully extracted
    A = networkData(:,1);
    B = p.Nodes;
    [Lia, Locb]=ismember(table2cell(B), A);

    global graphPlot;

    graphPlot = plot(p,'EdgeLabel',p.Edges.Weight,'XData',str2double(networkData(Locb,4)),'YData',str2double(networkData(Locb,5)));%,'EdgeColor',rand(82,3));
    %graphPlot = plot(p,'XData',str2double(networkData(Locb,4)),'YData',str2double(networkData(Locb,5)));%,'EdgeColor',rand(82,3));
    set(gca,'YDir','reverse', 'XAxisLocation', 'top');

end