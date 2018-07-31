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

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-29
 * Time: 下午9:12
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetTV")
public class SetTV extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String getData="Get 电视遥控/State/query?NodeName='电视遥控'";
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        SendAndReceive send0=new SendAndReceive(getData);
        send0.run();

        Map<String, String> sensorState=send0.getSensorState();//此函数的作用是方便其他接口调用来返回sensorState（状态）
        String mac = sensorState.get("NodeMac");
        int num=Integer.parseInt(request.getParameter("num"));
        String conState="Mac "+mac+" 1 CmdNrm IRControl_Emit ";
        switch (num){
            case 0:
                conState+="TV_0";
                break;
            case 1:
                conState+="TV_1";
                break;
            case 2:
                conState+="TV_2";
                break;
            case 3:
                conState+="TV_3";
                break;
            case 4:
                conState+="TV_4";
                break;
            case 5:
                conState+="TV_5";
                break;
            case 6:
                conState+="TV_6";
                break;
            case 7:
                conState+="TV_7";
                break;
            case 8:
                conState+="TV_8";
                break;
            case 9:
                conState+="TV_9";
                break;
            case 10:
                conState+="TV_Power";
                break;
            case 11:
                conState+="TV_-";
                break;
            case 12:
                conState+="";
                break;
            case 13:
                conState+="TV_VolumeUP";
                break;
            case 14:
                conState+="TV_VolumeDown";
                break;
            case 15:
                conState+="TV_ChannelDown";
                break;
            case 16:
                conState+="TV_ChannelUP";
                break;
            case 17:
                conState+="TV_Enter";
                break;
        }
        System.out.println("******************操作语句******************");
        System.out.println(conState);
        System.out.println("******************语句结束******************");

        SendOnly send=new SendOnly(conState);
        send.run();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
