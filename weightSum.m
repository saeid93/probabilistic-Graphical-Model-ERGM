function sum = weightSum( gList , edgeC , triC )
% gList: generated graph cell list 
[l sizeOfGList] = size(gList);
sum = 0;
for i = 1:sizeOfGList
    sum = sum + ergmWeight(gList{i},edgeC,triC);
end

end

