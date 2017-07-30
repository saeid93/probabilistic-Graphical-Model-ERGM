function [ sum ] = gradDescentEdgeSum( gList , edgeC , triC)
%GRADDESCENTEDGESUM.M Summary of this function goes here
%   Detailed explanation goes here
sum = 0;
numOfGraphs = size(gList,2);
sumP = weightSum(gList , edgeC , triC);

for i = 1:numOfGraphs
    currentGraph = gList{i};
    W = ergmWeight(currentGraph,edgeC,triC)/sumP;
    numOfEdges = numedges(currentGraph);
    sum = sum + W * numOfEdges;
end


end

