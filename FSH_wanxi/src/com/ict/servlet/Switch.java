package com.ict.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.ict.java_bean.SendOnly;

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-11
 * Time: 下午4:33
 * 此servlet负责控制switch节点的开关状态
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "Switch")
public class Switch extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac = request.getParameter("mac");
        int state = Integer.parseInt(request.getParameter("state"));
        String conState="Mac "+mac;
        if(state==0){
            conState+=" 0 CmdNrm Switch_On";
//            state=1;
        }else if(state==1){
            conState+=" 1 CmdNrm Switch_Off";
//            state=0;
        }
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
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

