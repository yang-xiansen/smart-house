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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>智能家居</title>
    <%--<style type="text/css">
        @import url("css/style.css");
    </style>--%>
    <link href="css/style.css" type="text/css" rel="stylesheet"/>
    <script src="/scripts/jquery-1.3.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        var timeout;
        function realTimeData() {
            if ($('#sensorType').val() != 'null') {
                $.get("GetRealTime.do", {
                    name: encodeURI($("#sensorName").val()),
                    type: encodeURI($("#sensorType").val())
                }, function (data, textStatus) {
                    var name = data.name;
                    name = decodeURI(name);
                    var realTimeData = data.realTimeData;
                    var realData = realTimeData.split("\t");
                    var value = realData[2];
                    var dateAndTime = realData[0].split("T");
                    var date = dateAndTime[0];
                    var time = dateAndTime[1];
                    var txtHtml = "<div>日期：" + date + "</div><br>" +
                            "<div>时间：" + time + "</div><br>" +
                            "<div>数值：" + value;
                    /*alert(name.indexOf("温度"));*/
                    if (name.indexOf('温度') != -1) {
                        txtHtml += '℃';
                    }
                    if (name.indexOf('光照') != -1) {
                        txtHtml += 'Lux';
                    }
                    if (name.indexOf('湿度') != -1) {
                        txtHtml += '%';
                    }
                    txtHtml += "</div>";
                    $("#resState").html(txtHtml);
                }, "json");
                setTimeout("realTimeData()", 5000);//5s刷新
            } else {
                var txtHtml = "<div>该设备还没有开启！</div>";
                $("#resState").html(txtHtml);
            }
        }

        function turnOn(num) {
            $.get("GetName.do", {//
                name: encodeURI($(".send:eq(" + num + ")").val())
            }, function (data, textStatus) {
                var name = data.name;
                name = decodeURI(name);
                var type = data.type;
                var txtHtml = "<div>您选择的是:&nbsp" + name + "</div><br>";
                txtHtml += "<input type='hidden' id='sensorName' value='" + name + "'/>" +
                        "<input type='hidden' id='sensorType' value='" + type + "'/>";
                //function noiseAlarm()
                $("#resType").html(txtHtml); // 把返回的数据添加到页面上
                var emptyHtml = "<div></div>";
                $("#resState").html(emptyHtml);
            }, "json");
            setTimeout("realTimeData()", 100);
        }
    </script>
    <script src="/scripts/jquery.msgbox.js" type="text/javascript"></script>
    <link href="css/jquery.msgbox.css" type="text/css" rel="stylesheet"/>
    <%--<script src="/js/Alarm.js" type="text/javascript"></script>
    <script src="/js/Voice.js" type="text/javascript"></script>--%>
</head>
<body>
<div id="logo"><a href="http://www.wsn.org.cn/" id="logoLink"></a></div>
<div id="nav">
    <ul>
        <li><a href="index01.jsp">家电系统</a></li>
        <li><a href="index02.jsp">电源系统</a></li>
        <li><a href="index03.jsp" style="background :url(Images/3.png)">环境系统</a></li>
        <li><a href="index04.jsp">安全系统</a></li>
        <li><a href="index05.jsp">照明系统</a></li>
        <li><a href="index06.jsp">节能系统</a></li>
        <li><a href="index07.jsp">视频系统</a></li>
        <%--<li><a href="http://192.168.1.222/" target="_blank">视频系统</a></li>--%>
        <li><a href="index08.jsp">门禁系统</a></li>
    </ul>
</div>

<div id="content">
<div id="contentL">
<%--1--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/light_normal.png" style="cursor: pointer" onclick="$('#button_1').click()">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_1" value="光照" onclick="turnOn(0)"

                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>

    </div>
</div>
<%--2--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/humidy_normal.png" style="cursor: pointer" onclick="$('#button_2').click()">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_2" value="湿度" onclick="turnOn(1)"
                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>
    </div>
</div>
<%--3--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/temperature_normal.png" style="cursor: pointer" onclick="$('#button_3').click()">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_3" value="温度" onclick="turnOn(2)"
                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>
    </div>
</div>
<%--4--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/smoke_normal.png" style="cursor: pointer" onclick="$('#button_4').click()">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_4" value="烟雾" onclick="turnOn(3)"
                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>
    </div>
</div>
<%--5--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/gas_normal.png" style="cursor: pointer" onclick="$('#button_5').click()">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_5" value="燃气" onclick="turnOn(4)"
                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>
    </div>
</div>
<%--6--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/press_normal.png" style="cursor: pointer" onclick="$('#button_6').click()">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_6" value="压力" onclick="turnOn(5)"
                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>
    </div>
</div>
<%--7--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/noise_normal.png" style="cursor: pointer" onclick="$('#button_7').click()" alt="噪声">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_7" value="噪声" onclick="turnOn(6)"

                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>
    </div>
</div>
<%--8--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/fire_normal.png" style="cursor: pointer" onclick="$('#button_8').click()">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_8" value="火焰" onclick="turnOn(7)"
                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>
    </div>
</div>
<%--9--%>
<div class="content0">
    <div class="content00">
        <img src="/Images/zhengdong-normal.png" style="cursor: pointer" onclick="$('#button_9').click()">
    </div>
    <div class="content01">
        <p><input type="button" class="send" id="button_9" value="震动" onclick="turnOn(8)"
                  onmouseover="this.style.backgroundPosition='left -25px'"
                  onmouseout="this.style.backgroundPosition='left top'"
                  onmousedown="this.style.backgroundPosition='left -50px'"
                  onmouseup="this.style.backgroundPosition='left -25px'"
                /></p>
    </div>
</div>

</div>
<div id="contentR">
    <h1>环境系统</h1>
    <BR>
    <BR>

    <div id="sgse_fdiv">
        <span id="sgse_arrow">命令：</span>
        <input type="text" name="wd" id="voice" onmouseover="this.focus();"
               x-webkit-speech lang="zh-CN"
               onwebkitspeechchange="voiceClick()"
               placeholder="语音或输入命令"/>
        &nbsp&nbsp
        <input type="button" value="&nbsp&nbsp发送&nbsp&nbsp" id="voiceUp" onclick="voiceClick()"/>
        <ul id="sgse_menu"></ul>
    </div>
    <BR>
    <BR>

    <div id="resType"></div>
    <div id="resState"></div>
    <br>
</div>
</div>
</body>
</html>