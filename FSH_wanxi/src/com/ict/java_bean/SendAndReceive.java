package com.ict.java_bean;

import com.ict.util.Config;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-9-29
 * Time: 上午10:05
 * 此java bean负责与服务器进行数据交互 十分重要
 * 包括向服务器发送命令与接收服务器返回的信息
 * To change this template use File | Settings | File Templates.
 */
public class SendAndReceive extends Thread {
    private String cmd;
    private static InetAddress ia;
    public Map<String, String> sensorState = new HashMap<String, String>(); // 保存节点的NodeName和MacAddress
    public SendAndReceive(String cmd){
        this.cmd=cmd;
    }

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

                byte[] receiveData = new byte[4096];
                DatagramPacket rdp = new DatagramPacket(receiveData,
                        receiveData.length);
                ds.setSoTimeout(1 * 1000);
                ds.receive(rdp);
                String result = new String(rdp.getData(), rdp.getOffset(),
                        rdp.getLength(),"utf-8");
                System.out.println("~~~~~~~~~~~~~~~~~~服务器返回~~~~~~~~~~~~~~~~~~");
                System.out.println(result);
                System.out.println("~~~~~~~~~~~~~~~~~~~返回结束~~~~~~~~~~~~~~~~~~~");
                if (!result.startsWith("ERROR")) {
                    String[] arrayString = result.split("\n");
                    for (int i = 0; i < arrayString.length; i++) {
                        String[] onelineSet = arrayString[i].split(":");
                        if (onelineSet.length > 1) {
                            sensorState.put(onelineSet[0], onelineSet[1]);
                        }
                    }
                }
            }
        }catch(UnknownHostException e){
            e.printStackTrace();
        }catch (IOException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public Map<String,String> getSensorState(){  //此函数的作用是方便其他接口调用来返回sensorState（状态）
        return sensorState;
    }
    public static void main(String[] args) {
        //SendAndReceive send=new SendAndReceive("Mac 1302185705677019795 1 CmdNrm Switch_Off");
        //send.run();
        //Map<String, String> sensorState=send.getSensorState();
        //System.out.println(sensorState.get("NodeMac"));
    }
}
