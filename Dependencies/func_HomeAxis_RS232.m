%homes the particular axis in question 
%physically, the axis just stops moving once it hits the negative limit switch
%
%usage: func_HomeAxis_RS232(ComPort, Axis, TextHandle, StopHandle)

function func_HomeAxis_RS232(ComPort, Axis, TextHandle, StopHandle)

    %create a pop-up menu with :
    %            1) TextHandles to tell us what device is doing,
    %            and position of axis under interest
    %           2)  StopHandle that takes a stop command     
    if (~exist('TextHandle', 'var') || ~exist('StopHandle', 'var'))
        [MotionWindowFig, StopHandle, TextHandle] = func_MotionWindow('Homing');
    else
        if (isempty(TextHandle) || isempty(StopHandle))
            [MotionWindowFig, StopHandle, TextHandle] = func_MotionWindow('Homing');
        end
    end


	%initialize the controller
    ESP = serial(sprintf('com%i',ComPort), 'DataBits', 8, 'parity', 'none', 'StopBits', 1, 'FlowControl', 'hardware', 'BaudRate', 19200);
    ESP.Terminator = 'CR';
    ESP.Timeout = 1;
    
    fopen(ESP);
    
	%From the ESP300 manual:
    % 0 = Find +0 Position Count - this moves it to the middle of the range
    % 1 = Find Home and Index Signals  - ditto 0, but moves back and forth
    % 2 = Find Home Signal             - like 0
    % 3 = Find Positive Limit Signal   - gives to +ve end and calls that 0
    % 4 = Find Negative Limit Signal   - goes to -ve end and calls that 0
    % 5 = Find Positive Limit and Index Signals - like 3,  but moves all
    % around to get 'index' signals (but this guy does not have an encoder,
    % so the index signals functionality is not useful
    % 6 = Find Negative Limit and Index Signals    
    
	% move backwards until we hit negative limit switch
    fprintf(ESP, sprintf('%iOR4', Axis)); 
    pause(0.5);
    func_ESP_MovementStopped(ESP, Axis,1,TextHandle, StopHandle);
    fclose(ESP);

	%close the window
    if (exist('MotionWindowFig', 'var'))
        close(MotionWindowFig);
    end

end
