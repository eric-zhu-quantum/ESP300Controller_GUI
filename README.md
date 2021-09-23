# ESP300Controller_GUI
MATLAB GUI and assorted functions for the Newport ESP300 motion controller

This is the Newport ESP300 controller:

<img src="https://github.com/eric-zhu-quantum/ESP300Controller_GUI/blob/main/Pics/ESP300.png" alt="ESP300" width="500"/>


It can control 3 linear actuators ('axes').   We can issues commands to it from a PC/MATLAB through GPIB or RS232 connections.  
This particular GUI and the supporting scripts use RS232, but can be easily modified for GPIB control.  

This is what the GUI looks like:

<img src="https://github.com/eric-zhu-quantum/ESP300Controller_GUI/blob/main/Pics/GUI.png" alt="GUI" width="350"/>


## A tour of the GUI

Here's a labelled look at the GUI.  

<img src="https://github.com/eric-zhu-quantum/ESP300Controller_GUI/blob/main/Pics/GUI_explained.png" alt="GUI_explained" width="399"/>

1)  In order to initialize the GUI, we must provide the RS232 COM port and press the 'Connect!' button.  
When the GUI is busy, red text that says 'WORKING' will be shown in the bottom left corner (Status frame, part 5) of the GUI.  
Once it has finished initializing the 'WORKING' flag will disappear, and the axes positions will appear. 
Any axis that is not connected will be assigned a default position of '0'.  (All measures are in millimetres).  

2)  We can 'jog' each axis by first selecting the axis to move from the pull-down menu, and setting the amount to move by.  
By pressing the '---' or '+++' button, we can jog the axis back and forth (respectively) by the amount indicated.  
Wait until the 'WORKING' flag in the Status frame has disappeared before performing another action.  

3)  We can move an axis to a new position by first selecting the axis of interest with the pull-down menu, setting the position, and pressing 'Go!'. 
Wait until the 'WORKING' flag in the Status frame has disappeared before performing another action.   

4)  We can home a particular stage (based on negative limit switch) by selecting the axis of interest and pressing 'Home!'

5)  Finally, this Status frame is where the 'Working' indicator text turns on when any of the axes are being moved.  
If you want to halt the actuator immediately, press the 'Stop!!!' radio button.  This will cause the actuator to do an emergency stop (E-Stop).  



