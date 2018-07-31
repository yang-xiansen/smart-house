package com.ict.java_bean;

import com.ict.util.Config;

import java.io.IOException;
import java.net.*;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-16
 * Time: 下午2:02
 * 与SendAndReceive这个java bean功能类似
 * 但主要负责接收服务器传来多条数据 比如查询定时信息后的服务器数据返回
 * num为消息个数+1（原因为while多循环查询一次）
 * To change this template use File | Settings | File Templates.
 */
public class ResLongMsg extends Thread{
    private String cmd;
    private static InetAddress ia;
    public Map<String ,String> timeInfo=new HashMap<String, String>();  //保存查询时间信息
    int num=0;//分几条
    String msg="";//全局变量，代表着服务器返回所有数据的集合（所有的整合）
    String longStr="";//测试
    public ResLongMsg(String cmd){
        this.cmd=cmd;
    }

    @Override
    public void run(){
        try{
            DatagramSocket ds = new DatagramSocket();
            ds.setSoTimeout(1 * 5000);//0.5s


            //客户端发送信息
            if(ds!=null){
                ia=InetAddress.getByName(Config.ServerIP); //获得serverip
                byte[] sendData = cmd.getBytes(Charset.forName("UTF-8"));
                DatagramPacket sdp = new DatagramPacket(sendData,
                        sendData.length,
                        ia,
                        Integer.parseInt(Config.ServerPort));
                ds.send(sdp);
                String result=null;


                //接收服务器返回的信息
            while (true){
                num+=1;
                byte[] receiveData = new byte[4096];
                DatagramPacket rdp = new DatagramPacket(receiveData,
                        receiveData.length);
                ds.receive(rdp);
                result = new String(rdp.getData(), rdp.getOffset(),
                        rdp.getLength(),"utf-8");
                System.out.println("-----------------------------"+num+"----------------------------------");
                System.out.println(result);
                longStr+=result;
                String txt="";
                String state="";
                int sign=0;//标志是否有日期
                if(!result.startsWith("ERROR")){
                    String[] oneBlockSet =result.split("\n\n");
                    if(oneBlockSet.length>1){
                        String[] oneGroupSet = oneBlockSet[0].split("\n");
                        if(oneGroupSet.length > 1){
                            for(int j=0;j<oneGroupSet.length;j++){
                                String[] oneLineSet=oneGroupSet[j].split(":");
                                if(oneLineSet.length>1){
                                    timeInfo.put(oneLineSet[0],oneLineSet[1]);
                                    if(oneLineSet[0].equals("Trigger-Date")){
                                        sign=1;
                                    }
                                }
                            }
                        }
                    }

                    txt=oneBlockSet[oneBlockSet.length-1];
                    if(txt.indexOf("Switch_On")>0){
                        state="ON";
                    }else if(txt.indexOf("Switch_Off")>0){
                        state="OFF";
                    }
                }
                msg+="NO.:"+num+"\n"+
                        "MAC:"+timeInfo.get("Dest-Mac")+"\n";
                if(sign==1){
                    msg+="DATE:"+timeInfo.get("Trigger-Date")+"\n";
                }else if(sign==0){
                    msg+="DATE:null\n";
                }
                msg+="TIME:"+timeInfo.get("Trigger-Time")+"\n"+
                        "STATE:"+state+"\n"+
                        "MSG:"+txt+"\n\n";
            }

            }
        /*}catch(UnknownHostException e){
            e.printStackTrace();
        }catch (IOException e){
            e.printStackTrace();*/
        }catch (Exception e){
            /*e.printStackTrace();*/
        }
    }
    public Map<String,String> getTimeInfo(){
        return timeInfo;
    }
    public int getNum(){
        return num;
    }
    public String getMsg(){
        return msg;
    }
    public static void main(String[] args) {
        ResLongMsg send=new ResLongMsg("AgentGet /DateTimeTrigger/SendPacket  IOT/3.6\n" +
                "SN:1\n" +
                "Host:Agent\n" +
                "Dest-Mac:1302185705677019795\n" +
                "\n");
        send.run();
        int Num=send.getNum();
        System.out.println("#######################################");
        System.out.println("zheshi yi shuzi "+Num);
        System.out.println(send.getMsg());
        System.out.println("#######################################");
        System.out.println(send.longStr);
    }
}
