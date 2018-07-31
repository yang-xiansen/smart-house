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

/**
 * 重新加载空调
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-29
 * Time: 下午2:20
 * To change this template use File | Settings | File Templates.
 */
@WebServlet(name = "GetAir")

public class GetAir extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type","application/json");
        response.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String dename= URLDecoder.decode(name, "utf-8");

        String getData="Get "+dename+"/State/query?NodeName='"+dename+"'";

        System.out.println("******************操作语句******************");
        System.out.println("22222222222222222222222222222222222222222222222");
        System.out.println(getData);
        System.out.println("******************语句结束******************");

        SendAndReceive send=new SendAndReceive(getData);
        send.run();

        Map<String, String> sensorState=send.getSensorState();
        String state=sensorState.get("State");
        String mac=sensorState.get("NodeMac");
        int ms=0;
        int wd=0;
        int fs=0;
        int fx=0;

        String state1="";
        if(state!=null) {
            state1 = Integer.toBinaryString(Integer.parseInt(state));
        }
        if((state!=null)&&(state1.length()>=16)) {
            String airState=state1.substring(0, 6);
            if (airState.compareTo("000000") == 0)
            {
                ms=0;
                wd=0;
                fs=0;
                fx=0;
            }
            String airMode = state1.substring(6, 8);
            if (airMode.compareTo("00") == 0)
            {
                ms=1;
                /*tv[0].setText("模式\n制冷");*/
            }
            else if (airMode.compareTo("01") == 0)
            {
                ms=2;
                /*tv[0].setText("模式\n制热");*/
            }
            else if (airMode.compareTo("10") == 0)
            {
                ms=3;
                /*tv[0].setText("模式\n智能");*/
            }
            else if (airMode.compareTo("11") == 0)
            {
                ms=4;
                /*tv[0].setText("模式\n抽湿");*/
            }
            String airWindSpeed = state1.substring(8,10);
            if (airWindSpeed.compareTo("00") == 0 )
            {
                fs=1;
                /*tv[2].setText("风速\n智能");*/
            }
            else if (airWindSpeed.compareTo("01") == 0)
            {
                fs=2;
                /*tv[2].setText("风速\n低风");*/
            }
            else if (airWindSpeed.compareTo("10") == 0)
            {
                fs=3;
                /*tv[2].setText("风速\n中风");*/
            }
            else if (airWindSpeed.compareTo("11") == 0)
            {
                fs=4;
                /*tv[2].setText("风速\n高风");*/
            }
            String airWindDirec = state1.substring(10,11);
            if (airWindDirec.compareTo("0") == 0)
            {
                fx=1;
                /*tv[3].setText("风向\n定风");*/
            }
            else if (airWindDirec.compareTo("1") == 0)
            {
                fx=2;
                /*tv[3].setText("风向\n摆风");*/
            }

            String airCurrentTemperature = state1.substring(11,16);
            wd = convertAlgorism(airCurrentTemperature.toCharArray());//温度


            /*airCurrentTemperature = Integer.toString(temperature);*/
            /*tv[1].setText("温度\n" + airCurrentTemperature + " ℃");*/
        }else {
            ms=0;
            wd=0;
            fs=0;
            fx=0;
            /*tv[0].setText("关机");
            tv[1].setText("");
            tv[2].setText("");
            tv[3].setText("");*/
        }
        response.getOutputStream().println("{ mac:\""+mac+"\",ms : "+ms+",wd : "+wd+",fs : "+fs+",fx:"+fx+"}");
    }
    public static int convertAlgorism(char[] chars) {
        int result = 0;
        int num = 0;
        for (int i = chars.length - 1; 0 <= i; i--) {
            int temp = 2;
            if (num == 0) {
                temp = 1;
            } else if (num == 1) {
                temp = 2;
            } else {
                for (int j = 1; j < num; j++) {
                    temp = temp * 2;
                }
            }
            int sum = Integer.parseInt(String.valueOf(chars[i]));
            result = result + (sum * temp);
            num++;
        }
        return result;
    }
}

