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

/**窗帘的自动
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-21
 * Time: 上午9:50
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetCurtainAuto")
public class SetCurtainAuto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac = request.getParameter("mac");
        String type = request.getParameter("type");
        //需先开启光照传感器
        //查找光照节点的MAC
        /*---1---*/
        String getInfraredMac="Get 光照/State/query?NodeName='光照'";
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getInfraredMac);
        System.out.println("******************语句结束******************");
        SendAndReceive send=new SendAndReceive(getInfraredMac);
        send.run();
        Map<String, String> sensorState=send.getSensorState();
        String sourceMac=sensorState.get("NodeMac");

        //开启光照节点
        /*---2---*/
        String turnSourceOn="Mac "+sourceMac+" 4 CmdNrm Light_SampleStart\n";
        System.out.println("******************操作语句******************");
        System.out.println(turnSourceOn);
        System.out.println("******************语句结束******************");
        SendOnly send02=new SendOnly(turnSourceOn);
        send02.run();

        //下面功能为光照小于20触发执行！！
        /*---1---*/
        String AgentPut11="AgentPut /DataThreshTrigger/SendPacket  IOT/3.0\n" +
                "SN:1\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +//每隔5S查一次
                "Hold-Times:1\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:<\n" +
                "Compared-Number:20\n" +//光照小于20开
                "\n" +
                "Mac "+mac+" 0 CmdNrm Switch_On\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut11);
        System.out.println("******************语句结束******************");

        SendOnly send11=new SendOnly(AgentPut11);
        send11.run();
        /*---2---*/
        /*String AgentPut12="AgentPut /DataThreshTrigger/SendPacket  IOT/3.6\n" +
                "SN:2\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +
                "Hold-Times:2\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:<\n" +
                "Compared-Number:20\n" +//光照小于20执行下面
                "\n" +
                "AgentPut /DataThreshTrigger/SendPacket  IOT/3.6\n" +
                "SN:3\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +
                "Hold-Times:1\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:>\n" +
                "Compared-Number:50\n" +//光照大于50停
                "\n" +
                "Mac "+mac+" 3 CmdNrm Switch_Suspend\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut12);
        System.out.println("******************语句结束******************");

        SendOnly send12=new SendOnly(AgentPut12);
        send12.run();*/
        /*---3---*/
        /*String AgentPut13="AgentPut /DataThreshTrigger/SendPacket  IOT/3.6\n" +
                "SN:4\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +//每分钟判断一次
                "Hold-Times:1\n" +//连续读2次
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:<\n" +
                "Compared-Number:20\n" +//光照小于20执行下面
                "\n" +
                "AgentDelete /DataThreshTrigger/SendPacket  IOT/3.6\n" +
                "SN:5\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +
                "Hold-Times:1\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:<\n" +
                "Compared-Number:50\n" +//删除光照小于50停
                "\n" +
                "Mac "+mac+" 3 CmdNrm Switch_Suspend\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut13);
        System.out.println("******************语句结束******************");

        SendOnly send13=new SendOnly(AgentPut13);
        send13.run();*/


        //下面功能为光照大于100触发执行！！
        /*---1---*/
        String AgentPut21="AgentPut /DataThreshTrigger/SendPacket  IOT/3.0\n" +
                "SN:6\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +
                "Hold-Times:1\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:>\n" +
                "Compared-Number:100\n" +//光照大于100关
                "\n" +
                "Mac "+mac+" 1 CmdNrm Switch_Off\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut21);
        System.out.println("******************语句结束******************");

        SendOnly send21=new SendOnly(AgentPut21);
        send21.run();
        /*---2---*/
        /*String AgentPut22="AgentPut /DataThreshTrigger/SendPacket  IOT/3.6\n" +
                "SN:7\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +
                "Hold-Times:1\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:>\n" +
                "Compared-Number:100\n" +//光照大于100执行下面
                "\n" +
                "AgentPut /DataThreshTrigger/SendPacket  IOT/3.6\n" +
                "SN:8\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +
                "Hold-Times:1\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:<\n" +
                "Compared-Number:50\n" +//光照小于50停
                "\n" +
                "Mac "+mac+" 3 CmdNrm Switch_Suspend\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut22);
        System.out.println("******************语句结束******************");

        SendOnly send22=new SendOnly(AgentPut22);
        send22.run();*/
        /*---3---*/
        /*String AgentPut23="AgentPut /DataThreshTrigger/SendPacket  IOT/3.6\n" +
                "SN:9\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +
                "Hold-Times:1\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:>\n" +
                "Compared-Number:100\n" +//光照大于100执行下面
                "\n" +
                "AgentDelete /DataThreshTrigger/SendPacket  IOT/3.6\n" +
                "SN:10\n" +
                "Host:Agent\n" +
                "TimeOut-Seconds:5\n" +
                "Hold-Times:1\n" +
                "Source-NodeName:光照\n" +
                "Source-SensorName:Light\n" +
                "Dest-Mac:"+mac+"\n" +
                "Dest-SensorName:"+type+"\n" +
                "Comparison-Operator:>\n" +
                "Compared-Number:50\n" +//删除光照大于50停
                "\n" +
                "Mac "+mac+" 3 CmdNrm Switch_Suspend\n";
        System.out.println("******************操作语句******************");
        System.out.println(AgentPut23);
        System.out.println("******************语句结束******************");

        SendOnly send23=new SendOnly(AgentPut23);
        send23.run();*/

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
