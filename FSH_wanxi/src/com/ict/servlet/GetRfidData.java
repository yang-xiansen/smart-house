package com.ict.servlet;

import com.ict.java_bean.SendOnly;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

/**加载rfid信息
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-11-7
 * Time: 上午10:56
 * //输入日期，得到当天刷卡记录
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetRfidData")
public class GetRfidData extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String date=request.getParameter("date");
        String getTable="Get Info/sensordataindex/TableName/Query?TableName_Like_\"r"+date+"%\"";
        System.out.println("******************操作语句******************");
        System.out.println(getTable);
        System.out.println("******************语句结束******************");

        SendOnly send1=new SendOnly(getTable);
        send1.run();
        String info=send1.getSensorInfo();
        String[] data=info.split("\n");
        String table=data[1];
        /*System.out.println(table);*/
        String getDetail="Get Info/"+table+"/datetime,SensorData/Query?sensorid=43";
        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getDetail);
        System.out.println("******************语句结束******************");
        SendOnly send2=new SendOnly(getDetail);
        send2.run();
        String msg=send2.getSensorInfo();
        String[] detail=msg.split("\n");
        String detailAll="";
        int num=detail.length-1;
        for(int i=1;i<detail.length;i++){
            String[] realData=detail[i].split("\t");
            String ID=realData[1];
            String Date=realData[0];
            String[] dateAndTime=realData[0].split("T");
            String time=dateAndTime[1];
            detailAll+="tr1td1"+time+"td2td1"+ID+"td2td1";


            String getInfo="Get Info/RFIDInfo/*/Query?CardID='"+ID+"'";

            System.out.println("******************操作语句******************");
            System.out.println(getInfo);
            System.out.println("******************语句结束******************");

            SendOnly send=new SendOnly(getInfo);
            send.run();
            String rfidInfo=send.getSensorInfo();
            String[] info2=rfidInfo.split("\n");
            if(info2.length>1){
                rfidInfo=info2[1];
            }else {
                rfidInfo=ID+"\t未知\t11\t"+Date;
            }
            String[] realInfo=rfidInfo.split("\t");
            String cardName=realInfo[1];
            detailAll+=cardName+"td2tr2";
        }
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        System.out.println(detailAll);
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        detailAll=detailAll.replace("\n","n");
        detailAll=detailAll.replace(":","m");
        detailAll= URLEncoder.encode(detailAll, "UTF-8");
        response.getWriter().println("{ detailAll:\"" + detailAll +"\",num:"+num+"}");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
