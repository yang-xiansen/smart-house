package com.ict.servlet;

import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/*
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-14
 * Time: 上午9:39
 * 负责处理定时任务
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "SetTime")
public class SetTime extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mac=request.getParameter("mac");
        String date=request.getParameter("date");
        String time=request.getParameter("time");
        int eve=Integer.parseInt(request.getParameter("eve"));
        int state=Integer.parseInt(request.getParameter("state"));
        String conTime="AgentPut /DateTimeTrigger/SendPacket  IOT/3.6\n" +
                "SN:1\n" +
                "Host:Agent\n";
        conTime+="Dest-Mac:"+mac+"\n";
        if(eve==0){
            conTime+="Trigger-Date:" +date+ "\n";
        }
        conTime+="Trigger-Time:" +time+ "\n"+
                "\n";
        if(state==1){
            String conState="Mac "+mac+" 0 CmdNrm Switch_On";
            conTime+=conState;

        }else if(state==0){
            String conState="Mac "+mac+" 1 CmdNrm Switch_Off";
            conTime+=conState;

        }
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(conTime);
        System.out.println("******************语句结束******************");

        SendOnly send=new SendOnly(conTime);
        send.run();

        response.getWriter().println("{ mac : \"" + mac + "\",eve:" + eve +",date:\"" + date +"\",time:\"" + time +"\",state:" + state + "}");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
