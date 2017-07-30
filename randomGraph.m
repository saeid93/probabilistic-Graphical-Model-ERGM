function G = randomGraph( nodes , links )
%-----------------generating a random graph

allEdge = nchoosek(1:nodes,2);
allEdge = allEdge';
choosenEdgeIndex = randsample(1:(nodes*(nodes-1))/2,links);
choosenEdge = [];
for i = 1:links
    choosenEdge = [choosenEdge allEdge(:,choosenEdgeIndex(i))];
end
s = choosenEdge(1,:);
t = choosenEdge(2,:);
G = graph(s,t);

end

