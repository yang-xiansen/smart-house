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
 * Date: 13-10-23
 * Time: 上午10:32
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetColorLed")
public class SetColorLed extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String bmac=request.getParameter("bmac");
        String rmac=request.getParameter("rmac");
        String gmac=request.getParameter("gmac");
        int type=Integer.parseInt(request.getParameter("type"));
        int percent=Integer.parseInt(request.getParameter("percent"));
        String conState="Mac ";
        if(type==0){
            conState+=bmac;
        }
        if(type==1){
            conState+=rmac;
        }
        if(type==2){
            conState+=gmac;
        }
        conState+=" 3 CmdNrm LED_SetLightIntensity "+percent;

        System.out.println("******************操作语句******************");
        System.out.println(conState);
        System.out.println("******************语句结束******************");
        System.out.println("22222222222222222222222222222222222222222222222");

        SendOnly send=new SendOnly(conState);
        send.run();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
