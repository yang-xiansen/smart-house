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
var rfidkm = 0;//RFID全局变量，确定是否勾选提醒
var lastkm = "empty";
var rfidcs = 0;//RFID全局变量，确定是否勾选提醒
var lastcs = "empty";

$(function () {//网页自动加载函数
    RFIDAutoAlert();
});

function RFIDAutoAlert() {
    if (rfidkm == 1) {
        $.get("RFID.do", {
            name: encodeURI("RFID开门"),
            type: encodeURI("RFID")
        }, function (data, textStatus) {
            var cardName = data.cardName;
            cardName = decodeURI(cardName);
            var realData = data.Date;
            var ID = data.ID;
            var dateAndTime = realData.split("T");
            var date = dateAndTime[0];
            var time = dateAndTime[1];
            if (lastkm != realData) {
                lastkm = realData;
                RFIDAlarm(date, time, ID, cardName, "RFID开门");
            }
        }, "json");
    }
    if (rfidcs == 1) {
        $.get("RFID.do", {
            name: encodeURI("RFID测试"),
            type: encodeURI("RFID")
        }, function (data, textStatus) {
            var cardName = data.cardName;
            cardName = decodeURI(cardName);
            var realData = data.Date;
            var ID = data.ID;
            var dateAndTime = realData.split("T");
            var date = dateAndTime[0];
            var time = dateAndTime[1];
            if (lastcs != realData) {
                lastcs = realData;
                RFIDAlarm(date, time, ID, cardName, "RFID测试");
            }
        }, "json");
    }
    setTimeout("RFIDAutoAlert()", 1000);//1s
}
function RFIDAlarm(date, time, ID, cardName, name) {//提醒
    $.msgbox({
        autoClose: 10,
        /*closeImg: 'close.gif',*/
        height: 240,
        width: 386,
        title: '来自 ' + name + ' 的刷卡提醒：',
        content: '日期: ' + date + '<br>' +
                '<br>时间: ' + time + '<br>' +
                '<br>卡号: ' + ID + '<br>' +
                '<br>持卡人: ' + cardName + '<br>',
        type: 'alert'
    });
}

function RFID(num) {
    var name =$(".RFID:eq(" + num + ")").val();
    var optionHtml = "<div>您选择的是:&nbsp " + name + "</div><br>";
    optionHtml += "<div>";
    if (name == "RFID开门") {
        if (rfidkm == 1) {
            optionHtml += "<input type='checkbox' id='alarm' onclick='setRFIDAlarm(" + num + ")' checked/><label for='everyDay'>&nbsp是否提醒</label>";
        } else {
            optionHtml += "<input type='checkbox' id='alarm' onclick='setRFIDAlarm(" + num + ")'/><label for='everyDay'>&nbsp是否提醒</label>";
        }
    } else if (name == "RFID测试") {
        if (rfidcs == 1) {
            optionHtml += "<input type='checkbox' id='alarm' onclick='setRFIDAlarm(" + num + ")' checked/><label for='everyDay'>&nbsp是否提醒</label>";
        } else {
            optionHtml += "<input type='checkbox' id='alarm' onclick='setRFIDAlarm(" + num + ")'/><label for='everyDay'>&nbsp是否提醒</label>";
        }
    }
    optionHtml += "<font size=2 style='margin-left: 20px;color: #999'>提示：提醒仅本页有效</font></div><br>" +
            "<button onclick='getData(" + num + ")'>查看记录</button><br>";
    $("#resType").html(optionHtml);
    var emptyHtml="<div></div>";
    $("#resState").html(emptyHtml);
    realData(num);
    /*setTimeout("RFID("+num+")", 5000);//5s刷新*/
}
function realData(num) {
    $.get("RFID.do", {
        name: encodeURI($(".RFID:eq(" + num + ")").val()),
        type: encodeURI("RFID")
    }, function (data, textStatus) {
        var cardName = data.cardName;
        cardName = decodeURI(cardName);
        var realData = data.Date;
        var ID = data.ID;
        var txtHtml = "";
        if (realData == "empty") {
            txtHtml = "<br><div>今日无刷卡记录！</div><br>";
        } else {
            var dateAndTime = realData.split("T");
            var date = dateAndTime[0];
            var time = dateAndTime[1];
            txtHtml = "<br><div>今日最后一次刷卡记录:</div><br>" +
                    "<div>日期：" + date + "</div><br>" +
                    "<div>时间：" + time + "</div><br>" +
                    "<div>卡号：" + ID + "</div><br>" +
                    "<div>持卡人：" + cardName + "</div>";
        }
        $("#resTimeInfo").html(txtHtml);
    }, "json");

}

var all = "";
function getData(num) {//输入日期，得到记录
    var name = $(".RFID:eq(" + num + ")").val();
    $.msgbox({
        height: 200,
        width: 386,
        content: '<br>请输入日期: ' +
                '<br><font size=2 style="color: #999">示范 20140101：表示2014年01月01日</font><br>',
        type: 'input',
        title: name + ':请输入要查询记录的日期',
        onInputed: function (date) {
            $.get("GetRfidData.do", {
                name: encodeURI(name),
                date: date
            }, function (data, textStatus) {
                var detailAll = data.detailAll;
                var num = data.num;
                detailAll = decodeURI(detailAll);
                var re1 = new RegExp("m", "g");//正则表达式
                var re2 = new RegExp("tr1", "g");
                var re3 = new RegExp("tr2", "g");
                var re4 = new RegExp("td1", "g");
                var re5 = new RegExp("td2", "g");
                detailAll = detailAll.replace(re1, ":");
                detailAll = detailAll.replace(re2, "<tr>");
                detailAll = detailAll.replace(re3, "</tr>");
                detailAll = detailAll.replace(re4, "<td>");
                detailAll = detailAll.replace(re5, "</td>");
                getDetailAll(detailAll, date, num);
            }, "json");
        }
    });
}
function getDetailAll(detailAll, date, num) {
    $.msgbox({
        /*autoClose:10,*/
        /*closeImg: 'close.gif',*/
        height: 895,
        width: 500,
        title: '日期为 ' + date + ' 的刷卡记录',
        content: "<table border='1' style='width:400px;color: #000000;border-collapse:separate;separate;border-spacing:1px'>" +
                "<caption><b>" + date + " 刷卡记录</b></caption>" +
                "<thead>" +
                "<tr>" +
                "<th>时间</th>" +
                "<th>卡号</th>" +
                "<th>持卡人</th>" +
                "</tr>" +
                "</thead>" +
                "<tfoot>" +
                "<tr>" +
                "<td colspan='3' style='text-align:right'>现总计：" + num + "条记录</td>" +
                "</tr>" +
                "</tfoot>" +
                "<tbody style='font: 14'>" +
                detailAll +
                "</tbody>" +
                "</table>",
        type: 'alert'
    });
}
function setRFIDAlarm(num) {
    var name = $(".RFID:eq(" + num + ")").val();
    var optionHtml = "<div>您选择的是:&nbsp " + name + "</div><br>";
    optionHtml += "<div>";
    if ($("#alarm").attr("checked")) {
        if (name == "RFID开门") {
            rfidkm = 1;
        } else if (name == "RFID测试") {
            rfidcs = 1;
        }
        optionHtml += "<input type='checkbox' id='alarm' onclick='setRFIDAlarm(" + num + ")' checked/><label for='everyDay'>&nbsp是否提醒</label>";
    } else {
        if (name == "RFID开门") {
            rfidkm = 0;
        } else if (name == "RFID测试") {
            rfidcs = 0;
        }
        optionHtml += "<input type='checkbox' id='alarm' onclick='setRFIDAlarm(" + num + ")'/><label for='everyDay'>&nbsp是否提醒</label>";
    }
    optionHtml += "<font size=2 style='margin-left: 20px;color: #999'>提示：提醒仅本页有效</font></div><br>" +
            "<button onclick='getData(" + num + ")'>查看记录</button><br>";
    $("#resType").html(optionHtml);
}
</script>
<script src="/js/Type.js" type="text/javascript"></script>
<script src="/js/Switch.js" type="text/javascript"></script>
<%--<script src="/js/Alarm.js" type="text/javascript"></script>--%>
</head>
<body>
<div id="logo"><a href="http://www.wsn.org.cn/" id="logoLink"></a></div>
<div id="nav">
    <ul>
        <li><a href="index01.jsp">家电系统</a></li>
        <li><a href="index02.jsp">电源系统</a></li>
        <li><a href="index03.jsp">环境系统</a></li>
        <li><a href="index04.jsp">安全系统</a></li>
        <li><a href="index05.jsp">照明系统</a></li>
        <li><a href="index06.jsp">节能系统</a></li>
        <li><a href="index07.jsp">视频系统</a></li>
        <%--<li><a href="http://192.168.1.222/" target="_blank">视频系统</a></li>--%>
        <li><a href="index08.jsp" style="background :url(Images/3.png)">门禁系统</a></li>
    </ul>
</div>

<div id="content">
    <div id="contentL">
        <%--1--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/door_on.png" style="cursor: pointer" onclick="$('#button_1').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="send" id="button_1" value="磁力锁" onclick="btnClick(0)"
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
                <img src="/Images/rfid_normal.png" style="cursor: pointer" onclick="$('#RFID1').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="RFID" id="RFID1" value="RFID开门" onclick="RFID(0)"
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
                <img src="/Images/rfid_normal.png" style="cursor: pointer" onclick="$('#RFID2').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="RFID" id="RFID2" value="RFID测试" onclick="RFID(1)"
                          onmouseover="this.style.backgroundPosition='left -25px'"
                          onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'"
                          onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>




    </div>
    <div id="contentR">
        <h1>门禁系统</h1>
        <BR>
        <BR>
        <div id="resType"></div>
        <div id="resState"></div>
        <div id="resTimeInfo"></div>
        <br>
    </div>
</div>
</body>
</html>