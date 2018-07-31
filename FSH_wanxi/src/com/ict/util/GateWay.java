package com.ict.util;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.nio.charset.Charset;


public class GateWay {


	public  static String[]  getGataWay()
	{
		String[] gateWay = new String[2];  //定义字符串数组，长度为2
		String gateWayAddress = null;
		String gateWayPort = null;

		gateWayAddress = "127.0.0.1";
        //gateWayAddress = "192.168.1.250";
		gateWayPort = "6789";
		gateWay[0] = gateWayAddress;
		gateWay[1] = gateWayPort;
		/***
		try
		{
			DatagramSocket ds = UDPDatagramSocket.getInstanceOfDatagramSocket();
			String cmd = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + "\n"
			+ "<VideoMonitor>" + "\n"
			+ "<SerialNumber>0</SerialNumber>" + "\n"
			+ "<GW-URI>iot://XY.GW.wsn.tnsroot.cn</GW-URI>" + "\n"
			+ "<Record>" + "\n"
			+ "<ServiceType>Query</ServiceType>" + "\n"
			+ "<URI>iot://XY.GW.WSN.tnsroot.cn/monitor/1/���缼���о�����/������</URI>" + "\n"
			+ "<ID>1001</ID>" + "\n"
			+ "</Record>" + "\n"
			+ "</VideoMonitor>" + "\n";
			System.out.println(cmd);
			byte[] sendData = cmd.getBytes(Charset.forName("UTF-8"));
			DatagramPacket sdp = new DatagramPacket(sendData,
					sendData.length,InetAddress.getByName("218.241.108.59"),4446);
			ds.send(sdp);
			byte[] receiveData = new byte[4096];
			DatagramPacket rdp = new DatagramPacket(receiveData, receiveData.length);
			ds.setSoTimeout(3*1000);
			ds.receive(rdp);
			String result = new String(rdp.getData(),rdp.getOffset(),rdp.getLength());
			System.out.println(result);
			if (result.startsWith("ERROR"))
			{
				gateWay = null;
			}
			else
			{
				result = result.replaceAll("\r\n", "");
				String[] s = result.split("<GW-IP>");
				if (s.length > 1)
				{
					s = s[1].split("</GW-IP>");
					if (s.length > 1)
					{
						gateWayAddress = s[0];
						s = s[1].split("<GW-Port>");
						s = s[1].split("</GW-Port>");
						if (s.length > 1)
						{
							gateWayPort = s[0];
						}
					}
				}
				gateWay[0] = gateWayAddress;
				gateWay[1] = gateWayPort;
				if (gateWayAddress != null)
				{
					System.out.println(gateWayAddress);
				}
				if (gateWayPort != null)
				{
					System.out.println(gateWayPort);
				}

			}

		}
		catch (SocketException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 catch(Exception e)
			 {
				 e.printStackTrace();
			 }

		***/
		return gateWay;
	}


}
