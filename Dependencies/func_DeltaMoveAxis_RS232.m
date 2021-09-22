%move the Axis in question by Delta 
%
%usage: func_DeltaMoveAxis(ComPort, Axis, Delta)

function func_DeltaMoveAxis_RS232(ComPort, Axis, Delta,NoBackLash, TextHandle, StopHandle)


    %create a pop-up menu with :
    %            1) TextHandles to tell us what device is doing,
    %            and position of axis under interest
    %           2)  StopHandle that takes a stop command     
    if (~exist('TextHandle', 'var') || ~exist('StopHandle', 'var'))
        [MotionWindowFig, StopHandle, TextHandle] = func_MotionWindow('Jogging');
    else
        if (isempty(TextHandle) || isempty(StopHandle))
            [MotionWindowFig, StopHandle, TextHandle] = func_MotionWindow('Jogging');
        end
    end



    if ~exist('NoBackLash', 'var')
        NoBackLash = 0;
    end
	
    Pos = func_AxisPos_RS232(ComPort, Axis);
    NewPos = Pos + Delta;

    ESP = serial(sprintf('com%i',ComPort), 'DataBits', 8, 'parity', 'none', 'StopBits', 1, 'FlowControl', 'hardware', 'BaudRate', 19200);
    ESP.Terminator = 'CR';
    ESP.Timeout = 1;
    
	
    fopen(ESP);

    fprintf(ESP, sprintf('%iMO', Axis)); %turn on motor 
    pause(0.5);
    
    if (NoBackLash == 0) % turn on backlash compensation... 
		fprintf(ESP, sprintf('%iBA%2.4f\n',Axis,0.006));   
		pause(0.2);
    end
	
    fprintf(ESP, sprintf('%iPA%2.4f',Axis,NewPos));   
	func_ESP_MovementStopped(ESP, Axis,1,TextHandle, StopHandle); % update the MotionWindow with the current axis position
    fclose(ESP);

	%destroy the window... 
    if (exist('MotionWindowFig', 'var'))
        close(MotionWindowFig);
    end
    
end
