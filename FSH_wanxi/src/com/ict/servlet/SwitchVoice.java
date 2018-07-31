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
 * Date: 13-11-18
 * Time: 下午3:20
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SwitchVoice")
public class SwitchVoice extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String dename= URLDecoder.decode(name, "utf-8");
        int state = Integer.parseInt(request.getParameter("state"));
        String getData="Get "+dename+"/State/query?NodeName='"+dename+"'";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        SendAndReceive send=new SendAndReceive(getData);
        send.run();

        Map<String, String> sensorState=send.getSensorState();
        String mac=sensorState.get("NodeMac");

        String conState="Mac "+mac;
        if(state==0){
            conState+=" 1 CmdNrm Switch_Off";
        }else if(state==1){
            conState+=" 0 CmdNrm Switch_On";
        }
        System.out.println("******************操作语句******************");
        System.out.println(conState);
        System.out.println("******************语句结束******************");

        SendOnly send1=new SendOnly(conState);
        send1.run();

    }
}
