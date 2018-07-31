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
 * function:用于窗帘开关的控制
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-28
 * Time: 下午2:17
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "Curtain")
public class Curtain extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac = request.getParameter("mac");
        int state = Integer.parseInt(request.getParameter("num"));
        String conState="Mac "+mac;
        if(state==0){
            conState+=" 0 CmdNrm Switch_On";
            state=1;
        }else if(state==1){
            conState+=" 1 CmdNrm Switch_Off";
            state=0;
        }else if(state==2){
            conState+=" 2 CmdNrm Switch_Suspend";
            state=2;
        }
        System.out.println("******************操作语句******************");
        System.out.println(conState);
        System.out.println("******************语句结束******************");

        SendOnly send=new SendOnly(conState);
        send.run();

        response.getWriter().println("{ mac : \"" + mac + "\",state:" + state + "}");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
