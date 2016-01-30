# ROV-Controller-Android-to-PIC

An app that makes it possible to control an ROV (underwater Robot) via android

===================================

**This project is work for Admiral Team (Faculty of Engineering, Suez Canal University).**

**This project was made for MATE ROV competition.**

===================================

**This project consists of 3 stages :-**

   - Android controller.
   - PC Bridge.
   - PIC Microcontroller app.

**Work Flow :-**

- Via any android phone you can control the robot via usb cable to PC or wifi/bluetooth network.

- PC bridge handles the orders then send them to the PIC MCU via Ethernet using UDP.

- In the PIC it recieves the order and behaves according to it.

- PIC can send signals from sensors to PC Bridge via UDP.


**Project Building Blocks :-**

- Android App :

        - A simple user interface consists of buttons for control and seekbar for speed

        - When interacting with UI the app writes to logcat stream
        
        - Written in Java

- PC Bridge :

        - UI changes according to user input or robot's output
        
        - Contains places to show user or robot's action

        - Connects with android via ADB and reads logcat stream

        - Sends data to robot via Ethernet cable using UDP

        - Written in Java 

- PIC Microcontroller App :

        - Recieves data from PC via ENC28J60 Chip
        
        - Processes Data and send signals to motors/sensors
        
        - Recieve data from sensors
        
        - Send data to PC via ENC28J60 Chip 
       
        - Data Transmission is via UDP
       
        - Written in MikroC
        

=============================================================

Code is available for educational purposes and you may re-use it according to the terms of the license.

**Project is signed under GNU Public License v3.0**
