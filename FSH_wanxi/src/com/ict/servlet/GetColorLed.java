package com.ict.servlet;

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
 * function:重新加载led灯的控制
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-22
 * Time: 上午10:49
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetColorLed")
public class GetColorLed extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String bname = request.getParameter("bled");
        String rname = request.getParameter("rled");
        String gname = request.getParameter("gled");
        String bled= URLDecoder.decode(bname, "utf-8");
        String rled= URLDecoder.decode(rname, "utf-8");
        String gled= URLDecoder.decode(gname, "utf-8");
        /*---1---*/
        String getData="Get "+bled+"/State/query?NodeName='"+bled+"'";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        SendAndReceive send=new SendAndReceive(getData);
        send.run();
        Map<String, String> LEDState=send.getSensorState();
        String bmac=LEDState.get("NodeMac");
        /*---2---*/
        getData="Get "+rled+"/State/query?NodeName='"+rled+"'";

        System.out.println("******************操作语句******************");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        send=new SendAndReceive(getData);
        send.run();
        LEDState=send.getSensorState();
        String rmac=LEDState.get("NodeMac");
        /*---3---*/
        getData="Get "+gled+"/State/query?NodeName='"+gled+"'";

        System.out.println("******************操作语句******************");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        send=new SendAndReceive(getData);
        send.run();
        LEDState=send.getSensorState();
        String gmac=LEDState.get("NodeMac");
        response.getOutputStream().println("{ bmac : \""+bmac+"\",rmac : \""+rmac+"\",gmac : \""+gmac+"\"}");
    }
}
