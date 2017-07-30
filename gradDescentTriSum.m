function [ sum ] = gradDescentTriSum( gList , edgeC , triC)
%GRADDESCENTSUM Summary of this function goes here
%   Detailed explanation goes here
sum = 0;
numOfGraphs = size(gList,2);
sumP = weightSum(gList , edgeC , triC);

for i = 1:numOfGraphs
    currentGraph = gList{i};
    W = ergmWeight(currentGraph,edgeC,triC)/sumP;
    adjacencyMatrix = full(adjacency(currentGraph));
    adjacencyP3 = adjacencyMatrix^3;
    numOfTri = trace(adjacencyP3)/6;
    sum = sum + W * numOfTri;
end



end

