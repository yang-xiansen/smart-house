package com.ict.smarthouse;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
//import java.net.SocketException;
import java.nio.charset.Charset;
import java.net.UnknownHostException;
import java.io.IOException;

import com.ict.util.Config;
/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-9-27
 * Time: 上午11:00
 * To change this template use File | Settings | File Templates.
 */
public class NetSend extends Thread{
    private DatagramSocket ds;
    private final String logtag = "netsend";
    private String cmd;
    private static InetAddress ia;

    public NetSend(DatagramSocket ds,String cmd){
        this.ds=ds;
        this.cmd=cmd;
    }

    @Override
    public void run(){
        try{
            if(ds!=null){
                ia=InetAddress.getByName(Config.ServerIP);
                byte[] sendData = cmd.getBytes(Charset.forName("UTF-8"));
                DatagramPacket sdp = new DatagramPacket(sendData,
                        sendData.length,
                        ia,
                        Integer.parseInt(Config.ServerPort));
                //Log.v(logtag,cmd);
                ds.send(sdp);
            }
        }catch(UnknownHostException e){
            e.printStackTrace();
        }catch (IOException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
