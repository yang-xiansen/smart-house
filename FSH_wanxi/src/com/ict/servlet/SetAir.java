package com.ict.servlet;

import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-29
 * Time: 下午3:50
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetAir")
public class SetAir extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac = request.getParameter("mac");
        int num=Integer.parseInt(request.getParameter("num"));
        String conState="Mac "+mac+" 1 CmdNrm IRControl_Emit ";
        if(num==1){
            conState+="AirCond_Power";
        }else if(num==2){
            conState+="AirCond_TemperatureAdjust";
        }else if(num==3){
            conState+="AirCond_Timer";
        }else if(num==4){
            conState+="AirCond_Swing";
        }else if(num==5){
            conState+="AirCond_Hot";
        }else if(num==6){
            conState+="AirCond_SmartHotDry";
        }
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(conState);
        System.out.println("******************语句结束******************");

        SendOnly send=new SendOnly(conState);
        send.run();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
