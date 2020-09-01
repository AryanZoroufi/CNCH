                                    %% CNCH Programming Assignment
%% Description
%% Arduino Definitions
clear all; clc; %clear the workspace and command window
global a;
if ~isempty(instrfind);
    fclose(instrfind);
    delete(instrfind);
end
a = arduino;
output = 0;
%% Screen Skip sync test
Screen('Preference', 'SkipSyncTests', 1);% skip the sync test of psychtoolbox
%% Login prompt
prompt = {'Subject name:', 'Subject''s number:', 'age', 'gender', 'group', 'Num of Blocks'};%define login prompt to get subject info
defaults = {'AB', '1', '18', 'M', 'pilot' , '1'};%define defult answers
answer = inputdlg(prompt, 'TST', 2, defaults);%run the input dialog
[output_name, subid, subage, gender, group, nBlocks] = deal(answer{:});%save answers
nBlocks = str2double(nBlocks);
%% Save the current directory
File_location = pwd;
%% Define keys
KbName('UnifyKeyNames');
[spaceKey, escKey] = Define_Key();
%% Define Colors
[white, black, grey] = DefineColors;
%% Condition Matrix
test_data=ConditionMatrix(nBlocks);
training_data = TrainingConditionMatrix(nBlocks);
%% Define Beep Duration
Beepduration = 0.3;
%% Start Psychtoolbox
[wPtr, screenrect] = Screen('OpenWindow',max(Screen('Screens')),grey ); %Open a grey Screen
topPriortyLevel=MaxPriority(wPtr); %Give the screen the max priorty in CPU
xCenter = screenrect(3)/2;
yCenter = screenrect(4)/2;
WaitSecs(1); %Wait 1s
%% Read Imagess
[star, triangle]=ReadImages(wPtr);%% Read Target Images
cd(File_location);
%% Main Loop
for i = 1 : length(training_data)
    Draw_stimulus(training_data, i, wPtr, screenrect, xCenter,...
         yCenter, black, star, triangle);
    Training_freq = training_data(i, 3);
    Beep = MakeBeep(Training_freq, Beepduration);
    Snd('Play', Beep);
    WaitSecs(1);
    Screen('FillRect', wPtr, grey);
    Screen('Flip', wPtr);
    WaitSecs(2);
end
Screen('TextSize', wPtr, 24);
Screen('DrawText',wPtr,'Wait for 3 minutes' ...
    ,xCenter - 100, yCenter,black);
Screen('Flip', wPtr);
WaitSecs(18);
Screen('FillRect', wPtr, grey);
for i = 1 : length(test_data)
    Screen('DrawText',wPtr,'Set your KNOB to MAX and then press any key' ...
        ,xCenter - 300, yCenter,black);
    Screen('Flip', wPtr);
    KbWait();
    Screen('FillRect', wPtr, grey);
    Screen('Flip', wPtr);
%% Draw Stimulus Function(TO BE COMPLETETD)
    Draw_stimulus(test_data, i, wPtr, screenrect, xCenter...
        , yCenter, black, star, triangle)
%% Define Sound info from condition matrix(TO BE COMPLETED)
    Stimulus_freq = define_sound(test_data, i);
%% part 2: Get Subject Response
    keypressed=-1; keyCode=0;keyIsDown = 0;     
    while keyIsDown == 0
        arduino_data = -output * 100;
        Beepfrequency = Stimulus_freq + arduino_data;
        TargetBeep = MakeBeep(Beepfrequency, Beepduration);
        Snd('Play', TargetBeep);
        timeStart = GetSecs;secs = 0;keyIsDown = 0;
        while 1 
            [keyIsDown, secs, keyCode] = KbCheck;
            keypressed = find(keyCode);           
            output = Arduino_result(a);
            if secs - timeStart > 1
                break
            end
            if keyIsDown
                if keypressed == escKey
                    clear a
                    sca;
                end
                break;  
            end
        end
    end
    Screen('FillRect', wPtr, grey);
    WaitSecs(1);
%% Get Subject Data
    test_data = Get_Data(test_data, i, Stimulus_freq, Beepfrequency);
end
sca;
directory = [File_location,output_name,'_',subid];
mkdir(directory);
cd(directory);
fullname=['Subject' subid 'fulldata.mat'];
save(fullname);