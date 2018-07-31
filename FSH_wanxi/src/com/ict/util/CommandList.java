package com.ict.util;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.nio.charset.Charset;

//import android.util.Log;

public class CommandList {
	public static String remoteHostAddress;
	public static int remoteHostPort;
	public static String[] gateWay;
	public static void getGateWay()
	{
		gateWay = GateWay.getGataWay();

		try
		{
			remoteHostAddress = gateWay[0];
			remoteHostPort = Integer.parseInt(gateWay[1]);
		}
		catch(Exception e)
		{

		}


	}
	public static String getLampMacAddress(String NodeName)
	{	String lampMacAddress = null;
		try
		{
			DatagramSocket ds = new DatagramSocket();
			String cmd =  "select NodeMacAddress from nodeaddressmap where NodeName like '%" + NodeName + "%';";
			byte[] sendData = cmd.getBytes(Charset.forName("UTF-8"));

			DatagramPacket sdp = new DatagramPacket(sendData,
						sendData.length, InetAddress.getByName(remoteHostAddress),
						remoteHostPort);
			ds.send(sdp);

			byte[] receiveData = new byte[4096];

			DatagramPacket rdp = new DatagramPacket(receiveData, receiveData.length);

			ds.receive(rdp);

			lampMacAddress = new String(rdp.getData(),rdp.getOffset(),rdp.getLength());
			lampMacAddress = lampMacAddress.replace("\n","" );
			System.out.println("lampMacAddress: " + lampMacAddress);
			ds.close();
		}
		catch (SocketException e) {
		// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lampMacAddress;
	}
}
