package com.ict.util;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class Ping {
	public static boolean pingIpAddress() {
		String host = "www.baidu.com";
		int timeOut = 3000; // I recommend 3 seconds at least
		boolean status = false;
		try {
			status = InetAddress.getByName(host).isReachable(timeOut);

		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;
		}

}
