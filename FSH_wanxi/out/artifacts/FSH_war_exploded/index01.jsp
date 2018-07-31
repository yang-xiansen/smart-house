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
<script type="text/javascript">
//以下窗帘
function curtain() {
    $.get("Type.do", {
        name: encodeURI($("#curtain").val())
    }, function (data, textStatus) {
        var name = data.name;
        var type = data.type;
        name = decodeURI(name);
        type = decodeURI(type);
        var txtHtml0 = "<div>您选择的是:&nbsp" + name + "</div><br>";
        $("#resType").html(txtHtml0); // 把返回的数据添加到页面上
        var emptyHtml = "<div></div>";
        $("#resTimeInfo").html(emptyHtml);
        $("#resSetTime").html(emptyHtml);//清空不需要的信息
        /*if (data.state != -1) {*/
        if (data.mac != "null") {
            var txtHtml = "<div>设备状态:&nbsp";
            txtHtml += "停<br><br>";
            txtHtml += "控制:&nbsp&nbsp&nbsp"
                    + "<button class='switch' onclick='setCurtain(" + 0 + ")'>&nbsp&nbsp开&nbsp&nbsp</button>&nbsp&nbsp" +
                    "<button class='switch' onclick='setCurtain(" + 1 + ")'>&nbsp&nbsp关&nbsp&nbsp</button>&nbsp&nbsp" +
                    "<button class='switch' onclick='setCurtain(" + 2 + ")'>&nbsp&nbsp停&nbsp&nbsp</button>";
            // 加入隐藏域传递值
            txtHtml += "<input type='hidden' id='param1' value='"
                    + data.mac + "'/>";
            txtHtml += "</div>";
            $("#resState").html(txtHtml);
        } else {
            var txtHtml2 = "<div>该设备还没有开启！</div>";
            $("#resState").html(txtHtml2);
        }
    }, "json")
}
function setCurtain(num) {
    $.post("Curtain.do", {
        num: num,
        mac: $("#param1").val()
    }, function (data, textStatus) {
        var txtHtml = "<div>设备状态:&nbsp";
        switch (data.state) {
            case 0 :
                txtHtml += "关<br><br>";

                break;
            case 1 :
                txtHtml += "开<br><br>";

                break;
            case 2 :
                txtHtml += "停<br><br>";

                break;
        }
        txtHtml += "控制:&nbsp&nbsp&nbsp"
                + "<button class='switch' onclick='setCurtain(" + 0 + ")'>&nbsp&nbsp开&nbsp&nbsp</button>&nbsp&nbsp" +
                "<button class='switch' onclick='setCurtain(" + 1 + ")'>&nbsp&nbsp关&nbsp&nbsp</button>&nbsp&nbsp" +
                "<button class='switch' onclick='setCurtain(" + 2 + ")'>&nbsp&nbsp停&nbsp&nbsp</button>";
        // 加入隐藏域传递值
        txtHtml += "<input type='hidden' id='param1' value='"
                + data.mac + "'/>";
        txtHtml += "</div>";
        $("#resState").html(txtHtml);
    }, "json")
}

var memory = 1;
//以下电视机
function TVClick() {
    var txtHtml0 = "<div>您选择的是:&nbsp电视遥控</div><br>";
    txtHtml0 += "<input type='hidden' id='memory' value='" + memory + "'/>";
    $("#resType").html(txtHtml0); // 把返回的数据添加到页面上
    /*$("#resType").html();*/
    var txtHtml = "<div style='margin: auto;background: #fff;width: 195px;height: 500px'>" +
            "<div><img src='Images/dianshiji/dianyuan.png' width='64' height='64' onclick='setTV(10)' style='cursor: pointer'/></div>" +
            "<img src='Images/dianshiji/1.png' width='64' height='64' onclick='setTV(1)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/2.png' width='64' height='64' onclick='setTV(2)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/3.png' width='64' height='64' onclick='setTV(3)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/4.png' width='64' height='64' onclick='setTV(4)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/5.png' width='64' height='64' onclick='setTV(5)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/6.png' width='64' height='64' onclick='setTV(6)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/7.png' width='64' height='64' onclick='setTV(7)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/8.png' width='64' height='64' onclick='setTV(8)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/9.png' width='64' height='64' onclick='setTV(9)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/cunchu.png' width='64' height='64' onclick='setMemory()' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/0.png' width='64' height='64' onclick='setTV(0)' style='cursor: pointer'/>" +
            "<img src='Images/dianshiji/jiyi.png' width='64' height='64' onclick='getMemory()' style='cursor: pointer'/>" +
            "<div style='margin: auto;width: 160px;height: 160px'>" +
            "<img src='Images/dianshiji/yingliang1.png' width='160' height='160' border='0' usemap='#Map'  />" +
            "<map name=Map id='Map'>" +
            "<area shape='rect' coords='49,2,108,52' onclick='setTV(13)' href='#'>" +
            "<area shape='rect' coords='107,51,158,104' onclick='setTV(16)' href='#'>" +
            "<area shape='rect' coords='4,50,52,106' onclick='setTV(15)' href='#'>" +
            "<area shape='rect' coords='50,104,107,157' onclick='setTV(14)' href='#'>" +
            "<area shape='rect' coords='51,51,108,105' onclick='setTV(17)' href='#'>" +

            "</map>" +
            "</div>" +
            "</div>";
    $("#resState").html(txtHtml);//-------------------------------显示记忆频道
}
function setTV(num) {
    /*alert(num);*/
    $.post("SetTV.do", {
        num: num
    }, function (data, textStatus) {
    }, "json");
}

//电视机记忆
function setMemory() {
    $.msgbox({
        /*closeImg: 'close.gif',*/
        height: 163,
        width: 386,
        content: '<br>请输入频道: ',
        type: 'input',
        title: '请输入需要记忆的频道',
        onInputed: function (v) {
            var txtHtml0 = "<div>您选择的是:&nbsp电视遥控</div><br>";
            txtHtml0 += "<input type='hidden' id='memory' value='" + v + "'/>";
            memory = v;
            $("#resType").html(txtHtml0);
            /*alert('您输入的是:'+v)*/
        }
    });
}
function getMemory() {
    var s = memory.split("");
    var l = memory.length;
    var i;
    for (i = 0; i < l; i++) {
        setTV(s[i]);
    }
    setTV(17);
}


//以下空调
function airClick() {
    airInfo();
    var emptyHtml = "<div></div>";
    $("#resType").html(emptyHtml);
    /*alert($("#mac").val());*/
    var irc = "<div style='margin: auto;background: #fff;width: 200px;height: 300px'>";
    irc += "<img src='Images/kongtiao/kaiguan.png' width='100' height='100' onclick='setAir(1)' style='cursor: pointer' alt='开关'/>" +
            "<img src='Images/kongtiao/wendu.png' width='100' height='100' onclick='setAir(2)' style='cursor: pointer' alt='温度'/>" +
            "<img src='Images/kongtiao/dingshi.png' width='100' height='100' onclick='setAir(3)' style='cursor: pointer' alt='定时'/>" +
            "<img src='Images/kongtiao/baifeng.png' width='100' height='100' onclick='setAir(4)' style='cursor: pointer' alt='摆风'/>" +
            "<img src='Images/kongtiao/zhire.png' width='100' height='100' onclick='setAir(5)' style='cursor: pointer' alt='制热'/>" +
            "<img src='Images/kongtiao/zhineng.png' width='100' height='100' onclick='setAir(6)' style='cursor: pointer' alt='智能'/>";
    irc += "</div>";
    $("#resState").html(irc);
}
function setAir(num) {
    $.post("SetAir.do", {
        mac: $("#mac").val(),
        num: num
    }, function (data, textStatus) {

    }, "json");

    setTimeout("airInfo()", 1000);

}
function airInfo() {
    $.get("GetAir.do", {
        name: encodeURI("空调")
    }, function (data, textStatus) {
        var txtHtml = "<div>您选择的是:&nbsp空调" +
                "<font size=2 style='margin-left: 20px;color: #999'>提示：以下状态信息更新会有2S延迟</font></div>" +
                "<br>";
        /*txtHtml+="ms:"+data.ms+"wd:"+data.wd+"fs:"+data.fs+"fx:"+data.fx+"<br>";
         txtHtml+="mac:"+data.mac;*/
        var mac = data.mac;
        var ms = data.ms;
        var wd = data.wd;
        var fs = data.fs;
        var fx = data.fx;
        if (mac != "null") {
            txtHtml += "<div>设备状态:&nbsp";
            if (ms == 0) {
                txtHtml += "关</div><br>";
            } else {
                txtHtml += "开</div><br>";
                txtHtml += "<div>模式:&nbsp";
                if (ms == 1) {
                    txtHtml += "制冷</div><br>";
                } else if (ms == 2) {
                    txtHtml += "制热</div><br>";
                } else if (ms == 3) {
                    txtHtml += "抽湿</div><br>";
                } else if (ms == 4) {
                    txtHtml += "智能</div><br>";
                }
                txtHtml += "<div>温度:&nbsp" + wd + " ℃</div><br>";
                txtHtml += "<div>风速:&nbsp";
                if (fs == 1) {
                    txtHtml += "智能</div><br>";
                } else if (fs == 2) {
                    txtHtml += "低风</div><br>";
                } else if (fs == 3) {
                    txtHtml += "中风</div><br>";
                } else if (fs == 4) {
                    txtHtml += "高风</div><br>";
                }
                txtHtml += "<div>风向:&nbsp";
                if (fx == 1) {
                    txtHtml += "定风</div><br>";
                } else if (fx == 2) {
                    txtHtml += "摆风</div><br>";
                }
            }

            txtHtml += "<input type='hidden' id='mac' value='" + mac + "'/><br><br>";
        } else {
            txtHtml += "<div>该设备还没有开启！</div><br><br>";
        }
        $("#resType").html(txtHtml);
    }, "json");
}

//以下投影仪
function projectorClick(num) {
    var name = $(".projector:eq(" + num + ")").val();
    $.get("Type.do", {
        name: encodeURI(name)
    }, function (data, textStatus) {
        var mac = data.mac;
        if (mac != "null") {
            var txtHtml = "<div>控制:&nbsp&nbsp&nbsp"
                    + "<button class='switch' onclick='setProjector(" + 0 + ")'>&nbsp&nbsp开&nbsp&nbsp</button>&nbsp&nbsp" +
                    "<button class='switch' onclick='setProjector(" + 1 + ")'>&nbsp&nbsp关&nbsp&nbsp</button>&nbsp&nbsp";
            // 加入隐藏域传递值
            txtHtml += "<input type='hidden' id='mac' value='"
                    + mac + "'/>";
            txtHtml += "</div>";
            $("#resState").html(txtHtml);
        } else {
            var txtHtml2 = "<div>该设备还没有开启！</div>";
            $("#resState").html(txtHtml2);
        }
    }, "json");
    var txtHtml0 = "<div>您选择的是:&nbsp" + name + "</div><br>";
    $("#resType").html(txtHtml0); // 把返回的数据添加到页面上

}
function setProjector(num) {
    $.post("SetProjector.do", {
        num: num,
        mac: $("#mac").val()
    }, function (data, textStatus) {
    }, "json");
}

/**电动幕布**/

/*
function screen() {
    $.get("Type.do", {
        name: encodeURI($("#screen").val())
    }, function (data, textStatus) {
        var name = data.name;
        var type = data.type;
        name = decodeURI(name);
        type = decodeURI(type);
        var txtHtml0 = "<div>您选择的是:&nbsp" + name + "</div><br>";
        $("#resType").html(txtHtml0); // 把返回的数据添加到页面上
        var emptyHtml = "<div></div>";
        $("#resTimeInfo").html(emptyHtml);
        $("#resSetTime").html(emptyHtml);//清空不需要的信息
        */
/*if (data.state != -1) {*//*

        if (data.mac != "null") {
            var txtHtml = "<div>设备状态:&nbsp";
            txtHtml += "停<br><br>";
            txtHtml += "控制:&nbsp&nbsp&nbsp"
                    + "<button class='switch' onclick='setCurtain(" + 0 + ")'>&nbsp&nbsp开&nbsp&nbsp</button>&nbsp&nbsp" +
                    "<button class='switch' onclick='setCurtain(" + 1 + ")'>&nbsp&nbsp关&nbsp&nbsp</button>&nbsp&nbsp" +
                    "<button class='switch' onclick='setCurtain(" + 2 + ")'>&nbsp&nbsp停&nbsp&nbsp</button>";
            // 加入隐藏域传递值
            txtHtml += "<input type='hidden' id='param1' value='"
                    + data.mac + "'/>";
            txtHtml += "</div>";
            $("#resState").html(txtHtml);
        } else {
            var txtHtml2 = "<div>该设备还没有开启！</div>";
            $("#resState").html(txtHtml2);
        }
    }, "json")
}
function setCurtain(num) {
    $.post("Curtain.do", {
        num: num,
        mac: $("#param1").val()
    }, function (data, textStatus) {
        var txtHtml = "<div>设备状态:&nbsp";
        switch (data.state) {
            case 0 :
                txtHtml += "关<br><br>";

                break;
            case 1 :
                txtHtml += "开<br><br>";

                break;
            case 2 :
                txtHtml += "停<br><br>";

                break;
        }
        txtHtml += "控制:&nbsp&nbsp&nbsp"
                + "<button class='switch' onclick='setCurtain(" + 0 + ")'>&nbsp&nbsp开&nbsp&nbsp</button>&nbsp&nbsp" +
                "<button class='switch' onclick='setCurtain(" + 1 + ")'>&nbsp&nbsp关&nbsp&nbsp</button>&nbsp&nbsp";
        // 加入隐藏域传递值
        txtHtml += "<input type='hidden' id='param1' value='"
                + data.mac + "'/>";
        txtHtml += "</div>";
        $("#resState").html(txtHtml);
    }, "json")
}
*/


</script>
<script src="/js/Type.js" type="text/javascript"></script>
<script src="/js/Switch.js" type="text/javascript"></script>
<%--<script src="/js/Alarm.js" type="text/javascript"></script>
<script src="/js/Voice.js" type="text/javascript"></script>--%>

</head>
<body>
<div id="logo"><a href="http://www.wsn.org.cn/" id="logoLink"></a></div>
<div id="nav">
    <ul>
        <li><a href="index01.jsp" style="background :url(Images/3.png)">家电系统</a></li>
        <li><a href="index02.jsp">电源系统</a></li>
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
                <img src="/Images/fan_on.png" style="cursor: pointer" onclick="$('#button_1').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_1" value="风扇" onclick="btnClick(0)"
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
                <img src="/Images/tv_on.png" style="cursor: pointer" onclick="$('#button_2').click()">
            </div>
            <div class="content01">
                <p><input type="button" id="button_2" value="电视遥控" onclick="TVClick()"
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
                <img src="/Images/tvpower_on.png" style="cursor: pointer" onclick="$('#button_6').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_6" value="电视电源" onclick="btnClick(1)"
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
                <img src="/Images/curtain_on.png" style="cursor: pointer" onclick="$('#curtain').click()">
            </div>
            <div class="content01">
                <p><input type="button" id="curtain" value="窗帘" onclick="curtain()"
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
                <img src="/Images/water_on.png" style="cursor: pointer" onclick="$('#button_5').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_5" value="饮水机" onclick="btnClick(2)"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--6--%>
        <%--<div class="content0">
                    <div class="content00">
                        <img src="/Images/printer_on.png" style="cursor: pointer" onclick="$('#button_3').click()">
                    </div>
                    <div class="content01">
                        <p><input type="button" class="send" id="button_3" value="打印机" onclick="btnClick(2)"/></p>
                    </div>
                </div>--%>
        <%--7--%>
            <div class="content0">
                <div class="content00">
                    <img src="/Images/fridge_on.png" style="cursor: pointer" onclick="$('#button_7').click()">
                </div>
                <div class="content01">
                    <p><input type="button" class="send" id="button_7" value="电冰箱" onclick="btnClick(3)"
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
                <img src="/Images/air_on.png" style="cursor: pointer" onclick="$('#button_8').click()">
            </div>
            <div class="content01">
                <p><input type="button" id="button_8" value="空调" onclick="airClick()"
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
                <img src="/Images/projector_on.png" style="cursor: pointer" onclick="$('#button_9').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="projector" id="button_9" value="投影仪" onclick="projectorClick(0)"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>

        </div>
        <%--10--%>
        <%--<div class="content0">
            <div class="content00">
                <img src="/Images/screen.png" style="cursor: pointer" onclick="$('#screen').click()">
            </div>
            <div class="content01">
                <p><input type="button" id="screen" value="幕布" onclick="screen()"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>--%>
        <%--&lt;%&ndash;10&ndash;%&gt;
        <div class="content0">
            <div class="content00">
                <img src="/Images/projector_on.png" style="cursor: pointer" onclick="$('#button_10').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="projector" id="button_10" value="投影仪2" onclick="projectorClick(1)"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>--%>
        <%--11--%>
        <%--<div class="content0">
            <div class="content00">
                <img src="/Images/projector_on.png" style="cursor: pointer" onclick="$('#button_11').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="projector" id="button_11" value="投影仪3" onclick="projectorClick(2)"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>--%>

    </div>
    <div id="contentR">
        <h1>家电系统</h1>
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