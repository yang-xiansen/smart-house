package com.ict.smarthouse;

import java.io.IOException;
import java.net.DatagramSocket;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.HashMap;

import com.ict.util.Util;

public class AliveThread extends Thread{
    //private Handler serHandler;
    private DatagramSocket ds;
    private final String logtag = "AliveThread";
    public boolean aliveIsRun=true;
    public String nodewatched = "";
    private HashMap<String, String> nodetype;
    private int i=0;
    public AliveThread( DatagramSocket ds,HashMap<String, String> nodetype){
        //this.serHandler=serHandler;
        this.ds = ds;
        this.nodetype=nodetype;
    }

    @Override
    public void run(){
        while(aliveIsRun){
            if(i==0){   //获取节点信息命令
                String cmd = "Get Info/NodeSensorView/*/Query?nodename!=''";
                System.out.println(logtag+""+cmd);
                //Log.i(logtag,""+cmd);
                NetSend netsend = new NetSend(ds,cmd);
                netsend.start();
            }
            if(i==1){   //获取RFID信息命令
                String cmd = "Get Info/RFIDInfo/*/Query?CardID!=''";
                System.out.println(logtag+""+cmd);
                //Log.v(logtag,""+cmd);
                NetSend netsend = new NetSend(ds,cmd);
                netsend.start();
            }
            if(i==2){   //订阅心跳包
                if(nodewatched!="") {
                    String cmd = "Event Alive"+nodewatched;
                    System.out.println(logtag+""+cmd);
                    //Log.v(logtag,""+cmd);
                    NetSend netsend = new NetSend(ds,cmd);
                    netsend.start();
                }
            }
            getRealTimeCmd("Humidity");
            getRealTimeCmd("Temperature");
            getRealTimeCmd("Light");
            getRealTimeCmd("Ammeter");
            getRealTimeCmd("Vibration");
            getRealTimeCmd("Gas");
            getRealTimeCmd("Noise");
            getRealTimeCmd("Press");
            getRealTimeCmd("Fire");
            getNodeStateCmd("Switch");
            getNodeStateCmd("IRControl");
            i++;
            if(i==5)
                i=0;
            try{
                Thread.sleep(5000);
            }catch(InterruptedException e){

            }
        }

    }
    private void getRealTimeCmd(String type) {
        String keys=Util.getKey(nodetype,type);
        if(keys!=null) {
            String[] arrayString = keys.split(" ");
            for(i=0;i<arrayString.length;i++) {
                String cmd = "Get "+arrayString[i]+"/RealTimeData/query?SensorName="+type;
                System.out.println(""+cmd);
                //Log.v(logtag,""+cmd);
                NetSend netsend = new NetSend(ds,cmd);
                netsend.start();
            }
        }
    }

    private void getNodeStateCmd(String type) {
        String keys=Util.getKey(nodetype,type);
        if(keys!=null) {
            String[] arrayString = keys.split(" ");
            for(i=0;i<arrayString.length;i++) {
                String cmd = "Get "+arrayString[i]+"/State/query?SensorName='"+type+"'";
                System.out.println(logtag+""+cmd);
                //Log.v(logtag,""+cmd);
                NetSend netsend = new NetSend(ds,cmd);
                netsend.start();
            }
        }
    }


    public static void main(String[] args) {


    }
}
