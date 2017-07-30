function [bestPIndex , edgeCs, triCs, probs ,bestEdgeC, bestTriC, bestP ] = fit(G, numOfIterations ,numOfGS)
% graph: the graph we want to fit the varaibles on it
% numOfCS: number of coefficient to sample
% numOfGS: number of graphs to sample
% bestEdgeC: best edge coefficient for the given class of graphs
% bestTriC: best triangle coefficient fot the geven class of graphs
% bestP: best weight coefficient fot the geven class of graphs
 edgeCs = [0]; %edge coefficient
 triCs = [0];%triangle coefficient
 probs = [0.00001];
 
 
 
numOfSeedEdges = numedges(G);
%   find the number of triangles in the graph
adjacencyMatrix = full(adjacency(G));
adjacencyP3 = adjacencyMatrix^3;
numOfSeedTri = trace(adjacencyP3)/6;


 eta = 0.1;
 edgeC = rand(1);   %initial edge coefficient
 triC = rand(1);    %initial triangle coefficient
 counterForSamples = 0; % keeping track of the number of samples
 
 while length(probs) < numOfIterations
     graphs = mcmc(G , edgeC , triC , numOfGS);
     graphs = [graphs {G}];
     sumP = weightSum(graphs , edgeC , triC);
     p = ergmWeight(G,edgeC,triC)/sumP;
     %determining jump size
      fprintf('gradient descent method interation number: %d\n',length(probs));
%      w = numOfCS/50;
%      sigma = sqrt(w/(length(probs)));
%      %new random coefficient
%      edgeC = edgeCs(length(edgeCs)) + normrnd(0,sigma);
%      triC = triCs(length(triCs)) + normrnd(0,sigma);
     %compute probability

%      graphs = mcmc(G , edgeC , triC , numOfGS);
%      graphs = [graphs {G}];
%      sumP = weightSum(graphs , edgeC , triC);
%      p = ergmWeight(G,edgeC,triC)/sumP;
     %accept or not mcmc ratia
%         grapdient descent


        edgeGrad = numOfSeedEdges - gradDescentEdgeSum(graphs,edgeC,triC );
        triGrad = numOfSeedTri - gradDescentTriSum(graphs,edgeC,triC );
        edgeC = edgeC + eta * edgeGrad;
        triC = triC + eta * triGrad;
        edgeCs = [edgeCs edgeC]; 
        triCs = [triCs triC]; 
        probs = [probs p];
     
 end
 
 [l bestPIndex] = max(probs);
 bestEdgeC = edgeCs(bestPIndex);
 bestTriC = triCs(bestPIndex);
 bestP = probs(bestPIndex);

 plot(probs)
 pause
 
 
end

