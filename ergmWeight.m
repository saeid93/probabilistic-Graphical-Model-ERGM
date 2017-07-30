function weight = ergmWeight(G,edgeC,triC)
%   edgeC is edge coefficient
%   triC is triangle coefficient
%   this funcion compute the each function by the
%   exponential function

%   extracting nummber of edges in the graph
numOfEdges = numedges(G);
%   find the number of triangles in the graph
adjacencyMatrix = full(adjacency(G));
adjacencyP3 = adjacencyMatrix^3;
numOfTri = trace(adjacencyP3)/6;
%   calculating the weight through the formula
weight = exp(numOfEdges * edgeC + numOfTri * triC);
end
