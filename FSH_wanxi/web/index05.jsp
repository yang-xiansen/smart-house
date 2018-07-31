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
<script src="/scripts/jvslider.1.2.js" type="text/javascript"></script>
<script type="text/javascript">
function colorLed(num) {
    if (num == 0) {
        $.get("GetColorLed.do", {
            bled: encodeURI("蓝色LED"),
            rled: encodeURI("红色LED"),
            gled: encodeURI("绿色LED")
        }, function (data, textStatus) {
            var bmac = data.bmac;
            var rmac = data.rmac;
            var gmac = data.gmac;
            var titleHtml = "<div>您选择的是：彩色LED</div><br>";
            $("#resType").html(titleHtml);
            var txtHtml = "";
            if (bmac != "null" || rmac != "null" || gmac != "null") {
                txtHtml = "<div>蓝色LED:<br>" +
                        "<div class='slider' style='float: left;margin-right: 10px'></div>" +
                        "<div class='text' style='float: left;'></div>" +
                        "<input type='hidden' id='bmac' value='" + bmac + "'/></div>" +
                        "<br><br>" +
                        "<div>红色LED:<br>" +
                        "<div class='slider' style='float: left;margin-right: 10px'></div>" +
                        "<div class='text' style='float: left;'></div>" +
                        "<input type='hidden' id='rmac' value='" + rmac + "'/></div>" +
                        "<br><br>" +
                        "<div>绿色LED:<br>" +
                        "<div class='slider' style='float: left;margin-right: 10px'></div>" +
                        "<div class='text' style='float: left;'></div>" +
                        "<input type='hidden' id='gmac' value='" + gmac + "'/></div>";
                $("#resState").html(txtHtml);
            } else {
                txtHtml = "<div>该设备还没有开启！</div>";
                $("#resState").html(txtHtml);
            }

            slider();
        }, "json");
    } else if (num == 1) {
        $.get("GetColorLed.do", {
            bled: encodeURI("蓝色灯带"),
            rled: encodeURI("红色灯带"),
            gled: encodeURI("绿色灯带")
        }, function (data, textStatus) {
            var bmac = data.bmac;
            var rmac = data.rmac;
            var gmac = data.gmac;
            var titleHtml = "<div>您选择的是：彩色灯带</div><br>";
            $("#resType").html(titleHtml);
            var txtHtml = "";
            if (bmac != "null" || rmac != "null" || gmac != "null") {
                txtHtml = "<div>蓝色灯带:<br>" +
                        "<div class='slider' style='float: left;margin-right: 10px'></div>" +
                        "<div class='text' style='float: left;'></div>" +
                        "<input type='hidden' id='bmac' value='" + bmac + "'/></div>" +
                        "<br><br>" +
                        "<div>红色灯带:<br>" +
                        "<div class='slider' style='float: left;margin-right: 10px'></div>" +
                        "<div class='text' style='float: left;'></div>" +
                        "<input type='hidden' id='rmac' value='" + rmac + "'/></div>" +
                        "<br><br>" +
                        "<div>绿色灯带:<br>" +
                        "<div class='slider' style='float: left;margin-right: 10px'></div>" +
                        "<div class='text' style='float: left;'></div>" +
                        "<input type='hidden' id='gmac' value='" + gmac + "'/></div>";
                $("#resState").html(txtHtml);
            } else {
                txtHtml = "<div>该设备还没有开启！</div>";
                $("#resState").html(txtHtml);
            }

            slider();
        }, "json");
    }

}

function setColorLed(type, percent) {//type:蓝：0 红：1 绿：2
    $.post("SetColorLed.do", {
        bmac: $("#bmac").val(),
        rmac: $("#rmac").val(),
        gmac: $("#gmac").val(),
        type: type,
        percent: percent
    }, function (data, textStatus) {

    }, "json");

}
function slider() {
    $('.slider:eq(0)').jvslider({//蓝
        vertical: false,
        width: 200,
        barHeight: 15,
        barBorder: 1,
        barBorderColor: '#aaa',
        barRadius: 2,
        barBackground: '#fff',
        handleWidth: 10,
        handleHeight: 19,
        handleBorder: 1,
        handleBorderColor: '#aaa',
        handleRadius: 2,
        handleBackground: '#fff',
        handleDownBackground: '#eee',
        percent: 100,
        processBackground: '#09F',
        slide: function (percent) {
            var np = Math.round(percent);
            $('.text:eq(0)').html(np + "%");
            setColorLed(0, np);
        },
        click: function (percent) {
            var np = Math.round(percent);
            $('.text:eq(0)').html(np + "%");
            setColorLed(0, np);
        }
    });
    $('.slider:eq(1)').jvslider({//红
        vertical: false,
        width: 200,
        barHeight: 15,
        barBorder: 1,
        barBorderColor: '#aaa',
        barRadius: 2,
        barBackground: '#fff',
        handleWidth: 10,
        handleHeight: 19,
        handleBorder: 1,
        handleBorderColor: '#aaa',
        handleRadius: 2,
        handleBackground: '#fff',
        handleDownBackground: '#eee',
        percent: 100,
        processBackground: '#FF4D4D',
        slide: function (percent) {
            var np = Math.round(percent);
            $('.text:eq(1)').html(np + "%");
            setColorLed(1, np);
        },
        click: function (percent) {
            var np = Math.round(percent);
            $('.text:eq(1)').html(np + "%");
            setColorLed(1, np);
        }
    });
    $('.slider:eq(2)').jvslider({//绿
        vertical: false,
        width: 200,
        barHeight: 15,
        barBorder: 1,
        barBorderColor: '#aaa',
        barRadius: 2,
        barBackground: '#fff',
        handleWidth: 10,
        handleHeight: 19,
        handleBorder: 1,
        handleBorderColor: '#aaa',
        handleRadius: 2,
        handleBackground: '#fff',
        handleDownBackground: '#eee',
        percent: 100,
        processBackground: '#80FF80',
        slide: function (percent) {
            var np = Math.round(percent);
            $('.text:eq(2)').html(np + "%");
            setColorLed(2, np);
        },
        click: function (percent) {
            var np = Math.round(percent);
            $('.text:eq(2)').html(np + "%");
            setColorLed(2, np);
        }
    });
    //参数（全部为可选项）说明：
    //vertical: 是否使用纵向滑动条，默认false
    //width: 滑动区域宽度
    //barHeight: 滑动区域高度
    //barBorder: 滑动区域边框宽度
    //barBorderColor: 滑动区域边框颜色
    //barRadius: 滑动区域圆角
    //barBackground: 滑动区域背景
    //handleWidth: 滑块宽度
    //handleHeight: 滑块高度
    //handleBorder: 滑块边框宽度
    //handleBorderColor: 滑块边框颜色
    //handleRadius: 滑块圆角
    //handleBackground: 滑块背景
    //handleDownBackground: 滑块点击时背景
    //processBackground: 进度条背景
    //percent: 起始百分比
    //slide: 滑块滑动时调用程序
    //click: 点击滑动区域时调用程序
}

function led(num) {//普通LED显示
    $.get("GetLed.do", {
        name: encodeURI($(".led:eq(" + num + ")").val())
    }, function (data, textStatus) {
        var mac = data.mac;
        var name = data.name;
        name = decodeURI(name);
        var num = num;
        /*ar emptyHtml="<div></div>";
         $("#resState").html(emptyHtml);*/
        var titleHtml = "<div>您选择的是： &nbsp" + name + "</div><br>";
        $("#resType").html(titleHtml);
        var txtHtml = "";
        if (mac != "null") {
            txtHtml = "<input type='hidden' id='mac' value='" + mac + "'/>";
            txtHtml += "<div id='slider' style='float: left;margin-right: 10px'></div>" +
                    "<div id='text' style='float: left;'></div>";
            txtHtml += "<br><br><br><div>&nbsp&nbsp&nbsp";
            txtHtml += "<button onclick='setLed(100)'>&nbsp&nbsp亮&nbsp&nbsp</button>&nbsp&nbsp&nbsp" +
                    "<button onclick='setLed(0)'>&nbsp&nbsp灭&nbsp&nbsp</button>";
            txtHtml += "</div>";
            $("#resState").html(txtHtml);
        } else {
            txtHtml = "<div>该设备还没有开启！</div>";
            $("#resState").html(txtHtml);
        }
        $('#slider').jvslider({//显示滑动条
            vertical: false,
            width: 200,
            barHeight: 15,
            barBorder: 1,
            barBorderColor: '#aaa',
            barRadius: 2,
            barBackground: '#fff',
            handleWidth: 10,
            handleHeight: 19,
            handleBorder: 1,
            handleBorderColor: '#aaa',
            handleRadius: 2,
            handleBackground: '#fff',
            handleDownBackground: '#eee',
            percent: 100,
            processBackground: '#fc6',
            slide: function (percent) {
                var np = Math.round(percent);
                $('#text').html(np + "%");
                setLed(np);
            },
            click: function (percent) {
                var np = Math.round(percent);
                $('#text').html(np + "%");
                setLed(np);
            }


        });
    }, "json");
}
function setLed(percent) {
    $.post("SetLed.do", {
        mac: $("#mac").val(),
        percent: percent
    }, function (data, textStatus) {

    }, "json");
}


</script>
<script src="/scripts/jquery.msgbox.js" type="text/javascript"></script>
<link href="css/jquery.msgbox.css" type="text/css" rel="stylesheet"/>
<script src="/js/Type.js" type="text/javascript"></script>
<script src="/js/Switch.js" type="text/javascript"></script>
<%--<script src="/js/Alarm.js" type="text/javascript"></script>--%>
<%--<script src="/js/Voice.js" type="text/javascript"></script>--%>
</head>
<body>
<div id="logo"><a href="http://www.wsn.org.cn/" id="logoLink"></a></div>
<div id="nav">
    <ul>
        <li><a href="index01.jsp">家电系统</a></li>
        <li><a href="index02.jsp">电源系统</a></li>
        <li><a href="index03.jsp">环境系统</a></li>
        <li><a href="index04.jsp">安全系统</a></li>
        <li><a href="index05.jsp" style="background :url(Images/3.png)">照明系统</a></li>
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
            <img src="/Images/blueled_on.png" style="cursor: pointer" onclick="$('#button_1').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="led" id="button_1" value="蓝色LED" onclick="led(0)"
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
            <img src="/Images/redled_on.png" style="cursor: pointer" onclick="$('#button_2').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="led" id="button_2" value="红色LED" onclick="led(1)"
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
            <img src="/Images/greenled_on.png" style="cursor: pointer" onclick="$('#button_3').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="led" id="button_3" value="绿色LED" onclick="led(2)"
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
            <img src="/Images/lamp_on.png" style="cursor: pointer" onclick="$('#button_4').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="send" id="button_4" value="台灯" onclick="btnClick(0)"
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
            <img src="/Images/doorlight_on.png" style="cursor: pointer" onclick="$('#button_5').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="send" id="button_5" value="门灯1" onclick="btnClick(1)"
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
            <img src="/Images/doorlight_on.png" style="cursor: pointer" onclick="$('#button_6').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="send" id="button_6" value="门灯2" onclick="btnClick(2)"
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
            <img src="/Images/doorlight_on.png" style="cursor: pointer" onclick="$('#button_7').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="send" id="button_7" value="门灯3" onclick="btnClick(3)"
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
            <img src="/Images/bluedengdai_on.png" style="cursor: pointer" onclick="$('#button_8').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="led" id="button_8" value="蓝色灯带" onclick="led(3)"
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
            <img src="/Images/reddengdai_on.png" style="cursor: pointer" onclick="$('#button_9').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="led" id="button_9" value="红色灯带" onclick="led(4)"
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
            <img src="/Images/greendengdai_on.png" style="cursor: pointer" onclick="$('#button_10').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="led" id="button_10" value="绿色灯带" onclick="led(5)"
                      onmouseover="this.style.backgroundPosition='left -25px'"
                      onmouseout="this.style.backgroundPosition='left top'"
                      onmousedown="this.style.backgroundPosition='left -50px'"
                      onmouseup="this.style.backgroundPosition='left -25px'"
                    /></p>
        </div>
    </div>
    <%--*new*--%>
    <%--<div class="content0">
        <div class="content00">
            <img src="/Images/dengdai.png" style="cursor: pointer" onclick="$('#button_11').click()">
        </div>
        <div class="content01">
            <p><input type="button" class="led" id="button_11" value="灯带" onclick="led(9)"
                      onmouseover="this.style.backgroundPosition='left -25px'"
                      onmouseout="this.style.backgroundPosition='left top'"
                      onmousedown="this.style.backgroundPosition='left -50px'"
                      onmouseup="this.style.backgroundPosition='left -25px'"
                    /></p>
        </div>
    </div>--%>
    <%--6--%>
    <div class="content0">
        <div class="content00">
            <img src="/Images/colorled_on.png" style="cursor: pointer" onclick="$('#button_12').click()">
        </div>
        <div class="content01">
            <p><input class="color" type="button" id="button_12" value="彩色LED" onclick="colorLed(0)"
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
            <img src="/Images/colordengdai_on.png" style="cursor: pointer" onclick="$('#button_13').click()">
        </div>
        <div class="content01">
            <p><input class="color" type="button" id="button_13" value="彩色灯带" onclick="colorLed(1)"
                      onmouseover="this.style.backgroundPosition='left -25px'"
                      onmouseout="this.style.backgroundPosition='left top'"
                      onmousedown="this.style.backgroundPosition='left -50px'"
                      onmouseup="this.style.backgroundPosition='left -25px'"
                    /></p>
        </div>
    </div>

</div>
<div id="contentR">
    <h1>照明系统</h1>
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