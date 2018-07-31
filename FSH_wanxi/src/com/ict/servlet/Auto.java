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

/**自动的初始化
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-19
 * Time: 下午3:37
 * 查询是否自动
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "Auto")
public class Auto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String dename= URLDecoder.decode(name, "utf-8");
        String getData="Get "+dename+"/State/query?NodeName='"+dename+"'";

        System.out.println("******************操作语句******************");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        SendAndReceive send=new SendAndReceive(getData);
        send.run();

        Map<String, String> sensorState=send.getSensorState();
        String mac=sensorState.get("NodeMac");   //节点mac
        String type=sensorState.get("SensorName"); //获得结点名字

        response.getOutputStream().println("{ name : \""+name+"\",mac : \""+mac+"\",type : \""+type+"\"}");
    }
}
