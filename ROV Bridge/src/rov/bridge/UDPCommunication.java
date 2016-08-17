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

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;

/**
 *
 * @author mohamed rashad
 *
 */
public class UDPCommunication {

    static int port = 8888;
    static byte[] sendData = new byte[1024];
    static byte[] receiveData = new byte[1024];

    static Thread thread;
    static String message;
    static InetAddress IPAddress;
    static DatagramSocket serverSocket;
    static DatagramPacket sendPacket, receivePacket;

    /**
     *
     * @param data
     * @throws java.net.SocketException
     *
     */
    public void sendToPIC(byte[] data) throws SocketException, IOException {

        sendData = data;
        serverSocket = new DatagramSocket(port);
        IPAddress = InetAddress.getByName("192.168.1.177");
        sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, port);

        serverSocket.send(sendPacket);
        serverSocket.close();

    }

    /**
     *
     * @param order
     * @return @throws java.io.IOException
     * @throws java.lang.InterruptedException
     *
     */
    public String recieveFromPIC(byte[] order) throws IOException, InterruptedException {

        thread = new Thread() {

            @Override
            public void run() {

                try {

                    sendToPIC(order);
                    serverSocket = new DatagramSocket(port);
                    receivePacket = new DatagramPacket(receiveData, receiveData.length);
                    serverSocket.receive(receivePacket);
                    serverSocket.close();

                    message = new String(receivePacket.getData());
                    
                }catch(IOException e){
                    
                    
                }
            }

        };

        thread.start();

        return message;

    }
}
