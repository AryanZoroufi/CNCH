function [UpImage,DownImage]=ReadImages(WindowPtr)
%Note: up image is in a file named up.png and down image is in a file named
%down.png
% ====================== YOUR CODE HERE ======================
UpImageM=imread('UP.png');
DownImageM=imread('Down.png');
UpImage = Screen('MakeTexture',WindowPtr,UpImageM);
DownImage = Screen('MakeTexture',WindowPtr,DownImageM);
%==============================================================
end