# ROV Controller Android to PIC (and Arduino)

An app that makes it possible to control an ROV (underwater Robot) via android

===================================

**This project is work for Admiral Team (Faculty of Engineering, Suez Canal University).**

**This project was made for MATE ROV competition.**

===================================

**This project consists of 3 stages :-**

   - Android controller.
   - PC Bridge.
   - PIC Microcontroller app. (Arduino app as backup)

**Work Flow :-**

- Via any android phone you can control the robot via usb cable to PC or wifi/bluetooth network.

- PC bridge handles the orders then send them to the PIC MCU (Arduino) via Ethernet using UDP / Serial Port.

- In the PIC (Arduino) it recieves the order and behaves according to it.

- PIC (Arduino) can send signals from sensors to PC Bridge via UDP / Serial Port.


**Project Building Blocks :-**

- Android App :

        - A simple user interface consists of buttons for control and seekbar for speed
        - When interacting with UI the app writes to logcat stream
        - Written in Android Java

- PC Bridge :

        - UI changes according to user input or robot's output
        - Contains places to show user or robot's action
        - Connects with android via ADB and reads logcat stream
        - Sends data to robot via Ethernet cable using UDP (or Serial Port in case of Arduino)
        - Written in Java 

- PIC Microcontroller App :

        - Recieves data from PC via ENC28J60 Chip
        - Processes Data and send signals to motors/sensors
        - Sends running values motors
        - Data Transmission is via UDP
        - Written in MikroC (MikroElectronica Embdedded C compiler)
        
- Arduino Board App :

        - Backup to PIC Microcontroller
        - Simple sketch to recieve data on serial port and process data 
        - Envoking actions according to sent data
=============================================================

Code is available for educational purposes and you may re-use it according to the terms of the license.

**Project is signed under GNU Public License v3.0**
