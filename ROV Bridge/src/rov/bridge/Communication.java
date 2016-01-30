package rov.bridge;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author rashad
 */

public class Communication {

    static byte[] receiveData = new byte[1024];
    static byte[] sendData = new byte[1024];
    static DatagramSocket serverSocket;
    static DatagramPacket sendPacket;
    static DatagramPacket receivePacket;
    static Thread thread;
    static InetAddress IPAddress;

    public static void main(String args[]) throws IOException {

        System.out.println("started");


    }

    /**
     * @param c
     * @throws java.net.SocketException
     *
     * this method takes those parameters and initiate the datagram socket opens
     * a certain port to send data to it via UDP 
     *
     *
     */
    
    public static void send(String c) throws SocketException, IOException {

        sendData = c.getBytes();

        serverSocket = new DatagramSocket(9876);

        IPAddress = InetAddress.getByName("192.168.1.1");
        sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, 9876);
        serverSocket.send(sendPacket);

    }

    /**
     * This method is called from USB or BT class and make the thread runs forever to listen for 
     * messages from the PIC microcontroller
     *
     *
     * @throws java.io.IOException
     */
    public static void recieve() throws IOException {

        thread = new Thread() {

            @Override
            public void run() {

                while (true) {

                    try {

                        //gets data from port 
                        serverSocket = new DatagramSocket(9876);
                        receivePacket = new DatagramPacket(receiveData, receiveData.length);
                        serverSocket.receive(receivePacket);

                        //starts processing the data 
                        String message = new String(receivePacket.getData());

                        //choose which value to get 
                        if (message.contains("Temprature")) {

                            USB.jLabel14.setText(message);
                            BT.jLabel14.setText(message);
                            

                        } else if (message.contains("Pressure")) {

                            USB.jLabel15.setText(message);
                            BT.jLabel14.setText(message);

                        } else {

                        }

                    } catch (IOException ex) {

                        Logger.getLogger(Communication.class.getName()).log(Level.SEVERE, null, ex);

                    }

                }

            }
        };

    }
}
