package com.ict.servlet;

import com.ict.java_bean.ResLongMsg;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**查看该设备定时 执行
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-16
 * Time: 上午11:14
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetTimeInfo")
public class GetTimeInfo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac=request.getParameter("mac");

        String getInfo="AgentGet /DateTimeTrigger/SendPacket  IOT/3.0\n" +
                "SN:1\n" +
                "Host:Agent\n";
        getInfo+="Dest-Mac:"+mac+"\n\n";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getInfo);
        System.out.println("******************语句结束******************");

        ResLongMsg send=new ResLongMsg(getInfo);
        send.run();
        int num=send.getNum();
        String msg=send.getMsg();

        msg=msg.replace("\n","\\n");
        response.getWriter().println("{ mac : \"" + mac +"\",num:" + num +",msg:\"" + msg +"\"}");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
