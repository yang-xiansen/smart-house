package com.ict.util;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.nio.charset.Charset;

public class SendCmd {
	public static void sendCommand(DatagramSocket ds, String ip, int port, String commandString){
		try{
			DatagramPacket dp = new DatagramPacket(commandString.getBytes(Charset.forName("UTF-8")), commandString.getBytes().length, InetAddress.getByName(ip), port);
			ds.send(dp);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
