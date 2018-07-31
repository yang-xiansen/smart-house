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
<link href="css/jquery.msgbox.css" type="text/css" rel="stylesheet"/>
<script src="/scripts/jquery-1.3.1.js" type="text/javascript"></script>
<script src="/scripts/jquery.msgbox.js" type="text/javascript"></script>
<script type="text/javascript">

var cm = 0;//全局变量，标示是否勾选提醒
var cm1 = 0;
var rsd = 0;
var rsd1 = 0;
var rsd2 = 0;
var blps = 0;
var hwds = 0;
var hwds1 = 0;
var yd = 0;

var cmsta = 0;//全局变量，标示是上次状态
var cmsta1 = 0;
var rsdsta = 0;
var rsdsta1 = 0;
var rsdsta2 = 0;
var blpssta = 0;
var hwdssta = 0;
var hwdssta1 = 0;
var ydsta = 0;

$(function () {//网页自动加载函数
    AutoAlert();
});

function AutoAlert() {//轮询 提醒!!
    var rate = 1000;
    if (cm == 1) {
        $.get("Type.do", {
            name: encodeURI("磁敏")
        }, function (data, textStatus) {
            var state1 = data.state;
            if (cmsta != state1) {
                cmsta = state1;
                if (state1 == 1) {
                    Alarm("磁敏", "门开");
                }
                if (state1 == 0) {
                    Alarm("磁敏", "门关");
                }
            }
        }, "json")
    }
    if (cm1 == 1) {
        $.get("Type.do", {
            name: encodeURI("磁敏1")
        }, function (data, textStatus) {
            var state1 = data.state;
            if (cmsta1 != state1) {//**********
                cmsta1 = state1;
                if (state1 == 1) {
                    Alarm("磁敏1", "门开");
                }
                if (state1 == 0) {
                    Alarm("磁敏1", "门关");
                }
            }
        }, "json")
    }
    if (rsd == 1) {
        $.get("Type.do", {
            name: encodeURI("热释电")
        }, function (data, textStatus) {
            var state2 = data.state;
            /*alert(cmsta);*/
            if (rsdsta != state2) {
                rsdsta = state2;
                if (state2 == 1) {
                    Alarm("热释电", "有人");
                }
                if (state2 == 0) {
                    Alarm("热释电", "无人");
                }
            }
        }, "json")
    }
    if (rsd1 == 1) {
        $.get("Type.do", {
            name: encodeURI("热释电1")
        }, function (data, textStatus) {
            var state2 = data.state;
            /*alert(cmsta);*/
            if (rsdsta1 != state2) {//*********
                rsdsta1 = state2;
                if (state2 == 1) {
                    Alarm("热释电1", "有人");
                }
                if (state2 == 0) {
                    Alarm("热释电1", "无人");
                }
            }
        }, "json")
    }
    if (rsd2 == 1) {
        $.get("Type.do", {
            name: encodeURI("热释电2")
        }, function (data, textStatus) {
            var state2 = data.state;
            /*alert(cmsta);*/
            if (rsdsta2 != state2) {//***************
                rsdsta2 = state2;
                if (state2 == 1) {
                    Alarm("热释电2", "有人");
                }
                if (state2 == 0) {
                    Alarm("热释电2", "无人");
                }
            }
        }, "json")
    }
    if (blps == 1) {
        $.get("Type.do", {
            name: encodeURI("玻璃破碎")
        }, function (data, textStatus) {
            var state3 = data.state;
            if (blpssta != state3) {
                blpssta = state3;
                if (state3 == 1) {
                    Alarm("玻璃破碎", "玻璃已碎");
                }
                if (state3 == 0) {
                    Alarm("玻璃破碎", "玻璃完好");
                }
            }
        }, "json")
    }
    if (hwds == 1) {
        $.get("Type.do", {
            name: encodeURI("红外对射")
        }, function (data, textStatus) {
            rate = 100;
            var state4 = data.state;
            if (hwdssta != state4) {
                hwdssta = state4;
                Alarm("红外对射", "有人经过");
            }
        }, "json")
    }
    if (hwds1 == 1) {
        $.get("Type.do", {
            name: encodeURI("红外对射1")
        }, function (data, textStatus) {
            rate = 100;
            var state4 = data.state;
            if (hwdssta1 != state4) {//*********
                hwdssta1 = state4;
                Alarm("红外对射1", "有人经过");
            }
        }, "json")
    }
    if (yd == 1) {
        $.get("Type.do", {
            name: encodeURI("雨滴")
        }, function (data, textStatus) {
            var state5 = data.state;
            if (ydsta != state5) {
                ydsta = state5;
                if (state5 == 1) {
                    Alarm("雨滴", "在下雨");
                }
                if (state5 == 0) {
                    Alarm("雨滴", "雨停了");
                }
            }
        }, "json")
    }
    setTimeout("AutoAlert()", rate);//1s判断一次
}
function Alarm(chr1, chr2) {//提醒
    /*var name=chr1;
     var state=chr2;*/
    $.msgbox({
        autoClose: 10,
        /*closeImg: 'close.gif',*/
        height: 163,
        width: 386,
        title: '来自 ' + chr1 + ' 的提醒：',
        content: '<br>' + chr1 + ": " + chr2 + '<br><br>',
        type: 'alert'
    });
}

function btnClick(num) {
    $.get("GetName.do", {//
        name: encodeURI($(".send:eq(" + num + ")").val())
    }, function (data, textStatus) {
        var name = data.name;
        name = decodeURI(name);
        var type = data.type;
        var txtHtml = "<div>您选择的是:&nbsp" + name + "</div><br>";
        txtHtml += "<input type='hidden' id='sensorName' value='" + name + "'/>" +
                "<input type='hidden' id='sensorType' value='" + type + "'/>";
        $("#resType").html(txtHtml); // 把返回的数据添加到页面上

        var emptyHtml = "<div><input type='hidden' id='lastState' value='" + 2 + "'/></div>";
        $("#resState").html(emptyHtml);
        //!!!
        var optionHtml = "<div>";
        if ((name == "磁敏" && cm == 1) || (name == "磁敏1" && cm1 == 1) || (name == "热释电" && rsd == 1) || (name == "热释电1" && rsd1 == 1) || (name == "热释电2" && rsd2 == 1) || (name == "玻璃破碎" && blps == 1) || (name == "红外对射" && hwds == 1) || (name == "红外对射1" && hwds1 == 1) || (name == "雨滴" && yd == 1)) {
            optionHtml += "<input type='checkbox' id='alarm' onclick='setAlarm()' checked/><label for='everyDay'>&nbsp是否提醒</label>";
        } else {
            optionHtml += "<input type='checkbox' id='alarm' onclick='setAlarm()' /><label for='everyDay'>&nbsp是否提醒</label>";
        }


        optionHtml += "<font size=2 style='margin-left: 20px;color: #999'>提示：提醒仅本页有效</font></div><br>";

        $("#resOption").html(optionHtml);
    }, "json");
    setTimeout("realTimeState()", 100);
}

function setAlarm() {//勾选 提醒 执行 改变全局变量
    $.get("Type.do", {
        name: encodeURI($("#sensorName").val())
    }, function (data, textStatus) {
        var name = data.name;
        name = decodeURI(name);
        var optionHtml = "<div>";
        if ($("#alarm").attr("checked")) {
            optionHtml += "<input type='checkbox' id='alarm' onclick='setAlarm()' checked/><label for='everyDay'>&nbsp是否提醒</label>";
            if (name == "磁敏") {
                cm = 1;
            }
            if (name == "磁敏1") {
                cm1 = 1;
            }
            if (name == "热释电") {
                rsd = 1;
            }
            if (name == "热释电1") {
                rsd1 = 1;
            }
            if (name == "热释电2") {
                rsd2 = 1;
            }
            if (name == "玻璃破碎") {
                blps = 1;
            }
            if (name == "红外对射") {
                hwds = 1;
            }
            if (name == "红外对射1") {
                hwds1 = 1;
            }
            if (name == "雨滴") {
                yd = 1;
            }
        } else {
            optionHtml += "<input type='checkbox' id='alarm' onclick='setAlarm()'/><label for='everyDay'>&nbsp是否提醒</label>";
            if (name == "磁敏") {
                cm = 0;
            }
            if (name == "磁敏1") {
                cm1 = 0;
            }
            if (name == "热释电") {
                rsd = 0;
            }
            if (name == "热释电1") {
                rsd1 = 0;
            }
            if (name == "热释电2") {
                rsd2 = 0;
            }
            if (name == "玻璃破碎") {
                blps = 0;
            }
            if (name == "红外对射") {
                hwds = 0;
            }
            if (name == "红外对射1") {
                hwds1 = 0;
            }
            if (name == "雨滴") {
                yd = 0;
            }
        }

        optionHtml += "<font size=2 style='margin-left: 20px;color: #999'>提示：提醒仅本页有效</font></div><br>";
        $("#resOption").html(optionHtml);

    }, "json");
}

function realTimeState() {
    if ($("#sensorType").val() != "null") {
        $.get("GetNodeState.do", {
            name: encodeURI($("#sensorName").val()),
            type: encodeURI($("#sensorType").val()),
            lastState: encodeURI($("#lastState").val())
        }, function (data, textStatus) {
            var name = data.name;
            name = decodeURI(name);
            var state = data.state;
            var lastState = data.lastState;
            var txtHtml = "<div>状态：&nbsp";
            txtHtml += "<input type='hidden' id='lastState' value='" + state + "'/>";
            if (name.indexOf("磁敏") != -1) {
                if (state == 1) {
                    txtHtml += "门开";//显示

                } else if (state == 0) {
                    txtHtml += "门关";

                }
            }
            /*if(name=="磁敏"){
                if (state == 1) {
                    txtHtml += "门开";//显示

                } else if (state == 0) {
                    txtHtml += "门关";

                }
            }
            if(name=="磁敏1"){
                if (state == 1) {
                    txtHtml += "门开";//显示

                } else if (state == 0) {
                    txtHtml += "门关";

                }
            }*/

            if (name.indexOf("热释电") != -1) {
                if (state == 1) {
                    txtHtml += "有人";

                } else if (state == 0) {
                    txtHtml += "无人";

                }
            }
            /*if (name=="热释电") {
                if (state == 1) {
                    txtHtml += "有人";

                } else if (state == 0) {
                    txtHtml += "无人";

                }
            }
            if (name=="热释电1") {
                if (state == 1) {
                    txtHtml += "有人";

                } else if (state == 0) {
                    txtHtml += "无人";

                }
            }
            if (name=="热释电2") {
                if (state == 1) {
                    txtHtml += "有人";

                } else if (state == 0) {
                    txtHtml += "无人";

                }
            }*/
            if (name == "玻璃破碎") {
                if (state == 1) {
                    txtHtml += "玻璃已碎";

                } else if (state == 0) {
                    txtHtml += "玻璃完好";

                }
            }
            if (name.indexOf("红外对射") != -1) {//与其他不同
                if (state == hwdssta) {
                    txtHtml += "无人经过";
                } else {
                    txtHtml += "有人经过";
                }
            }
            /*if (name=="红外对射") {//与其他不同
                if (state == hwdssta) {
                    txtHtml += "无人经过";
                } else {
                    txtHtml += "有人经过";
                }
            }
            if (name=="红外对射1") {//与其他不同
                if (state == hwdssta) {
                    txtHtml += "无人经过";
                } else {
                    txtHtml += "有人经过";
                }
            }*/
            if (name == "雨滴") {
                if (state == 1) {
                    txtHtml += "在下雨";

                } else if (state == 0) {
                    txtHtml += "雨停了";

                }
            }
            txtHtml += "</div>";
            $("#resState").html(txtHtml);
        }, "json");
        setTimeout("realTimeState()", 5000);//5s刷新   页面显示
    } else {
        var txtHtml = "<div>该设备还没有开启！</div>";
        $("#resState").html(txtHtml);
    }

}


</script>
<%--<script src="/js/Alarm.js" type="text/javascript"></script>
<script src="/js/Voice.js" type="text/javascript"></script>--%>
</head>
<body>
<div id="logo"><a href="http://www.wsn.org.cn/" id="logoLink"></a></div>
<div id="nav">
    <ul>
        <li><a href="index01.jsp">家电系统</a></li>
        <li><a href="index02.jsp">电源系统</a></li>
        <li><a href="index03.jsp">环境系统</a></li>
        <li><a href="index04.jsp" style="background :url(Images/3.png)">安全系统</a></li>
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
                <img src="/Images/magnet_normal.png" style="cursor: pointer" onclick="$('#button_1').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_1" value="磁敏" onclick="btnClick(0)"
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
                <img src="/Images/infraredscreen_normal.png" style="cursor: pointer" onclick="$('#button_2').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_2" value="热释电" onclick="btnClick(1)"
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
                <img src="/Images/glass_normal.png" style="cursor: pointer" onclick="$('#button_3').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_3" value="玻璃破碎" onclick="btnClick(2)"
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
                <img src="/Images/infrareddetect_normal.png" style="cursor: pointer" onclick="$('#button_4').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_4" value="红外对射" onclick="btnClick(3)"
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
                <img src="/Images/rain_normal.png" style="cursor: pointer" onclick="$('#button_5').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_5" value="雨滴" onclick="btnClick(4)"
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
                <img src="/Images/infraredscreen_normal.png" style="cursor: pointer" onclick="$('#button_6').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_6" value="热释电1" onclick="btnClick(5)"
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
                <img src="/Images/magnet_normal.png" style="cursor: pointer" onclick="$('#button_7').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_7" value="磁敏1" onclick="btnClick(6)"
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
                <img src="/Images/infraredscreen_normal.png" style="cursor: pointer" onclick="$('#button_8').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_8" value="热释电2" onclick="btnClick(7)"
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
                <img src="/Images/infrareddetect_normal.png" style="cursor: pointer" onclick="$('#button_9').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_9" value="红外对射1" onclick="btnClick(8)"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>

    </div>
    <div id="contentR">
        <h1>安全系统</h1>
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
        <div id="resOption"></div>
        <div id="resState"></div>
        <br>
    </div>
</div>
</body>
</html>