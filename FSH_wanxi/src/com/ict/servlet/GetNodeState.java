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

/**加载结点的状态
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-25
 * Time: 下午2:38
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetNodeState")
public class GetNodeState extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String dename= URLDecoder.decode(name, "utf-8");
        String type=request.getParameter("type");
        int lastState=Integer.parseInt(request.getParameter("lastState"));
        //得设备状态
        /*---4---*/
        String getNodeState="Get "+dename+"/State/query?SensorName='"+type+"'";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getNodeState);
        System.out.println("******************语句结束******************");

        SendAndReceive send2=new SendAndReceive(getNodeState);
        send2.run();
        Map<String, String> State=send2.getSensorState();
        int state=-1;
        if(State.get("State")!=null){
            state= Integer.parseInt(State.get("State"));
        }
        response.getOutputStream().println("{ name : \""+name+"\",state:"+state+",lastState:"+lastState+"}");
    }
}
