package com.ict.java_bean;

import com.ict.util.Config;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.nio.charset.Charset;


/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-19
 * Time: 下午2:43
 * 此java bean只负责向服务器发送数据不进行数据的接收
 * 适用于发送命令指令
 * To change this template use File | Settings | File Templates.
 */
public class SendOnly extends Thread{
    private String cmd;
    private static InetAddress ia;
    public SendOnly(String cmd){
        this.cmd=cmd;
    }
    public String sensorInfo="empty";

    @Override
    public void run(){
        try{
            DatagramSocket ds = new DatagramSocket();

            if(ds!=null){
                ia=InetAddress.getByName(Config.ServerIP);
                byte[] sendData = cmd.getBytes(Charset.forName("UTF-8"));
                DatagramPacket sdp = new DatagramPacket(sendData,
                        sendData.length,
                        ia,
                        Integer.parseInt(Config.ServerPort));
                ds.send(sdp);
                ds.setSoTimeout(1 * 1000);
                byte[] receiveData = new byte[4096];
                DatagramPacket rdp = new DatagramPacket(receiveData,
                        receiveData.length);
                ds.receive(rdp);
                String result = new String(rdp.getData(), rdp.getOffset(),
                        rdp.getLength(),"utf-8");
                System.out.println("~~~~~~~~~~~~~~~~~~服务器返回~~~~~~~~~~~~~~~~~~");
                System.out.println(result);
                System.out.println("~~~~~~~~~~~~~~~~~~~返回结束~~~~~~~~~~~~~~~~~~~");  //没有定义public Map<String, String> xxxx= new HashMap<String, String>();
                if(!result.equals(null)){
                    sensorInfo=result;
                }
            }
        }catch (Exception e){
            /*e.printStackTrace();*/
        }
    }
    public String getSensorInfo(){
        return sensorInfo;
    }

}
