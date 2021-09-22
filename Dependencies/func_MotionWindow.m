%Create an instance of the MotionWindow figure, and send back the handles
% for the E-stop button (StopHandle) and text output (TextHandle)
%
%usage: [MotionWindowFig, StopHandle, TextHandle] = func_MotionWindow(ActionStr)

function [MotionWindowFig, StopHandle, TextHandle] = func_MotionWindow(ActionStr)

    MotionWindowFig = open('MotionWindow.fig');
    movegui(MotionWindowFig, [250 100]);

    StopHandle = findobj(MotionWindowFig, 'tag', 'Butt_stop'); 
    
    TextHandle = findobj(MotionWindowFig, 'tag', 'Pos_String');
    set(TextHandle, 'Fontsize', 16);
    
    ActionHandle = findobj(MotionWindowFig, 'tag', 'Action'); 
    set(ActionHandle, 'String', ActionStr, 'Fontsize', 16);
end
