<%--
<%--
  Created by IntelliJ IDEA.
  User: StevenH
  Date: 13-9-25
  Time: 下午5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>智能家居</title>
    <link href="css/style.css" type="text/css" rel="stylesheet"/>

    <script src="/scripts/jquery-1.3.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function timeClick(num){//定时设备的 初始化
            $.get("Type.do",{
                name:encodeURI($(".conTime:eq("+num+")").val())
            },function(data,textStatus){
                var name=data.name;
                var mac=data.mac;
                var emptyHtml="<div></div>";
                var eve=0;
                name = decodeURI(name);
                $("#resTimeInfo").html(emptyHtml);
                $("#resState").html(emptyHtml);//清空不需要的信息
                var txtHtml="<div>您选择的是: "+name+"<br><br></div>";
                $("#resType").html(txtHtml);
                var txt1Html="";
                if(mac!="null"){
                    txt1Html="<input type='checkbox' id='everyDay' onclick='everydayClick()'/>" +
                            "<label for='everyDay'> &nbsp 每天生效</label>"+
                            "<div><br>日期:&nbsp<input type='text' id='date' placeholder='请输入日期'>"+
                            "<br><font size=2 style='margin-left: 40px;color: #999'>示范 20140101：表示2014年01月01日</font>"+
                            "<br>时间:&nbsp<input type='text' id='time' placeholder='请输入时间'>"+
                            "<br><font size=2 style='margin-left: 40px;color: #999'>示范 1830：表示18点30分（24小时制）</font>"+
                            "<input type='hidden' id='param0' value='"+ name +"'/>"+
                            "<input type='hidden' id='param1' value='"+ data.mac +"'/>"+
                            "<input type='hidden' id='param2' value='"+ eve +"'/>"+//隐藏信息
                            "<br>模式:&nbsp<input type='radio' name='radiobutton' value='1' checked> 打开"+
                            "&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp"+
                            "<input type='radio' name='radiobutton' value='0'> 关闭"+
                            "<br><br><button onclick='subClick()'>提交</button>"+
                            "&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp"+
                            "<button onclick='getTimeInfo()'>查看定时</button></div><br>";
                    $("#resSetTime").html(txt1Html);
                }else{
                    txt1Html="<div>该设备还没有开启！</div>";
                    $("#resSetTime").html(txt1Html);
                }
            },"json");
            /*setTimeout("getTimeInfo()",100);//加载定时查看框*/
        }
        function getTimeInfo(){// 查看该设备定时 执行
            $.post("GetTimeInfo.do",{
                mac:$("#param1").val()
            },function(data,textStatus){
                var mac=data.mac;
                var msg=data.msg;
                var lineInfo="";
                var infoHtml="<div>该设备所有定时信息如下：&nbsp&nbsp&nbsp<button onclick='getTimeInfo()'>刷新</button>"+
                        " &nbsp &nbsp &nbsp &nbsp<button onclick='delDevTime()'>清空定时</button>" +
                        "<input type='hidden' id='devMAC' value='"+ mac +"'/>"+ //传递MAC 用来指定清空定时的设备
                        "</div><br>";
                infoHtml+="<div style='width:380px;height:300px; overflow-y:scroll; border:1px solid;'>";

                var arrayString=msg.split("\n\n");

                for(var i=1;i<data.num;i++){
                    lineInfo+="<div>";
                    var group=arrayString[i-1].split("\n");
                    for(var j=0;j<group.length;j++){
                        var oneline=group[j].split(":");
                        if(oneline.length>1){
                            lineInfo+="<input type='hidden' class='"+oneline[0]+"' value='"+oneline[1]+"'/>";//隐藏信息传递
                            /*lineInfo+=oneline[0];*/
                            if(oneline[0]=="NO."){
                                lineInfo+="第"+oneline[1]+"条:";
                                lineInfo+="&nbsp";
                            }
                            if(oneline[0]=="DATE"){
                                lineInfo+="日期:&nbsp";
                                if(oneline[1]=="null"){
                                    lineInfo+="每天";
                                    lineInfo+="&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp";
                                }else{
                                    lineInfo+=oneline[1];
                                    lineInfo+="&nbsp &nbsp";
                                }

                            }
                            if(oneline[0]=="TIME"){
                                lineInfo+="时间:&nbsp"+oneline[1];
                                lineInfo+="&nbsp &nbsp";
                            }
                            if(oneline[0]=="STATE"){
                                lineInfo+="状态:&nbsp";
                                if(oneline[1]=="ON"){
                                    lineInfo+="开";
                                }else if(oneline[1]=="OFF"){
                                    lineInfo+="关";
                                }
                                lineInfo+="&nbsp &nbsp";
                            }
                        }
                    }
                    /*lineInfo+=arrayString[i-1];*/
                    var num=i-1;
                    lineInfo+="<button onclick='deleteTimeClick("+num+")'>删除</button>";
                    lineInfo+="</div><br>";
                }
                infoHtml+="<br>"+lineInfo;
                infoHtml+="</div>";
                $("#resTimeInfo").html(infoHtml);//加载定时查看框

            },"json")
        }
        function deleteTimeClick(num){//删除 指定定时
            $.post("DeleteTime.do",{
                mac:$(".MAC:eq("+num+")").val(),
                date:$(".DATE:eq("+num+")").val(),
                time:$(".TIME:eq("+num+")").val()
            },function(data,textStatus){

            },"json");
            setTimeout("getTimeInfo()",100);//加载定时查看框
        }
        function delDevTime(){//删除单一设备的所有定时 清空定时
            $.post("DelDevTime.do",{
                mac:$("#devMAC").val()
            },function(data,textStatus){

            },"json");
            setTimeout("getTimeInfo()",100);//加载定时查看框
        }
        function everydayClick(){//勾选每天后执行
            $.get("Type.do",{
                name:encodeURI($("#param0").val())
            },function(data,textStatus){
                var name=data.name;
                var emptyHtml="<div></div>";
                name = decodeURI(name);
                var eve=1;
                var txtHtml="<div>您选择的是: "+name;
                if($("#everyDay").attr("checked")){
                     txtHtml+="<br><br><input type='checkbox' id='everyDay' onclick='everydayClick()' checked/><label for='everyDay'>&nbsp每天生效</label>" +
                            "<br><br>日期:&nbsp<input type='text' id='date' disabled=true placeholder='请输入日期'>";
                    eve=1;
                }else{
                     txtHtml+="<br><br><input type='checkbox' id='everyDay' onclick='everydayClick()'/><label for='everyDay'>&nbsp每天生效</label>" +
                            "<br><br>日期:&nbsp<input type='text' id='date' placeholder='请输入日期'>";
                    eve=0;
                }
                $("#resType").html(emptyHtml);
                $("#resState").html(emptyHtml);//清空不需要的信息
                txtHtml+="<br><font size=2 style='margin-left: 40px;color: #999'>示范 20140101：表示2014年01月01日</font>"+
                        "<br>时间:&nbsp<input type='text' id='time' placeholder='请输入时间'>"+
                        "<br><font size=2 style='margin-left: 40px;color: #999'>示范 1830：表示18点30分（24小时制）</font>"+
                        "<input type='hidden' id='param0' value='"+ name +"'/>"+
                        "<input type='hidden' id='param1' value='"+ data.mac +"'/>"+
                        "<input type='hidden' id='param2' value='"+ eve +"'/>"+//隐藏信息
                        "<br>模式:&nbsp<input type='radio' name='radiobutton' value='1' checked> 打开"+
                        "&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp"+
                        "<input type='radio' name='radiobutton' value='0'> 关闭"+
                        "<br><br><button onclick='subClick()'>提交</button>"+
                        "&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp"+
                        "<button onclick='getTimeInfo()'>查看定时</button></div><br>";
                $("#resSetTime").html(txtHtml);
            },"json");
            /*setTimeout("getTimeInfo()",100);//加载定时查看框*/
        }
        function subClick(){//点提交后执行
            $.post("SetTime.do",{
                mac:$("#param1").val(),
                eve:$("#param2").val(),
                state:$('input:radio[name="radiobutton"]:checked').val(),
                date:$("#date").val(),
                time:$("#time").val()
        },function(data,textStatus){

            },"json");
            setTimeout("getTimeInfo()",100);//加载定时查看框
        }



        //以上为止定时功能函数结束

        //以下为自动控制
        function autoClick(num){//自动的初始化
            $.get("Auto.do",{
                name:encodeURI($(".conAuto:eq("+num+")").val())
            },function(data,textStatus){
                var name=data.name;
                var mac=data.mac;
                var type=data.type;
                name = decodeURI(name);
                mac=decodeURI(mac);
                var emptyHtml="<div></div>";
                $("#resSetTime").html(emptyHtml);
                $("#resState").html(emptyHtml);
                $("#resTimeInfo").html(emptyHtml);//清空不需要的信息
                var txtHtml0="<div>您选择的是: "+name +
                        "<input type='hidden' id='autoName' value='"+ name +"'/>" +
                        "<input type='hidden' id='autoMac' value='"+ mac +"'/>" +
                        "<input type='hidden' id='autoType' value='"+ type +"'/>"+
                        "</div><br>";
                if(mac!="null"){
                    if(name.indexOf('声光报警') != -1){
                        txtHtml0+="控制:&nbsp&nbsp&nbsp";
                        txtHtml0+="<button class='switch' onclick='setCurtain("+0+")'>&nbsp&nbsp开&nbsp&nbsp</button>&nbsp&nbsp" +
                                "<button class='switch' onclick='setCurtain("+1+")'>&nbsp&nbsp关&nbsp&nbsp</button><br><br>" ;
                    }
                    $("#resType").html(txtHtml0);
                    chooseAuto(2);
                }else{
                    txtHtml0+="<div>该设备还没有开启！</div>";
                    $("#resType").html(txtHtml0);
                }

            },"json");
        }
        function setCurtain(num){
            $.post("Curtain.do",{
                num:num,
                mac : $("#autoMac").val()
            },function(data,textStatus){

            },"json")
        }
        function chooseAuto(num){//根据设备的 #名称# #状态# 选择 不同的自动开启
            var name=$("#autoName").val();
            var state=num;
            if (name=='窗帘'){
                if(state==0){//状态是 0 关 要求 打开自动
                    curtain();
                }
                if(state==1){//状态是 1 开 要求 关闭自动
                    closeDataAuto();
                }
                if(state==2){//状态是 2 查询 要求 查询自动
                    getDataAutoInfo();
                }
            }
            if (name=='风扇'){
                if(state==0){
                    fan();
                }
                if(state==1){
                    closeDataAuto();
                }
                if(state==2){
                    getDataAutoInfo();
                }
            }
            if (name=='门灯'){
                if(state==0){
                    doorLight();
                }
                if(state==1){
                    closeEventAuto();
                }
                if(state==2){
                    getEventAutoInfo();
                }
            }
            if (name=='空调'){
                if(state==0){
                    air();
                }
                if(state==1){
                    closeDataAuto();
                    closeEventAuto();
                }
                if(state==2){
                    getEventAutoInfo();
                }
            }
            if (name=='电视开关'){
                if(state==0){
                    TV();
                }
                if(state==1){
                    closeEventAuto();
                }
                if(state==2){
                    getEventAutoInfo();
                }
            }
            if(name=='磁力锁'){
                if(state==0){
                    door();
                }
                if(state==1){
                    closeEventAuto();
                }
                if(state==2){
                    getEventAutoInfo();
                }
            }
            if(name=='声光报警'){
                if(state==0){
                     sgbj();
                }
                if(state==1){
                    closeEventAuto();
                }
                if(state==2){
                    getEventAutoInfo();
                }
            }
        }

        function getEventAutoInfo(){//重新 加载 事件自动状态 信息所用
            $.get("GetEventAuto.do",{
                mac:encodeURI($("#autoMac").val())
            },function(data,textStatus){
                var state=data.state;
                var emptyHtml="<div></div>";
                $("#resSetTime").html(emptyHtml);
                $("#resTimeInfo").html(emptyHtml);//清空不需要的信息
                var txtHtml="<div>自动控制状态：";
                if(state==1){
                    txtHtml+="&nbsp 已开启</div><br>";
                    txtHtml+="<div><button onclick='chooseAuto(1)'>关闭自动</button>";
                }else if(state==0){
                    txtHtml+="&nbsp 已关闭</div><br>";
                    txtHtml+="<div><button onclick='chooseAuto(0)'>开启自动</button>";
                }
                txtHtml+="</div><br>";
                $("#resState").html(txtHtml);
            },"json");
        }
        function getDataAutoInfo(){//重新 加载 数据自动状态 信息所用
            $.get("GetDataAuto.do",{
                mac:encodeURI($("#autoMac").val())
            },function(data,textStatus){
                var state=data.state;
                var emptyHtml="<div></div>";
                $("#resSetTime").html(emptyHtml);
                $("#resTimeInfo").html(emptyHtml);//清空不需要的信息
                var txtHtml="<div>自动控制状态：";
                if(state==1){
                    txtHtml+="&nbsp 已开启</div><br>";
                    txtHtml+="<div><button onclick='chooseAuto(1)'>关闭自动</button>";
                }else if(state==0){
                    txtHtml+="&nbsp 已关闭</div><br>";
                    txtHtml+="<div><button onclick='chooseAuto(0)'>开启自动</button>";
                }
                txtHtml+="</div><br>";
                $("#resState").html(txtHtml);
            },"json");
        }
        function closeDataAuto(){//关闭 数据触发 的自动
            $.post("DelAuto.do",{
                mac:$("#autoMac").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框

        }
        function closeEventAuto(){//关闭 事件触发 的自动
            $.post("DelEventAuto.do",{
                mac:$("#autoMac").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框
        }

        function fan(){//电风扇的自动--------------------------------------讨论
            $.post("SetFanAuto.do",{
                mac:$("#autoMac").val(),
                type:$("#autoType").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框
        }

        function curtain(){//窗帘的自动--------------------------------------讨论
            $.post("SetCurtainAuto.do",{
                mac:$("#autoMac").val(),
                type:$("#autoType").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框
        }

        function TV(){//电视机开关的自动--------------------------------------讨论
            $.post("SetTVAuto.do",{
                mac:$("#autoMac").val(),
                type:$("#autoType").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框
        }

        function doorLight(){//门灯的自动--------------------------------------讨论
            $.post("SetDoorLightAuto.do",{
                mac:$("#autoMac").val(),
                type:$("#autoType").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框
        }
        function air(){//空调的自动--------------------------------------讨论
            $.post("SetAirAuto.do",{
                mac:$("#autoMac").val(),
                type:$("#autoType").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框
        }
        function door(){//门磁的自动--------------------------------------
            $.post("SetDoorAuto.do",{
                mac:$("#autoMac").val(),
                type:$("#autoType").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框
        }
        function sgbj(){//声光报警的自动--------------------------------------
            $.post("SetSGAuto.do",{
                mac:$("#autoMac").val(),
                type:$("#autoType").val()
            },function(data,textStatus){

            },"json");
            setTimeout("chooseAuto(2)",100);//重新加载自动查看框
        }

        function getAmmeter(){
            $.get("GetName.do", {//
                name : encodeURI("智能电表")
            }, function(data, textStatus) {
                var name = data.name;
                name = decodeURI(name);
                var type=data.type;
                var txtHtml = "<div>您选择的是:" + name + "</div><br>";
                txtHtml+="<input type='hidden' id='sensorName' value='"+ name +"'/>" +
                        "<input type='hidden' id='sensorType' value='"+ type +"'/>";
                $("#resType").html(txtHtml); // 把返回的数据添加到页面上
                var emptyHtml="<div></div>";
                $("#resState").html(emptyHtml);
            },"json");
            setTimeout("realTimeData()",100);
        }
        function realTimeData(){
            if($("#sensorType").val()!="null"){
                $.get("GetRealTime.do",{
                    name : encodeURI($("#sensorName").val()),
                    type : encodeURI($("#sensorType").val())
                }, function(data, textStatus) {
                    var name = data.name;
                    name = decodeURI(name);
                    /*alert(name);*/
                    var realTimeData=data.realTimeData;
                    var realData=realTimeData.split("\t");
                    var value=realData[2];
                    var dateAndTime=realData[0].split("T");
                    var date=dateAndTime[0];
                    var time=dateAndTime[1];
                    var txtHtml="<div>日期："+date+"</div><br>"+
                            "<div>时间："+time+"</div><br>"+
                            "<div>数值："+value+"度</div>";
                    $("#resState").html(txtHtml);
                },"json");
                setTimeout("realTimeData()",5000);//5s刷新
            }else{
                var txtHtml="<div>该设备还没有开启！</div>";
                $("#resState").html(txtHtml);
            }

        }

    </script>
    <script src="/scripts/jquery.msgbox.js" type="text/javascript"></script>
    <link href="css/jquery.msgbox.css" type="text/css" rel="stylesheet"/>
    <script src="/js/Type.js" type="text/javascript"></script>
    <script src="/js/Switch.js" type="text/javascript"></script>
<%--    <script src="/js/Alarm.js" type="text/javascript"></script>
    <script src="/js/Voice.js" type="text/javascript"></script>--%>

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
        <li><a href="index06.jsp" style="background :url(Images/3.png)">节能系统</a></li>
        <li><a href="index07.jsp">视频系统</a></li>
        <%--<li><a href="http://192.168.1.222/" target="_blank">视频系统</a></li>--%>
        <li><a href="index08.jsp">门禁系统</a></li>
    </ul>
</div>

<div id="content">
    <div id="contentL">
        <div class="contentUp">
            <div class="contentTitle"><h3> &nbsp &nbsp定时功能：</h3></div>
            <div class="contentButton">
                <%--<input type="button" value="关闭所有定时功能" onclick="delAllTime()">--%>
            </div>
        </div>
        <%--1--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/water_on.png" style="cursor: pointer" onclick="$('#button_1').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conTime" id="button_1" value="饮水机" onclick="timeClick(0)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--2--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/fan_on.png" style="cursor: pointer" onclick="$('#button_2').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conTime" id="button_2" value="风扇" onclick="timeClick(1)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--3--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/fridge_on.png" style="cursor: pointer" onclick="$('#button_3').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conTime" id="button_3" value="电冰箱" onclick="timeClick(2)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>

        <div class="contentUp">
            <div class="contentTitle"><h3> &nbsp &nbsp自动控制：</h3></div>
            <div class="contentButton">
                <%--<input type="button" value="关闭所有自动控制">--%>
            </div>
        </div>
        <%--4--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/curtain_on.png" style="cursor: pointer" onclick="$('#button_4').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conAuto" id="button_4" value="窗帘" onclick="autoClick(0)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--5--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/fan_on.png" style="cursor: pointer" onclick="$('#button_5').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conAuto" id="button_5" value="风扇" onclick="autoClick(1)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--6--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/air_on.png" style="cursor: pointer" onclick="$('#button_6').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conAuto" id="button_6" value="空调" onclick="autoClick(2)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--7--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/tv_on.png" style="cursor: pointer" onclick="$('#button_7').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conAuto" id="button_7" value="电视开关" onclick="autoClick(3)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--8--%>
        <%--<div class="content0">&lt;%&ndash;//--------------------------------------------------&ndash;%&gt;
            <div class="content00">
                <img src="/Images/doorlight_on.png" style="cursor: pointer" onclick="$('#button_8').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conAuto" id="button_8" value="门灯" onclick="autoClick(4)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>--%>
        <%--9--%>
        <div class="content0"><%--//----------------------------------------------------%>
            <div class="content00">
                <img src="/Images/door_on.png" style="cursor: pointer" onclick="$('#button_9').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conAuto" id="button_9" value="磁力锁" onclick="autoClick(4)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--10--%>
        <div class="content0"><%--//-----------------------------------------------%>
            <div class="content00">
                <img src="/Images/shengguang_normal.png" style="cursor: pointer" onclick="$('#AlarmSwitch').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conAuto" id="AlarmSwitch" value="声光报警" onclick="autoClick(5)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div><%--/*alarmSwitch()*/--%>
        </div>
        <%--11--%>
        <div class="content0">
            <div class="content00">
                <img src="/Images/ammeter_normal.png" style="cursor: pointer" onclick="$('#button_10').click()">
            </div>
            <div class="content01">
                <p><input type="button" id="button_10" value="智能电表" onclick="getAmmeter()"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div>
        </div>
        <%--12--%>
        <div class="content0"><%--//-----------------------------------------------%>
            <div class="content00">
                <img src="/Images/shengguang_normal.png" style="cursor: pointer" onclick="$('#AlarmSwitch1').click()">
            </div>
            <div class="content01">
                <p><input type="button" class="conAuto" id="AlarmSwitch1" value="声光报警1" onclick="autoClick(6)"
                          onmouseover="this.style.backgroundPosition='left -25px'" onmouseout="this.style.backgroundPosition='left top'"
                          onmousedown="this.style.backgroundPosition='left -50px'" onmouseup="this.style.backgroundPosition='left -25px'"
                        /></p>
            </div><%--/*alarmSwitch()*/--%>
        </div>
    </div>
    <div id="contentR">
        <h1>节能系统</h1>
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
        <div id="resType" ></div>
        <div id="resState" ></div>
        <div id="resSetTime"></div>
        <div id="resTimeInfo"></div>
        <br>
    </div>
</div>
</body>
</html>