function Draw_stimulus(data, i, wPtr, screenrect, xCenter, yCenter, black, star, triangle)
switch data(i, 2)
    case 1
        Screen('FillRect', wPtr, black, [xCenter - 200,...
            yCenter - 200, xCenter + 200, yCenter +  200]);
        Screen('Flip', wPtr);
    case 2
        Screen('FillOval',wPtr, black,...
            [xCenter - 200, yCenter - 200, xCenter + 200, yCenter + 200]);
        Screen('Flip', wPtr);
    case 3
        Screen('DrawTexture',wPtr,star,[],screenrect);
            Screen('Flip',wPtr);
    case 4
        Screen('DrawTexture',wPtr,triangle,[],screenrect);
            Screen('Flip',wPtr);
end
end