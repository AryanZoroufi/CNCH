function final = TrainingConditionMatrix(nBlocks)
AllData = (1 : 4)';
final = [];
for j = 1 : nBlocks
    final = [final;[repmat(j,size(AllData,1),1)...
        , AllData(randperm(size(AllData,1)),:)]];
end
final(:, 3) = final(:, 2) * 400 ;
end