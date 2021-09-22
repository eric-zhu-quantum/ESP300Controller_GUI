%moves the Axis in question to the New position NewPos
%
%usage: func_MoveAxis_RS232(ComPort, Axis, NewPos)

function func_MoveAxis_RS232(ComPort, Axis, NewPos, TextHandle, StopHandle)


    %create a pop-up menu with :
    %            1) TextHandles to tell us what device is doing,
    %            and position of axis under interest
    %           2)  StopHandle that takes a stop command     
    if (~exist('TextHandle', 'var') || ~exist('StopHandle', 'var'))
        [MotionWindowFig, StopHandle, TextHandle] = func_MotionWindow('Moving');
    else
        if (isempty(TextHandle) || isempty(StopHandle))
            [MotionWindowFig, StopHandle, TextHandle] = func_MotionWindow('Moving');
        end
    end

	%initialize controller
    ESP = serial(sprintf('com%i',ComPort), 'DataBits', 8, 'parity', 'none', 'StopBits', 1, 'FlowControl', 'Hardware', 'BaudRate', 19200);
    ESP.Terminator = 'CR';
    ESP.Timeout = 1;

    %grab current position
    StartPos = func_AxisPos_RS232(ComPort, Axis);
    
    fopen(ESP);

    fprintf(ESP, sprintf('%iMO\n', Axis)); %turn on motor 
    pause(0.3);

    % set backlash compensation:
    fprintf(ESP, sprintf('%iBA%2.4f\n',Axis,0.006));   
    pause(0.2);

	% now move!
    fprintf(ESP, sprintf('%iPA%2.4f\n',Axis,NewPos));   
	% keep track of axis position with popup window:
	func_ESP_MovementStopped(ESP, Axis,1, TextHandle, StopHandle); 

    fclose(ESP);
    
	% if we create a new window, close it!
    if (exist('MotionWindowFig', 'var'))
        close(MotionWindowFig);
    end
        
end