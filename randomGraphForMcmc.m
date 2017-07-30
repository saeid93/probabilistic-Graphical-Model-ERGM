function GM = randomGraphForMcmc( G )
%   a graph with randomly an edge deleted or added to it
%   GM: modefied graph
%   complement of a matrix
adjacencyMatrix = full(adjacency(G));
[numOfNodes , l] = size(adjacencyMatrix);
cAdjacencyMatrix = xor(adjacencyMatrix , ones(numOfNodes , numOfNodes));
cAdjacencyMatrix = double(cAdjacencyMatrix & xor(diag(ones(1,numOfNodes)),ones(numOfNodes,numOfNodes)));
cGraph = graph(cAdjacencyMatrix);
cEdgesOfGraph = table2array(cGraph.Edges)';
[l cNumOfEdges] = size(cEdgesOfGraph);
%   find the graph edges and number of them
edgesOfGraph = table2array(G.Edges)';
[l numOfEdges] = size(edgesOfGraph);
%   50 50 chance of choosing whether add or remove an edge
addOrRemove = rand;
%   remove an edge
if (numOfEdges ~= 0 && addOrRemove < 0.5) || numOfEdges == (numOfNodes * (numOfNodes-1))/2 
    REdgeIndex = randi(numOfEdges); %   to be removed edge index
    GM = rmedge(G , edgesOfGraph(1,REdgeIndex) , edgesOfGraph(2,REdgeIndex));
%   add an edge
else
    REdgeIndex = randi(cNumOfEdges); %   to be removed edge index
    GM = addedge(G , cEdgesOfGraph(1,REdgeIndex) , cEdgesOfGraph(2,REdgeIndex));
end
end

