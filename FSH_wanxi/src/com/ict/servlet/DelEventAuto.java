package com.ict.servlet;

import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 删除事件触发 的自动
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-21
 * Time: 下午2:05
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "DelEventAuto")
public class DelEventAuto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac=request.getParameter("mac");
        String delAuto="AgentDelete /EventTrigger/SendPacket  IOT/3.0\n" +
                "SN:10\n" +
                "Host:Agent\n";
        delAuto+="Dest-Mac:"+mac+"\n\n";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(delAuto);
        System.out.println("******************语句结束******************");

        SendOnly send=new SendOnly(delAuto);
        send.run();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
