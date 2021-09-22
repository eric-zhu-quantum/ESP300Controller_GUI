%get current position of Axis
%
%usage:
% Pos = func_AxisPos_RS232(COMAddress,Axis)

function Pos = func_AxisPos_RS232(COMAddress,Axis)

    ESP = serial(sprintf('com%i',COMAddress), 'DataBits', 8, 'parity', 'none', 'StopBits', 1, 'FlowControl', 'hardware', 'BaudRate', 19200);
    ESP.Terminator = 'CR';
    ESP.Timeout = 2;

    fopen(ESP);

    pause(0.5);
    
    Pos = [];
    NumTries = 0;
    while (1)
        try
            Pos = str2double(query(ESP, sprintf('%iTP?',Axis))); pause(0.05);
        end
        NumTries = NumTries+1;
        if (~isempty(Pos))
            break;
        else
            if (NumTries > 5)
                Pos = nan;
                break;
            end
        end
    end


    fclose(ESP);

end
