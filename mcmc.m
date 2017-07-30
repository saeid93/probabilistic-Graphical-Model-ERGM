function mcmcGraphs = mcmc(seedG , edgeC , triC , numOfSample)
%   Monte Carlo sampling
%   seedG: seed graph
%   edgeC: edge coefficient
%   triC: triangle coefficient
%   numOfSample: number of sample we wish to generate
%   mcmcGraphs: cell array of generated graph
mcmcGraphs = [];
%   count the number nodes
adjacencyMatrix = full(adjacency(seedG));
[numOfNodes , l] = size(adjacencyMatrix);
% make a new random graph at size of seed and a random number of edges
numOfEdges = randi((numOfNodes * (numOfNodes - 1))/2);
currentGraph = randomGraph(numOfNodes , numOfEdges);
currentW = ergmWeight(currentGraph , edgeC , triC);
i = 1;
while i<=numOfSample
    generatedGraph = randomGraphForMcmc(currentGraph);
    generatedGraphW = ergmWeight(generatedGraph , edgeC , triC);
%     mcmc ratia check
    if generatedGraphW > currentW || rand < generatedGraphW / currentW
        mcmcGraphs = [mcmcGraphs {generatedGraph}];
        currentW = generatedGraphW;
    else
        i = i - 1;
    end
    i = i + 1;
end
end

