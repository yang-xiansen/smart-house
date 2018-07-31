<%--
  Created by IntelliJ IDEA.
  User: StevenH
  Date: 13-9-25
  Time: 下午5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>智能家居</title>
    <link href="css/style.css" type="text/css" rel="stylesheet"/>
    <script src="/scripts/jquery-1.3.1.js" type="text/javascript"></script>
    <script type="text/javascript">

    </script>
    <script src="/scripts/jquery.msgbox.js" type="text/javascript"></script>
    <link href="css/jquery.msgbox.css" type="text/css" rel="stylesheet"/>
    <script src="/js/Alarm.js" type="text/javascript"></script>
    <script src="/js/Voice.js" type="text/javascript"></script>
</head>
<body>
<div id="logo"> <a href="http://www.wsn.org.cn/" id="logoLink"></a></div>
<div id="nav">
    <ul>
        <li><a href="index01.jsp">家电系统</a></li>
        <li><a href="index02.jsp">电源系统</a></li>
        <li><a href="index03.jsp">环境系统</a></li>
        <li><a href="index04.jsp">安全系统</a></li>
        <li><a href="index05.jsp">照明系统</a></li>
        <li><a href="index06.jsp">节能系统</a></li>
        <li><a href="index07.jsp" style="background :url(Images/3.png)">视频系统</a></li>
        <li><a href="index08.jsp">门禁系统</a></li>
    </ul>
</div>

<div id="content">
    <iframe src="http://192.168.1.222/index.htm" width="1000" height="600" scrolling=no style="margin: 70px 140px">
        <p>第一次</p>
    </iframe>
    <%--<div id="contentL">

        &lt;%&ndash;1&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/fan_on.png" style="cursor: pointer" onclick="$('#button_1').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_1" value="风扇" onclick="btnClick(0)"/></p>
            </div>
        </div>
        &lt;%&ndash;2&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/tv_on.png" style="cursor: pointer" onclick="$('#button_2').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_2" value="电视" onclick="btnClick(1)"/></p>
            </div>
        </div>
        &lt;%&ndash;3&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/printer_on.png" style="cursor: pointer" onclick="$('#button_3').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_3" value="打印机" onclick="btnClick(2)"/></p>
            </div>
        </div>
        &lt;%&ndash;4&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/curtain_on.png" style="cursor: pointer" onclick="$('#button_4').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_4" value="窗帘" onclick="btnClick(3)"/></p>
            </div>
        </div>
        &lt;%&ndash;5&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/water_on.png" style="cursor: pointer" onclick="$('#button_5').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_5" value="饮水机" onclick="btnClick(4)"/></p>
            </div>
        </div>
        &lt;%&ndash;6&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/projector_on.png" style="cursor: pointer" onclick="$('#button_6').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_6" value="投影仪" onclick="btnClick(5)"/></p>
            </div>
        </div>
        &lt;%&ndash;7&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/fridge_on.png" style="cursor: pointer" onclick="$('#button_7').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_7" value="电冰箱" onclick="btnClick(6)"/></p>
            </div>
        </div>
        &lt;%&ndash;&lt;%&ndash;8&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/air_on.png" style="cursor: pointer" onclick="$('#button_8').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_8" value="空调" onclick="btnClick(7)"/></p>
            </div>
        </div>
</div>--%>
    </div>
    <%--</div>
    <div id="contentR">
        <h1>视频系统</h1>
        <BR>
        <BR>
        <div id="resType" ></div>
        <div id="resState" ></div>
        <br>
    </div>
</div>&ndash;%&gt;--%>


</body>
</html>