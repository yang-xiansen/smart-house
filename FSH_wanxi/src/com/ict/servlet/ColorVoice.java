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
 * function:声控LED灯的颜色选择
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-12-9
 * Time: 下午1:55
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "ColorVoice")
public class ColorVoice extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String getBlue="Get 蓝色LED/State/query?NodeName='蓝色LED'";
        String getRed="Get 红色LED/State/query?NodeName='红色LED'";
        String getGreen="Get 绿色LED/State/query?NodeName='绿色LED'";
        System.out.println("******************操作语句******************");
        System.out.println(getBlue);
        System.out.println(getRed);
        System.out.println(getGreen);
        System.out.println("******************语句结束******************");

        SendAndReceive send=new SendAndReceive(getBlue);
        send.run();
        Map<String, String> LEDState=send.getSensorState();  //获得状态
        String bmac=LEDState.get("NodeMac"); //蓝灯mac

        send=new SendAndReceive(getRed);
        send.run();
        LEDState=send.getSensorState();
        String rmac=LEDState.get("NodeMac");

        send=new SendAndReceive(getGreen);
        send.run();
        LEDState=send.getSensorState();
        String gmac=LEDState.get("NodeMac");


        //下面代码用于组成发送命令指令
        int red=Integer.parseInt(request.getParameter("red"));
        int green=Integer.parseInt(request.getParameter("green"));
        int blue=Integer.parseInt(request.getParameter("blue"));
        String conRed="Mac ";
        conRed+=rmac;
        conRed+=" 3 CmdNrm LED_SetLightIntensity "+red;

        String conGreen="Mac ";
        conGreen+=gmac;
        conGreen+=" 3 CmdNrm LED_SetLightIntensity "+green;

        String conBlue="Mac ";
        conBlue+=bmac;
        conBlue+=" 3 CmdNrm LED_SetLightIntensity "+blue;

        System.out.println("******************操作语句******************");
        System.out.println(conRed);
        System.out.println(conGreen);
        System.out.println(conBlue);
        System.out.println("******************语句结束******************");


        //下面代码用于发送命令指令
        SendOnly sendCon=new SendOnly(conRed);
        sendCon.run();

        sendCon=new SendOnly(conGreen);
        sendCon.run();

        sendCon=new SendOnly(conBlue);
        sendCon.run();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
