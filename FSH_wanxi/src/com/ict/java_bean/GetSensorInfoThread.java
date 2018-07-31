package com.ict.java_bean;

import com.ict.util.GateWay;

import java.io.IOException;
import java.net.*;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-9-17
 * Time: 下午3:12
 * * 此java bean为项目初始时获得所有节点信息时创建的
 * 此后又创建了SendAndReceive 的java bean 且功能更为完善，
 * 此bean 不再使用
 * To change this template use File | Settings | File Templates.
 */

public class GetSensorInfoThread extends Thread implements Runnable {
    private String remoteHostAddress; //远程ip
    private int remoteHostPort; //端口
    public Map<String, String> sensorListInfo = new HashMap<String, String>();// 保存节点的NodeName和MacAddress

    private ArrayList nodeNameList = new ArrayList();   //创建动态数组用来存储节点

    @Override
    public void run() {
        try {
            String[] gateWay = GateWay.getGataWay();

            remoteHostAddress = gateWay[0]; //获得ip
            if (remoteHostAddress == null || remoteHostAddress == "") {//连接服务器错误！
            } else {
                remoteHostPort = Integer.parseInt(gateWay[1]);  //将字符串解析成int型port
                sensorListInfo.put("remoteHostAddress", remoteHostAddress);
                sensorListInfo.put("remoteHostPort", gateWay[1]);

                DatagramSocket ds = new DatagramSocket();  //使用udp协议的socket
                String cmd="select NodeName,SensorName from nodesensorview;";//NodeMacAddress
                byte[] sendData = cmd.getBytes(Charset.forName("UTF-8"));  //编码成二进制
                DatagramPacket sdp = new DatagramPacket(sendData,
                        sendData.length,
                        InetAddress.getByName(remoteHostAddress),
                        remoteHostPort);//UDP发送格式（创建一个用于发送的DatagramPacket对象，指定了IP地址和端口--这就决定了该数据报的目的地。）

                ds.send(sdp);//以上发送结束

                byte[] receiveData = new byte[4096];//接收中间件的反馈
                DatagramPacket rdp = new DatagramPacket(receiveData,
                        receiveData.length);//指定接收到的数据放入receiveData数组中
                ds.setSoTimeout(3 * 1000);
                ds.receive(rdp);
                /*for(int i=0;i<20;i++){
                    System.out.println(rdp.getData()[i]);
                }*/

                String result = new String(rdp.getData(), rdp.getOffset(),
                        rdp.getLength(),"utf-8");
                System.out.println(result);
                if (!result.startsWith("ERROR")) {
                    String[] arrayString = result.split("\n");
                    for (int i = 0; i < arrayString.length; i++) {
                        String[] onelineSet = arrayString[i].split("\t");
                        if (onelineSet.length > 1) {
                            sensorListInfo.put(onelineSet[0], onelineSet[1]);
                            nodeNameList.add(onelineSet[0]);

                        }
                    }
                }
            }
        } catch (SocketException e) {
            e.printStackTrace();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public Map<String,String> getSensorListInfo(){
        return sensorListInfo;
    }

    public static void main(String[] args) {
       GetSensorInfoThread get=new GetSensorInfoThread();
        get.run();
    }
}