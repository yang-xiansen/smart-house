package com.ict.servlet;

import com.ict.java_bean.GetSensorInfoThread;
import com.ict.java_bean.SendAndReceive;

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
 * Date: 13-10-11
 * Time: 下午3:27
 * 此servlet负责查询节点的类型并根据类型进行初始化
 * 注释部分为原java bean 使用部分　现已改进不再使用
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "Type")
public class Type extends HttpServlet {
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
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println("******************语句结束******************");

        SendAndReceive send=new SendAndReceive(getData);
        send.run();

        Map<String, String> sensorState=send.getSensorState();
        String type=sensorState.get("SensorName");

        int state=-1;
        String mac=sensorState.get("NodeMac");
        if(type!=null){
            if(sensorState.get("State")!=null){
                state= Integer.parseInt(sensorState.get("State"));
            }
        }
        response.getOutputStream().println("{ name : \"" + name + "\",type : \"" + type + "\",mac : \"" + mac + "\",state:" + state + "}");
    }
}
