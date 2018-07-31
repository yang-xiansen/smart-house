package com.ict.servlet;

import com.ict.java_bean.SendAndReceive;
import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Map;

/**重新 加载 数据自动状态 信息所用
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-21
 * Time: 下午2:34
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetDataAuto")
public class GetDataAuto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String mac=request.getParameter("mac");
        String getAuto="AgentGet /DataThreshTrigger/SendPacket  IOT/3.0\n" +
                "SN:7\n" +
                "Host:Agent\n" +
                "Dest-Mac:"+mac+"\n\n";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getAuto);
        System.out.println("******************语句结束******************");

        SendOnly send2=new SendOnly(getAuto);
        send2.run();

        int state=1;
        if(send2.getSensorInfo().equals("empty")){
            System.out.println("！！！！！！！！！！！！！！！！！！！！！！！空");
            state=0;
        }
        response.getOutputStream().println("{ state:"+state+"}");
    }
}
