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
    <link href="css/style.css" type="text/css" rel="stylesheet"/>
    <script src="/scripts/jquery-1.3.1.js" type="text/javascript"></script>
    <script src="/scripts/jquery.msgbox.js" type="text/javascript"></script>
    <link href="css/jquery.msgbox.css" type="text/css" rel="stylesheet"/>
    <script src="/js/Type.js" type="text/javascript"></script>
    <script src="/js/Switch.js" type="text/javascript"></script>
    <%--    <script src="/js/Alarm.js" type="text/javascript"></script>
        <script src="/js/Voice.js" type="text/javascript"></script>--%>
</head>
<body>
<div id="logo"><a href="http://www.wsn.org.cn/" id="logoLink"></a></div>
<div id="nav">
    <ul>
        <li><a href="index01.jsp">家电系统</a></li>
        <li><a href="index02.jsp" style="background :url(Images/3.png)">电源系统</a></li>
        <li><a href="index03.jsp">环境系统</a></li>
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
                <img src="/Images/power0.png" style="cursor: pointer" onclick="$('#button_1').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_1" value="电源1" onclick="btnClick(0)"
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
                <img src="/Images/power1.png" style="cursor: pointer" onclick="$('#button_2').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_2" value="电源2" onclick="btnClick(1)"
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
                <img src="/Images/power2.png" style="cursor: pointer" onclick="$('#button_3').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_3" value="电源3" onclick="btnClick(2)"
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
                <img src="/Images/power3.png" style="cursor: pointer" onclick="$('#button_4').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_4" value="电源4" onclick="btnClick(3)"
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
                <img src="/Images/power1.png" style="cursor: pointer" onclick="$('#button_5').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_5" value="电源5" onclick="btnClick(4)"
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
                <img src="/Images/power2.png" style="cursor: pointer" onclick="$('#button_6').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_6" value="电源6" onclick="btnClick(5)"
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
                <img src="/Images/power3.png" style="cursor: pointer" onclick="$('#button_7').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_7" value="电源7" onclick="btnClick(6)"
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
                <img src="/Images/power0.png" style="cursor: pointer" onclick="$('#button_8').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_8" value="电源8" onclick="btnClick(7)"
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
                    <img src="/Images/power2.png" style="cursor: pointer" onclick="$('#button_9').click()">
                </div>
                <div class="content01">
                    <p><input type="button" class="send" id="button_9" value="电源9" onclick="btnClick(8)"
                              onmouseover="this.style.backgroundPosition='left -25px'"
                              onmouseout="this.style.backgroundPosition='left top'"
                              onmousedown="this.style.backgroundPosition='left -50px'"
                              onmouseup="this.style.backgroundPosition='left -25px'"
                            /></p>
                </div>
            </div>
            <%--10--%>
            <div class="content0">
                <div class="content00">
                    <img src="/Images/power3.png" style="cursor: pointer" onclick="$('#button_10').click()">
                </div>
                <div class="content01">
                    <p><input type="button" class="send" id="button_10" value="电源10" onclick="btnClick(9)"
                              onmouseover="this.style.backgroundPosition='left -25px'"
                              onmouseout="this.style.backgroundPosition='left top'"
                              onmousedown="this.style.backgroundPosition='left -50px'"
                              onmouseup="this.style.backgroundPosition='left -25px'"
                            /></p>
                </div>
            </div>
            <%--11--%>
            <div class="content0">
                <div class="content00">
                    <img src="/Images/power0.png" style="cursor: pointer" onclick="$('#button_11').click()">
                </div>
                <div class="content01">
                    <p><input type="button" class="send" id="button_11" value="电源11" onclick="btnClick(10)"
                              onmouseover="this.style.backgroundPosition='left -25px'"
                              onmouseout="this.style.backgroundPosition='left top'"
                              onmousedown="this.style.backgroundPosition='left -50px'"
                              onmouseup="this.style.backgroundPosition='left -25px'"
                            /></p>
                </div>
            </div>
            <%--12--%>
            <div class="content0">
                <div class="content00">
                    <img src="/Images/power1.png" style="cursor: pointer" onclick="$('#button_12').click()">
                </div>
                <div class="content01">
                    <p><input type="button" class="send" id="button_12" value="电源12" onclick="btnClick(11)"
                              onmouseover="this.style.backgroundPosition='left -25px'"
                              onmouseout="this.style.backgroundPosition='left top'"
                              onmousedown="this.style.backgroundPosition='left -50px'"
                              onmouseup="this.style.backgroundPosition='left -25px'"
                            /></p>
                </div>
            </div>
            <%--13--%>
            <div class="content0">
                <div class="content00">
                    <img src="/Images/power3.png" style="cursor: pointer" onclick="$('#button_13').click()">
                </div>
                <div class="content01">
                    <p><input type="button" class="send" id="button_13" value="电源13" onclick="btnClick(12)"
                              onmouseover="this.style.backgroundPosition='left -25px'"
                              onmouseout="this.style.backgroundPosition='left top'"
                              onmousedown="this.style.backgroundPosition='left -50px'"
                              onmouseup="this.style.backgroundPosition='left -25px'"
                            /></p>
                </div>
            </div>
            <%--14--%>
            <div class="content0">
                <div class="content00">
                    <img src="/Images/power0.png" style="cursor: pointer" onclick="$('#button_14').click()">
                </div>
                <div class="content01">
                    <p><input type="button" class="send" id="button_14" value="电源14" onclick="btnClick(13)"
                              onmouseover="this.style.backgroundPosition='left -25px'"
                              onmouseout="this.style.backgroundPosition='left top'"
                              onmousedown="this.style.backgroundPosition='left -50px'"
                              onmouseup="this.style.backgroundPosition='left -25px'"
                            /></p>
                </div>
            </div>
        <%--15--%>
        <%--<div class="content0">
            <div class="content00">
                <img src="/Images/power1.png" style="cursor: pointer" onclick="$('#button_15').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_15" value="电源15" onclick="btnClick(14)"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>--%>
        <%--16--%>
       <%-- <div class="content0">
            <div class="content00">
                <img src="/Images/power2.png" style="cursor: pointer" onclick="$('#button_16').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_16" value="电源16" onclick="btnClick(15)"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>--%>


    </div>
    <div id="contentR">
        <h1>电源系统</h1>
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