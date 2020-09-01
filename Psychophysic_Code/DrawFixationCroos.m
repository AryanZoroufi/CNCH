function DrawFixationCroos(WindowPtr,crosslines,crosswidth,crosscolor,xCenter,yCenter)
% ====================== YOUR CODE HERE ======================
% hint: Draw fixation cross using DrawLines
Screen('drawlines',WindowPtr,crosslines,crosswidth,crosscolor,[xCenter,yCenter]);
Screen('Flip',WindowPtr);
%==============================================================
end