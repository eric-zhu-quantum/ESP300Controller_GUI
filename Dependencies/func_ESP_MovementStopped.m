%Takes the handle of the initialized ESP300 controller, and monitors 
% the position of the particular axis (motor_axis) until it has stopped
% moving completely, all the while continuously outputting the position of axis to the 
% MotionWindow (through TextHandle)
% StopHandle: Handle for E-stop button on MotionWindow
%
% usage: fig_handle = func_ESP_WaitTilStopped(gpibdevice, motor_axis, close_fig, TextHandle, StopHandle)

function fig_handle = func_ESP_WaitTilStopped(gpibdevice, motor_axis, close_fig, TextHandle, StopHandle)
    
    
    Movements = [];
    while (1)
        Speed = str2num(query(gpibdevice, sprintf('%iDV', motor_axis))) ;
        Pos = str2num(query(gpibdevice, sprintf('%iTP?', motor_axis))) ;
        set(TextHandle, 'String', sprintf('%c = %02.03f', char('x'-1+motor_axis), Pos));
        if isempty(Pos)
            Pos = NaN;
        end
        if isempty(Speed)
            Speed = NaN;
        end
        Movements = [Movements, [Speed;Pos]];
%         plot(figax(1), 1:length(Movements(1,:)), Movements(1,:));
%         plot(figax(2), 1:length(Movements(1,:)), Movements(2,:));
        if (length(Movements(1,:))> 25)
            if (sum(abs(Movements(1,(end-10):end)))) == 0
                break;
            end
        end
%         title(figax(1), 'Speed (mm/s)');
%         title(figax(2), 'Pos (mm)');
        drawnow()
        
        
        if get(StopHandle, 'Value')  == 1
            fprintf(gpibdevice, 'ST');
            
        end
    end
    
    set(StopHandle, 'Value', 0);
    

    
end