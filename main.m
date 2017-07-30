clear;
close;
%initial random graph statistics
fprintf('--------graph statistics--------\n');
nodes = input('enter the number of nodes:\n');
links = input('enter the number of linkes:\n');
% algorithm parameters
fprintf('--------algorithm parameters--------\n');
numOfCS = input('enter the number of coefficient samples:\n');
numOfGS = input('enter the number of graph samples per interation:\n');
%generate first graph as the seed
G = randomGraph( nodes , links );
method = input('enter the training method\n1.sampling\n2.gradient descent\n3.both\n');
if method == 1
    [bestPIndex , edgeCs, triCs, probs ,bestEdgeC, bestTriC, bestP ] = fit(G, numOfCS , numOfGS);
elseif method == 2
    [bestPIndex, edgeCs, triCs, probs ,bestEdgeC, bestTriC, bestP ] = fit2(G, numOfCS , numOfGS);
elseif method == 3
    [bestPIndex, edgeCs, triCs, probs ,bestEdgeC, bestTriC, bestP ] = fit(G, numOfCS , numOfGS);
    [bestPIndex1, edgeCs1, triCs1, probs1 ,bestEdgeC1, bestTriC1, bestP1 ] = fit2(G, numOfCS , numOfGS);
end
if method == 1 || method == 2
    x = 1:length(probs);
    subplot(1,2,1);
    figure
    plot(x, edgeCs, x, triCs);
    hold;
    h = vline(bestPIndex,'g','optimal');
    legend('edge coefficient','triangle coefficient','Location','northeast');
    subplot(1,2,2);
    plot(G);
    fprintf('the optimal edge coefficient for current family of graphs is: %d\n',bestEdgeC);
    fprintf('the optimal triangle coefficient for current family of graphs is: %d\n',bestTriC);
    fprintf('the optimal p for current family of graphs is: %d\n',bestP);
elseif method ==3
    testSet = mcmc(G ,bestEdgeC1,bestTriC1, numOfGS);
    testSet = [testSet {G}];
    x = 1:length(probs);
    subplot(1,3,1);
    plot(x, edgeCs, x, triCs);
    hold;
    h = vline(bestPIndex,'g','optimal');
    title('sampling method');
    legend('edge coefficient','triangle coefficient','Location','northeast');
    subplot(1,3,2);
    plot(x, edgeCs1, x, triCs1);
    hold;
    h = vline(bestPIndex,'g','optimal');
    title('gradient descent method');
    legend('edge coefficient','triangle coefficient','Location','northeast');
    subplot(1,3,3);
    title('seed graph');
    plot(G);
    fprintf('----sampling method----\n');
    fprintf('the optimal edge coefficient for current family of graphs is: %d\n',bestEdgeC);
    fprintf('the optimal triangle coefficient for current family of graphs is: %d\n',bestTriC);
    fprintf('the optimal ergm for current family of graphs is: %d\n',ergmWeight(G, bestEdgeC , bestTriC));
    fprintf('the optimal p for current family of graphs is: %d\n',ergmWeight(G,bestEdgeC,bestTriC)/weightSum(testSet, bestEdgeC , bestTriC));
    fprintf('----gredient descent method----\n');
    fprintf('the optimal edge coefficient for current family of graphs is: %d\n',bestEdgeC1);
    fprintf('the optimal triangle coefficient for current family of graphs is: %d\n',bestTriC1);
    fprintf('the optimal ergm for current family of graphs is: %d\n',ergmWeight(G, bestEdgeC1 , bestTriC1));
    fprintf('the optimal p for current family of graphs is: %d\n',ergmWeight(G,bestEdgeC1,bestTriC1)/weightSum(testSet, bestEdgeC1 , bestTriC1));
end