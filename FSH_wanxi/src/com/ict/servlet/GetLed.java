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

/**重新加载台灯
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-22
 * Time: 下午4:51
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetLed")
public class GetLed extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String name=request.getParameter("name");
        String led= URLDecoder.decode(name, "utf-8");
        String getData="Get "+led+"/State/query?NodeName='"+led+"'";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        SendAndReceive send=new SendAndReceive(getData);
        send.run();
        Map<String, String> LEDState=send.getSensorState();
        String mac=LEDState.get("NodeMac");
        response.getOutputStream().println("{ name : \""+name+"\",mac : \""+mac+"\"}");
    }
}
