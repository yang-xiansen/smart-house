package com.ict.servlet;

import com.ict.java_bean.SendAndReceive;
import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-24
 * Time: 下午2:58
 * //查询传感器实时数据（用于报警）
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetSRSAlert")
public class GetSRSAlert extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String dename= URLDecoder.decode(name, "utf-8");

        //得到设备的MAC TYPE
        /*---1---*/
        String getData="Get "+dename+"/State/query?NodeName='"+dename+"'";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        SendAndReceive send=new SendAndReceive(getData);
        send.run();

        Map<String, String> sensorState=send.getSensorState();
        String type=sensorState.get("SensorName");
        String mac=sensorState.get("NodeMac");

        //开启设备
        /*---2---*/
        String turnSourceOn="Mac "+mac+" 4 CmdNrm "+type+"_SampleStart\n";
        System.out.println("******************操作语句******************");
        System.out.println(turnSourceOn);
        System.out.println("******************语句结束******************");
        SendOnly send02=new SendOnly(turnSourceOn);
        send02.run();

        //得实时数据
        /*---3---*/
        String getRealTime="Get "+dename+"/RealTimeData/query?SensorName="+type;

        System.out.println("******************操作语句******************");
        System.out.println(getRealTime);
        System.out.println("******************语句结束******************");

        SendOnly send1=new SendOnly(getRealTime);
        send1.run();
        String realTimeData=send1.getSensorInfo();

        //-----------------------------接服务器数据上报 处理

        //得设备状态
        /*---4---*/
        String getNodeState="Get "+dename+"/State/query?SensorName='"+type+"'";

        System.out.println("******************操作语句******************");
        System.out.println(getNodeState);
        System.out.println("******************语句结束******************");

        SendAndReceive send2=new SendAndReceive(getNodeState);
        send2.run();
        Map<String, String> State=send2.getSensorState();
        int state=-1;
        if(State.get("State")!=null){
            state= Integer.parseInt(State.get("State"));
        }

        String[] data=realTimeData.split("\n");
        if(data[1]!=null){
            realTimeData=data[1];
        }else {
            realTimeData="empty";
        }

        System.out.println(data[0]);

        response.getOutputStream().println("{ name : \""+name+"\",realTimeData : \""+realTimeData+"\",type : \""+type+"\",mac : \""+mac+"\",state:"+state+"}");
        //-----------------------------接服务器数据上报 处理
        //界面显示相关信息
    }
}
