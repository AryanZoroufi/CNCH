                                    %% CNCH PSYCHOPHYSICS WORKSHOP- YAZD
%% Login prompt
clear;clc; %clear the workspace and command window    
Screen('Preference', 'SkipSyncTests', 1);% skip the sync test of psychtoolbox
prompt = {'Subject name:', 'Subject''s number:', 'age', 'gender', 'group', 'Num of Blocks'};%define login prompt to get subject info
defaults = {'AB', '1', '18', 'M', 'pilot' , '1'};%define defult answers
answer = inputdlg(prompt, 'TST', 2, defaults);%run the input dialog
[output, subid, subage, gender, group, nBlocks] = deal(answer{:});%save answers
nBlocks = str2num(nBlocks);
%% Define keys
[up,down]=definekey();
spaceKey = KbName('space'); escKey = KbName('ESCAPE');
%% Define Colors
white = [255 255 255]; black = [ 0 0 0]; grey = [127.5 127.5 127.5];
red = [255 0 0]; green = [0 255 0]; blue = [0 0 255];
%% Condition Matrix
data=ConditionMatrix(nBlocks,8);
%% Fixation Pointt Info
crosslength=10; 
crosscolor=[0 0 0];
crosswidth=3;
crosslines=[-crosslength,0; crosslength,0; 0,-crosslength; 0,crosslength];
crosslines=crosslines';
%% Start Psychtoolbox
screens=Screen('Screens'); %Find the code of laptop monitor
screenNumber=max(screens); % Set Laptop Monitor as Default Screen
[WindowPtr, screenrect] = Screen('OpenWindow',screenNumber,grey ); %Open a grey Screen
topPriortyLevel=MaxPriority(WindowPtr); %Give the screen the max priorty in CPU
%Define Center of the Screen
xCenter=screenrect(3)/2;
yCenter=screenrect(4)/2;
%wait until subject response
% KbWait();
WaitSecs(1); %Wait 300 ms
%% Read Target Images
[upimage,downimage]=ReadImages(WindowPtr);
%% Draw Fixation point
DrawFixationCroos(WindowPtr,crosslines,crosswidth,crosscolor,xCenter,yCenter);
%% Main Loop
nTrialsperblock=16;
for i = 1:nBlocks*nTrialsperblock
%Part1: Show the Stimuli using Imread
    %Structure: In Matrix define 0 as up and 1 as down
    %hint(IMPORTANT): Define the place of Stimuli like this:
%           [(xCenter+data(i,1)-30),(yCenter-30),(xCenter+data(i,1)+30),(yCenter+30)]
% ====================== YOUR CODE HERE ======================
    if data(i,2)==0
        Screen('DrawTexture',WindowPtr,upimage,[],[xCenter+data(i,1)-30,yCenter-30,...
            xCenter+data(i,1)+30,yCenter+30]);
        DrawFixationCroos(WindowPtr,crosslines,crosswidth,crosscolor,xCenter,yCenter);
    elseif data(i,2)==1
        Screen('DrawTexture',WindowPtr,downimage,[],[xCenter+data(i,1)-30,yCenter-30,...
            xCenter+data(i,1)+30,yCenter+30]);
        DrawFixationCroos(WindowPtr,crosslines,crosswidth,crosscolor,xCenter,yCenter);
    end
    WaitSecs(0.3);
%==============================================================
    DrawFixationCroos(WindowPtr,crosslines,crosswidth,crosscolor,xCenter,yCenter);
%part 2: Get Subject Data
    %Structure: Calculate Accuracy and reaction time of the subject and Save
    %accuracy in third column and RT in 4th column of data matrix
    timestart=GetSecs;
    KbWait();
    [keyIsDown, secs, keyCode] = KbCheck();
    keypressed=find(keyCode);
%hint: && stands for and in matlab and || stands for or in matlab
% ====================== YOUR CODE HERE ======================
    if (data(i,2)==0 && keypressed==up) || (data(i,2)==1 && keypressed==down)
        data(i,3)=1;
        data(i,4)=GetSecs-timestart;
    else
        data(i,3)=0;
    end
    WaitSecs(1);
%==============================================================
end
sca;