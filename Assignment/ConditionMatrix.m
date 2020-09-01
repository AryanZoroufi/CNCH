function final = ConditionMatrix(nBlocks)
BinaryCell = dec2bin(0:3);
BinaryData = str2double(num2cell(BinaryCell));
AllData = repmat(BinaryData, 2, 1);
final = [];
for i = 1 : length(AllData)
    AllData(i,1) =  fix((i - 1) / 2) + 1;
end
for j = 1 : nBlocks
    final = [final;[repmat(j,size(AllData,1),1)...
        , AllData(randperm(size(AllData,1)),:)]];
end
final(:, 3) = (final(:, 3) * 800) + 200 ;
final(:, 4) = final(:, 2) * 400 ;
end