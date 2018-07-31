package com.ict.servlet;

import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-28
 * Time: 下午5:38
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "RFID")
public class RFID extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String dename= URLDecoder.decode(name, "utf-8");
        String type=request.getParameter("type");
        //得实时数据
        /*---3---*/
        String getRealTime="Get "+dename+"/RealTimeData/query?SensorName="+type;

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getRealTime);
        System.out.println("******************语句结束******************");

        SendOnly send1=new SendOnly(getRealTime);
        send1.run();
        String realTimeData=send1.getSensorInfo();
        String[] data=realTimeData.split("\n");
        String ID;
        String Date;
        if(data.length==1){
            ID="empty";
            Date="empty";
        }else{
            realTimeData=data[1];
            String[] realData=realTimeData.split("\t");
            ID=realData[2];
            Date=realData[0];
        }
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        System.out.println(ID);
        System.out.println(Date);
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

        String getInfo="Get Info/RFIDInfo/*/Query?CardID='"+ID+"'";

        System.out.println("******************操作语句******************");
        System.out.println(getInfo);
        System.out.println("******************语句结束******************");

        SendOnly send=new SendOnly(getInfo);
        send.run();
        String rfidInfo0=send.getSensorInfo();
        String rfidInfo;
        String[] info=rfidInfo0.split("\n");
        if(info.length>1){
            System.out.println("1");
            rfidInfo=info[1];
        }else {
            System.out.println("2");
            rfidInfo=ID+"\t未知\t11\t"+Date;
        }
        String[] realInfo=rfidInfo.split("\t");
        String cardName=realInfo[1];
        System.out.println(cardName);
        cardName= URLEncoder.encode(cardName, "UTF-8");

        response.getOutputStream().println("{ cardName : \""+cardName+"\",ID:\""+ID+"\",Date:\""+Date+"\"}");
    }
}
