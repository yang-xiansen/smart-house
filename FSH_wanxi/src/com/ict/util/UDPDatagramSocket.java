package com.ict.util;

import java.net.DatagramSocket;
import java.net.SocketException;

public class UDPDatagramSocket {
	public static DatagramSocket ds;
	public static DatagramSocket getInstanceOfDatagramSocket()
	{

		try {

			ds = new DatagramSocket();

		} catch (SocketException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ds;
	}

	public static  void closeInstanceOfDatagramSocket()
	{
		getInstanceOfDatagramSocket().close();
	}
}
