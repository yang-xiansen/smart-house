package com.ict.servlet;

import com.ict.java_bean.SendAndReceive;
import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

/**电风扇的自动
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-20
 * Time: 下午5:35
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetFanAuto")
public class SetFanAuto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac = request.getParameter("mac");
        String type = request.getParameter("type");
        //需先开启烟雾传感器
        //查找烟雾节点的MAC
        /*---1---*/
        String getInfraredMac="Get 烟雾/State/query?NodeName='烟雾'";
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getInfraredMac);
        System.out.println("******************语句结束******************");
        SendAndReceive send=new SendAndReceive(getInfraredMac);
        send.run();
        Map<String, String> sensorState=send.getSensorState();
        String sourceMac=sensorState.get("NodeMac");

        //开启烟雾节点
        /*---2---*/
        String turnSourceOn="Mac "+sourceMac+" 4 CmdNrm Smoke_SampleStart\n";
        SendOnly send02=new SendOnly(turnSourceOn);
        send02.run();

        //下面功能为风扇
        String AgentPut1="AgentPut /DataThreshTrigger/SendPacket  IOT/3.0\n" +
                "SN:9\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:60\n" +
                "Hold-Times:2\n" +
                "Source-NodeName:烟雾\n" +
                "Source-SensorName:Smoke\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:<\n" +
                "Compared-Number:300\n" +//烟雾小于300开
                "\n" +
                "Mac "+mac+" 0 CmdNrm Switch_On\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut1);
        System.out.println("******************语句结束******************");

        SendOnly send1=new SendOnly(AgentPut1);
        send1.run();

        String AgentPut2="AgentPut /DataThreshTrigger/SendPacket  IOT/3.0\n" +
                "SN:8\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:60\n" +
                "Hold-Times:2\n" +
                "Source-NodeName:烟雾\n" +
                "Source-SensorName:Smoke\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:>\n" +
                "Compared-Number:400\n" +//烟雾大于400关
                "\n" +
                "Mac "+mac+" 1 CmdNrm Switch_Off\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut2);
        System.out.println("******************语句结束******************");

        SendOnly send2=new SendOnly(AgentPut2);
        send2.run();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
