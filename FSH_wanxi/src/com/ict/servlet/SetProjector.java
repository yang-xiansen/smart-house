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
 * Date: 13-12-6
 * Time: 上午11:28
 * //给投影发控制命令，只有开、关
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetProjector")
public class SetProjector extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac = request.getParameter("mac");
        int num=Integer.parseInt(request.getParameter("num"));
        String conState="Mac "+mac+" 1 CmdNrm IRControl_Emit ";
        switch (num){
            case 0 :
                conState+="Projector_PowerOn";
                break;
            case 1 :
                conState+="Projector_PowerOff";
                break;
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
