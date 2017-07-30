function [bestPIndex , edgeCs, triCs, probs ,bestEdgeC, bestTriC, bestP ] = fit(G, numOfCS ,numOfGS)
% graph: the graph we want to fit the varaibles on it
% numOfCS: number of coefficient to sample
% numOfGS: number of graphs to sample
% bestEdgeC: best edge coefficient for the given class of graphs
% bestTriC: best triangle coefficient fot the geven class of graphs
% bestP: best weight coefficient fot the geven class of graphs
 edgeCs = [0]; %edge coefficient
 triCs = [0];%triangle coefficient
 probs = [0.00001];
 counterForSamples = 0; % keeping track of the number of samples
 while length(probs) < numOfCS
     %determining jump size
     fprintf('sampling method interation number: %d\n',length(probs));
     w = numOfCS/50;
     sigma = sqrt(w/(length(probs)));
     %new random coefficient
     edgeC = edgeCs(length(edgeCs)) + normrnd(0,sigma);
     triC = triCs(length(triCs)) + normrnd(0,sigma);
     %compute probability
     graphs = mcmc(G , edgeC , triC , numOfGS);
     graphs = [graphs {G}];
     sumP = weightSum(graphs , edgeC , triC);
     p = ergmWeight(G,edgeC,triC)/sumP;
     %accept or not mcmc ratia
     if p > probs(length(probs)) || rand < (p/probs(length(probs)))
        edgeCs = [edgeCs edgeC]; 
        triCs = [triCs triC]; 
        probs = [probs p];
     else
         edgeCs = [edgeCs edgeCs(length(edgeCs))];
         triCs = [triCs triCs(length(triCs))];
         probs = [probs probs(length(probs))];
     end
 end
 
 [l bestPIndex] = max(probs);
 bestEdgeC = edgeCs(bestPIndex);
 bestTriC = triCs(bestPIndex);
 bestP = probs(bestPIndex);

end

