package com.ict.smarthouse;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;
import java.util.HashMap;

import com.ict.util.Config;
import com.ict.util.Util;

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-9-27
 * Time: 上午11:21
 * To change this template use File | Settings | File Templates.
 */
public class RecThread extends Thread implements Runnable{
    private DatagramSocket ds;
    private byte[] receiveData = new byte[4096];
    private String logtag = "RecThread";
    private HashMap<String, String> sensorinfo;
    private HashMap<String, String> rfidinfo,nodetype,nodestate;
//    private Handler serHandler;
    public boolean recIsRun=true;
    public RecThread( DatagramSocket ds,
                     HashMap<String, String> sensorinfo, HashMap<String, String> rfidinfo,
                     HashMap<String, String> nodetype, HashMap<String, String> nodestate){
        super();
        this.ds=ds;
        this.sensorinfo=sensorinfo;
        this.rfidinfo=rfidinfo;
  //      this.serHandler=serHandler;
        this.nodetype=nodetype;
        this.nodestate=nodestate;
    }

    @Override
    public void run(){
        while(recIsRun)
        {
            DatagramPacket rdp = new DatagramPacket(receiveData,
                    receiveData.length);
            try{
                ds.receive(rdp);
            }catch(SocketException e){

            }catch(IOException e){

            }

            String result = new String(rdp.getData(), rdp.getOffset(),
                    rdp.getLength());
            System.out.println(logtag+""+result);
            //Log.v(logtag,""+result);
            //接收节点信息存储在nodesensorlist中
            if(result.startsWith("EVENT")){			//开关状态改变


                if(Util.include(result,"SENSORDATA SWITCH")){
                    String[] onelineSet = result.split(" ");
                    if(onelineSet[5].startsWith("Switch_On")) {
                        nodestate.put(onelineSet[2], "0");
                    }else if(onelineSet[5].startsWith("Switch_Off")) {
                        nodestate.put(onelineSet[2], "1");
                    }else {
                        nodestate.put(onelineSet[2], "2");
                    }
                    //Message msg = new Message();
                    //msg.what=Config.MSG_SWITCHSTATE;
                    //msg.obj=Util.getKey(sensorinfo,onelineSet[2])+" "+onelineSet[5];
                    //serHandler.sendMessage(msg);
                    //Log.v(logtag,"switch state"+
                    System.out.println(logtag+"switch state"+
                            Util.getKey(sensorinfo,
                                    onelineSet[2])+" "+onelineSet[5]);
                }else if(Util.include(result,"SENSORDATA RFID")){//RFID上报
                    String[] onelineSet = result.split(" ");
                    //Message msg = new Message();
                    //msg.what = Config.MSG_RFIDSTATE;
                    //msg.obj = rfidinfo.get(onelineSet[5]);
                    //serHandler.sendMessage(msg);
                }else{										//报警事件
                    String[] onelineSet = result.split(" ");
                    //Message msg = new Message();
                    //msg.what = Config.MSG_ALERT;
                   // msg.obj= Util.getKey(sensorinfo, onelineSet[2]);
                   // serHandler.sendMessage(msg);
                }

            }else if(result.startsWith("INFO: Begin to Watch")){	//订阅成功
                String[] onelineSet = result.split(" ");
                //Message msg = new Message();
                //msg.what = Config.MSG_WATCHOK;
                //msg.obj= Util.getKey(sensorinfo,onelineSet[4]);
                //serHandler.sendMessage(msg);
            }else if(result.startsWith("INFO: Stop Watching")){		//取消订阅成功
                String[] onelineSet = result.split(" ");
                //Message msg = new Message();
               // msg.what = Config.MSG_DISWATCHOK;
                //msg.obj= Util.getKey(sensorinfo,onelineSet[3]);
               // serHandler.sendMessage(msg);
            }else if(result.startsWith("DATA:Get")) {
                if(result.startsWith("DATA:Get Info/Node")){ //Get Sensor info
                    System.out.println(logtag+""+result);
                    //Log.i(logtag,""+result);
                    String[] arrayString = result.split("\n");
                    for (int i=1; i<arrayString.length; i++){
                        String[] onelineSet = arrayString[i].split("\t");
                        if(onelineSet.length>1){
                            if(onelineSet[5].equals("28")){
                                //Message msg = new Message();
                                //msg.what=Config.MSG_WATCHSWITCH;
                                //msg.obj=onelineSet[2];
                                //serHandler.sendMessage(msg);
                            }else if(onelineSet[5].equals("43")){
                                //Message msg = new Message();
                               // msg.what=Config.MSG_WATCHRFID;
                               // msg.obj=onelineSet[2];
                               // serHandler.sendMessage(msg);
                            }else if(onelineSet[5].equals("39")) {
                               // Message msg = new Message();
                               // msg.what=Config.MSG_WATCHIR;
                               // msg.obj=onelineSet[2];
                               // serHandler.sendMessage(msg);
                            }else if(onelineSet[5].equals("44")) {
                              //  Message msg = new Message();
                              //  msg.what=Config.MSG_WATCHLED;
                              //  msg.obj=onelineSet[2];
                              //  serHandler.sendMessage(msg);
                            }
                            sensorinfo.put(onelineSet[0],onelineSet[2]);
                            nodetype.put(onelineSet[0], onelineSet[4]);
                            //Log.e(logtag,"nodetype:"+onelineSet[0]+" "+onelineSet[4]);
                        }
                    }
                //    Message msg = new Message();
                //    msg.what=Config.MSG_SENSORINFO;
                //    serHandler.sendMessage(msg);
                }else if(result.startsWith("DATA:Get Info/RFID")){ //获取RFID列表
                    String[] arrayString = result.split("\n");
                    for (int i=1; i<arrayString.length; i++){
                        String[] onelineSet = arrayString[i].split("\t");
                        if(onelineSet.length>1){
                            rfidinfo.put(onelineSet[0],onelineSet[1]);
                        }
                    }

                }else {
                    getRealTime(result,"Humidy");
                    getRealTime(result,"Temperature");
                    getRealTime(result,"Light");
                    getRealTime(result,"Ammeter");
                    getRealTime(result,"Vibration");
                    getRealTime(result,"Gas");
                    getRealTime(result,"Noise");
                    getRealTime(result,"Press");
                    getRealTime(result,"Fire");
                    getNodeState(result,"Switch");
                    getNodeState(result, "IRControl");
                }
            }

        }
    }

    private void getRealTime(String result,String type) {
        String keys=Util.getKey(nodetype,type);
        if(keys!=null) {
            String[] arrayString = keys.split(" ");
            for(int i=0;i<arrayString.length;i++) {
                if(result.startsWith("DATA:Get "+arrayString[i]+
                        "/RealTimeData/query?SensorName="+type)) {
                    String[] arrayString1 = result.split("\n");
                    if(arrayString1.length>1){
                        nodestate.put(arrayString[i], arrayString1[1]);
                        System.out.println("nodestate:"+arrayString[i]+" "+arrayString1[1]);
                     //   Log.d(logtag,"nodestate:"+arrayString[i]+" "+arrayString1[1]);
                    }
                }
            }
        }
    }
    private void getNodeState(String result,String type) {
        String keys=Util.getKey(nodetype,type);
        if(keys!=null) {
            String[] arrayString = keys.split(" ");
            for(int i=0;i<arrayString.length;i++) {
                if(result.startsWith("DATA:Get "+arrayString[i]+
                        "/State/query?SensorName='"+type+"'")) {
                    String[] arrayString1 = result.split("\n");
                    if((arrayString1[7]!=null)&&(arrayString1[7]!="")){
                        String[] arrayString2=arrayString1[7].split(":");
                        if(arrayString2.length>1){
                            nodestate.put(arrayString[i], arrayString2[1]);
                            System.out.println("nodestate:"+arrayString[i]+" "+arrayString2[1]);
                        //    Log.d(logtag,"nodestate:"+arrayString[i]+" "+arrayString2[1]);
                        }
                    }
                }
            }
        }
    }
}
