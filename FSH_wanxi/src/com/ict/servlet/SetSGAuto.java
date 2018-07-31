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

/**声光报警的自动
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-30
 * Time: 下午3:34
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetSGAuto")
public class SetSGAuto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac = request.getParameter("mac");
        String type = request.getParameter("type");
        //需先开启热释电

        //然后查询热释电的MAC
        /*---1---*/
        String getMac01="Get 热释电/State/query?NodeName='热释电'";
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getMac01);
        System.out.println("******************语句结束******************");
        SendAndReceive send01=new SendAndReceive(getMac01);
        send01.run();
        Map<String, String> sensorState=send01.getSensorState();
        String sourceMac=sensorState.get("NodeMac");
        String sourceType=sensorState.get("SensorName");

        //热释电事件触发!
        /*---2有人开---*/
        String AgentPut1="AgentPut /EventTrigger/SendPacket  IOT/3.0\n" +
                "SN:3\n" +
                "Host:Agent\n" +
                "Hold-MilliSeconds:0\n" +//1s
                "Source-Mac:" +sourceMac+"\n" +
                "Source-SensorName:"+sourceType+"\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:==\n" +
                "Compared-Number:1\n" +
                "\n" +
                "Mac "+mac+" 0 CmdNrm Switch_On\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut1);
        System.out.println("******************语句结束******************");

        SendOnly send1=new SendOnly(AgentPut1);
        send1.run();

        //需先开启对射

        //然后查询对射的MAC
        /*---1---*/
        String getMac02="Get 红外对射/State/query?NodeName='红外对射'";
        System.out.println("******************操作语句******************");
        System.out.println(getMac02);
        System.out.println("******************语句结束******************");
        SendAndReceive send02=new SendAndReceive(getMac02);
        send02.run();
        Map<String, String> sensorState2=send02.getSensorState();
        String sourceMac2=sensorState2.get("NodeMac");
        String sourceType2=sensorState2.get("SensorName");

        /*---2开---*/
        String AgentPut2="AgentPut /EventTrigger/SendPacket  IOT/3.0\n" +
                "SN:3\n" +
                "Host:Agent\n" +
                "Hold-MilliSeconds:0\n" +//1s
                "Source-Mac:" +sourceMac2+"\n" +
                "Source-SensorName:"+sourceType2+"\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:==\n" +
                "Compared-Number:0\n" +
                "\n" +
                "Mac "+mac+" 0 CmdNrm Switch_On\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut2);
        System.out.println("******************语句结束******************");

        SendOnly send2=new SendOnly(AgentPut2);
        send2.run();

        //需先开启磁敏

        //然后查询磁敏的MAC
        /*---1---*/
        String getMac03="Get 磁敏/State/query?NodeName='磁敏'";
        System.out.println("******************操作语句******************");
        System.out.println(getMac03);
        System.out.println("******************语句结束******************");
        SendAndReceive send03=new SendAndReceive(getMac03);
        send03.run();
        Map<String, String> sensorState3=send03.getSensorState();
        String sourceMac3=sensorState3.get("NodeMac");
        String sourceType3=sensorState3.get("SensorName");

        /*---2开---*/
        String AgentPut3="AgentPut /EventTrigger/SendPacket  IOT/3.0\n" +
                "SN:3\n" +
                "Host:Agent\n" +
                "Hold-MilliSeconds:0\n" +//1s
                "Source-Mac:" +sourceMac3+"\n" +
                "Source-SensorName:"+sourceType3+"\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:==\n" +
                "Compared-Number:1\n" +
                "\n" +
                "Mac "+mac+" 0 CmdNrm Switch_On\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut3);
        System.out.println("******************语句结束******************");

        SendOnly send3=new SendOnly(AgentPut3);
        send3.run();

        //需先开启烟雾

        //然后查询烟雾的MAC
        /*---1---*/
        String getMac04="Get 烟雾/State/query?NodeName='烟雾'";
        System.out.println("******************操作语句******************");
        System.out.println(getMac04);
        System.out.println("******************语句结束******************");
        SendAndReceive send04=new SendAndReceive(getMac04);
        send04.run();
        Map<String, String> sensorState4=send04.getSensorState();
        String sourceMac4=sensorState4.get("NodeMac");
        String sourceType4=sensorState4.get("SensorName");

        /*---2开---*/
        String AgentPut4="AgentPut /EventTrigger/SendPacket  IOT/3.0\n" +
                "SN:3\n" +
                "Host:Agent\n" +
                "Hold-MilliSeconds:0\n" +//1s
                "Source-Mac:" +sourceMac4+"\n" +
                "Source-SensorName:"+sourceType4+"\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:<\n" +
                "Compared-Number:532\n" +
                "\n" +
                "Mac "+mac+" 0 CmdNrm Switch_On\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut4);
        System.out.println("******************语句结束******************");

        SendOnly send4=new SendOnly(AgentPut4);
        send4.run();

        //需先开启火焰

        //然后查询火焰的MAC
        /*---1---*/
        String getMac05="Get 火焰/State/query?NodeName='火焰'";
        System.out.println("******************操作语句******************");
        System.out.println(getMac05);
        System.out.println("******************语句结束******************");
        SendAndReceive send05=new SendAndReceive(getMac05);
        send05.run();
        Map<String, String> sensorState5=send05.getSensorState();
        String sourceMac5=sensorState5.get("NodeMac");
        String sourceType5=sensorState5.get("SensorName");

        /*---2开---*/
        String AgentPut5="AgentPut /EventTrigger/SendPacket  IOT/3.0\n" +
                "SN:3\n" +
                "Host:Agent\n" +
                "Hold-MilliSeconds:0\n" +//1s
                "Source-Mac:" +sourceMac5+"\n" +
                "Source-SensorName:"+sourceType5+"\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:<\n" +
                "Compared-Number:976\n" +
                "\n" +
                "Mac "+mac+" 0 CmdNrm Switch_On\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut5);
        System.out.println("******************语句结束******************");

        SendOnly send5=new SendOnly(AgentPut5);
        send5.run();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
