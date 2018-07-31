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

/**电视机开关的自动
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-21
 * Time: 下午1:09
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetTVAuto")
public class SetTVAuto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac = request.getParameter("mac");
        String type = request.getParameter("type");
        //需先开启热释电

        //然后查询热释电的MAC
        /*---1---*/
        String getInfraredMac="Get 热释电/State/query?NodeName='热释电'";
        System.out.println("******************操作语句******************");
        System.out.println(getInfraredMac);
        System.out.println("******************语句结束******************");
        SendAndReceive send=new SendAndReceive(getInfraredMac);
        send.run();
        Map<String, String> sensorState=send.getSensorState();
        String sourceMac=sensorState.get("NodeMac");
        String sourceType=sensorState.get("SensorName");
        //热释电事件触发!
        /*---2有人开---*/
        String AgentPut1="AgentPut /EventTrigger/SendPacket  IOT/3.0\n" +
                "SN:3\n" +
                "Host:Agent\n" +
                "Hold-MilliSeconds:5000\n" +//等待讨论!5S
                "Source-Mac:" +sourceMac+"\n" +
                "Source-SensorName:"+sourceType+"\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:==\n" +
                "Compared-Number:1\n" +//热释电讨论！！！！！！！！！！！！！！！！！！！！！！！！！！
                "\n" +
                "Mac "+mac+" 0 CmdNrm Switch_On\n";
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(AgentPut1);
        System.out.println("******************语句结束******************");

        SendOnly send1=new SendOnly(AgentPut1);
        send1.run();

        /*---3无人关---*/
        String AgentPut2="AgentPut /EventTrigger/SendPacket  IOT/3.0\n" +
                "SN:3\n" +
                "Host:Agent\n" +
                "Hold-MilliSeconds:300000\n" +//讨论!等待5分钟关
                "Source-Mac:" +sourceMac+"\n" +
                "Source-SensorName:"+sourceType+"\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:==\n" +
                "Compared-Number:0\n" +//热释电讨论！！！！！！！！！！！！！！！！！！！！！！！！！！
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
