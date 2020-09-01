function final=ConditionMatrix(nblocks,distances)
final=NaN(nblocks*distances*2,4);
nTrialperBlock=distances*2;
BinaryCell = dec2bin(0:(nTrialperBlock/distances*2)-1);
BinaryData = str2double(num2cell(BinaryCell));
AllData = repmat(BinaryData,distances/2,1);
final = [];
for i = 0:length(AllData)/2-1
    AllData(2*i+1:2*(i+1),1)=[(i+1)*100;(i+1)*100];
end
for j = 1:nblocks
    final = [final;AllData(randperm(size(AllData,1)),:)];
end
end