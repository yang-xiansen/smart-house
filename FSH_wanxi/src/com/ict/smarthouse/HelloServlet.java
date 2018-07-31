package com.ict.smarthouse;

import com.ict.java_bean.GetSensorInfoThread;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-9-17
 * Time: 下午7:48
 * To change this template use File | Settings | File Templates.
 */
public class HelloServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GetSensorInfoThread get=new GetSensorInfoThread();
        get.run();
        request.setCharacterEncoding("gbk");
        response.setCharacterEncoding("utf-8");
        response.setHeader("Content-type","text/html;charset=utf-8");
        Set<Map.Entry<String,String>> val=get.getSensorListInfo().entrySet();
        Iterator<Map.Entry<String,String>> it=val.iterator();
        while (it.hasNext()){
            Map.Entry<String,String> item=it.next();
            try {

                response.getWriter().println(item.getKey()+" "+item.getValue());} catch (IOException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
        }






    }
}
