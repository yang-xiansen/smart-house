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
 * 智能电表
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-25
 * Time: 上午10:16
 * //得到名字后将开启设备
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetName")
public class GetName extends HttpServlet {
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
        response.getOutputStream().println("{ name : \""+name+"\",type : \""+type+"\"}");
    }
}
