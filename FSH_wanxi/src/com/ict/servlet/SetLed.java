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
 * Date: 13-10-22
 * Time: 下午4:08
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetLed")
public class SetLed extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac=request.getParameter("mac");
        int percent=Integer.parseInt(request.getParameter("percent"));
        String conState="Mac "+mac+" 3 CmdNrm LED_SetLightIntensity "+percent;

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
