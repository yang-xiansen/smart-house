package com.ict.servlet;

import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;


/**
 * 设备开启时间
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-25
 * Time: 下午2:37
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetRealTime")
public class GetRealTime extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String dename= URLDecoder.decode(name, "utf-8");
        String type=request.getParameter("type");
        //得实时数据
        /*---3---*/
        String getRealTime="Get "+dename+"/RealTimeData/query?SensorName="+type;

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getRealTime);
        System.out.println("******************语句结束******************");

        SendOnly send1=new SendOnly(getRealTime);
        send1.run();
        String realTimeData=send1.getSensorInfo();
        String[] data=realTimeData.split("\n");
        if(data[1]!=null){
            realTimeData=data[1];
        }else {
            realTimeData="empty";
        }
        response.getOutputStream().println("{ name : \""+name+"\",realTimeData : \""+realTimeData+"\"}");

    }
}
