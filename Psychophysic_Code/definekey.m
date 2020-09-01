function [up,down]=definekey()
KbName('UnifyKeyNames');
    %Structure: Define UpArrow as UP and DownArrow as Down answer:
    %Note: MATLAB IS CASE SENSETIVE('KbName','upArrow','downArrow' is correct)
    %hint: Write with this structure
%     yes=...;
%     no=...;
% ====================== YOUR CODE HERE ======================
up = KbName('UpArrow');
down = KbName('DownArrow');
%==============================================================
end