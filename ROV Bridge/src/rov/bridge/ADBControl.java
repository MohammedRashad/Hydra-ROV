/*
 * Copyright (C) 2016 root
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


package rov.bridge;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jssc.SerialPortException;

/**
 *
 * @author mohamed rashad
 *
 */
public class ADBControl {

    static int connectionMode;
    static byte[] order;
    static Pattern p;
    static Matcher m;
    static String line, commandStr, IP;
    static BufferedReader br;
    static SerialCommunication serial;
    static UDPCommunication udp;
    static Process process;

    public void control(String port, String mode) throws SerialPortException, IOException {

        System.err.println(mode);
        line = "";
        order = new byte[5];

        Control.jLabel16.setText("Running ADB..");

        connectionMode = setConnectionTypeWithROV(mode);

        initializeADB();

        while (true) {

            Control.jLabel16.setText("Iniatilzing..");

            try {

                Control.jLabel16.setText("Getting Commands..");

                while ((line = br.readLine()) != null) {

                    if (line.contains("open1")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 10};
                        commandStr = "o";

                        SendCommand(connectionMode, commandStr, order, port);

                        Control.jLabel6.setText("Opening");

                    }

                    if (line.contains("open0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);

                        Control.jLabel6.setText("Nothing");
                    }

                    if (line.contains("close1")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 20};
                        commandStr = "c";

                        SendCommand(connectionMode, commandStr, order, port);

                        Control.jLabel6.setText("Closing");
                    }

                    if (line.contains("close0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);

                        Control.jLabel6.setText("Nothing");

                    }

                    if (line.contains("forward0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);

                        Control.jLabel4.setText("Nothing");

                    }
                    if (line.contains("backward0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel4.setText("Nothing");

                    }

                    if (line.contains("up1")) {
                        order = new byte[]{(byte) 0, (byte) 0, (byte) 10, (byte) 0, (byte) 0};
                        commandStr = "u";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel4.setText("Up");
                    }

                    if (line.contains("up0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";
                        SendCommand(connectionMode, commandStr, order, port);

                        Control.jLabel4.setText("Nothing");

                    }

                    if (line.contains("down1")) {
                        order = new byte[]{(byte) 0, (byte) 0, (byte) 20, (byte) 0, (byte) 0};
                        commandStr = "d";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel4.setText("Down");

                    }

                    if (line.contains("down0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel4.setText("Nothing");
                    }


                    if (line.contains("left1")) {
                        order = new byte[]{(byte) 10, (byte) 20, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "l";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel5.setText("Left");

                    }

                    if (line.contains("left0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);

                        Control.jLabel5.setText("Nothing");

                    }

                    if (line.contains("right1")) {
                        order = new byte[]{(byte) 20, (byte) 10, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "r";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel5.setText("Right");

                    }

                    if (line.contains("right0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);

                        Control.jLabel5.setText("Nothing");

                    }

                    if (line.contains("arml1")) {
                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 30};
                        commandStr = "v";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel6.setText("Left");

                    }

                    if (line.contains("arml0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel6.setText("Nothing");

                    }

                    if (line.contains("armr1")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 40};
                        commandStr = "m";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel6.setText("Right");

                    }

                    if (line.contains("armr0")) {

                        order = new byte[]{(byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "s";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel6.setText("Nothing");

                    }

                    if (line.contains("forwardd")) {
                        order = new byte[]{(byte) 10, (byte) 10, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "f";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel4.setText("forward");

                    }

                    if (line.contains("backwardd")) {
                        order = new byte[]{(byte) 2, (byte) 20, (byte) 0, (byte) 0, (byte) 0};
                        commandStr = "b";

                        SendCommand(connectionMode, commandStr, order, port);
                        Control.jLabel4.setText("backward");

                    }
                    if (line.contains("Speed")) {

                        p = Pattern.compile("-?\\d+");
                        m = p.matcher(line);

                        int i = 3;

                        //doing this to extract speed from the adb lines
                        //it comes in 3 stages so we get only the  even line
                        //it gets the right line
                        while (m.find()) {

                            if (i % 2 == 0) {

                                System.out.println(m.group());

                                Control.jLabel8.setText(m.group() + " PWM");

                                String x = "" + m.group();

                                if (m.group().equals("0")) {

                                    Control.jLabel4.setText("Stops");

                                    commandStr = "s";
                                    SendCommand(connectionMode, commandStr, order, port);

                                } else {

                                    commandStr = m.group();
                                    SendCommand(connectionMode, commandStr, order, port);

                                }

                            }

                            i++;

                        }

                    }

                }

            } catch (IOException | NullPointerException ex) {

                Logger.getLogger(Control.class.getName()).log(Level.SEVERE, null, ex);

            }

        }

    }

    private void initializeADB() throws IOException {

        process = Runtime.getRuntime().exec("adb shell getprop " + "ro.product.model");
        br = new BufferedReader(new InputStreamReader(process.getInputStream()));

        if ((line = br.readLine()) != null) {
            Control.jLabel10.setText(line);
        }

        process = Runtime.getRuntime().exec("adb logcat -s " + "ROV");
        br = new BufferedReader(new InputStreamReader(process.getInputStream()));

    }

    private int setConnectionTypeWithROV(String mode) {

        switch (mode) {

            case "Arduino":

                System.err.println("1");
                return 1;

            case "PIC":
                System.err.println("0");
                return 0;

            default:
                System.err.println("-1");
                return -1;

        }

    }

    /**
     *
     * @param connectionMode
     * @param command
     * @param commandByte
     * @param port
     * @throws SerialPortException
     * @throws IOException
     */
    public static void SendCommand(int connectionMode, String command, byte[] commandByte, String port) throws SerialPortException, IOException {

        if (connectionMode == 1) {

            serial = new SerialCommunication();
            serial.SerialCommunicationInitializer(port);
            serial.writeDataToArduino(command);

        } else if (connectionMode == 0) {

            udp = new UDPCommunication();
            udp.sendToPIC(commandByte);

        }

    }

}
