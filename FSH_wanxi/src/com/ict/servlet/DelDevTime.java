package com.ict.servlet;

import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * function:删除单一设备的所有定时 清空定时
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-19
 * Time: 上午11:09
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "DelDevTime")
public class DelDevTime extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac=request.getParameter("mac");
        String delTime="AgentDelete /DateTimeTrigger/SendPacket  IOT/3.0\n" +
                "SN:4\n" +
                "Host:Agent\n";
        delTime+="Dest-Mac:"+mac+"\n\n";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(delTime);
        System.out.println("******************语句结束******************");

        SendOnly send=new SendOnly(delTime);
        send.run();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
