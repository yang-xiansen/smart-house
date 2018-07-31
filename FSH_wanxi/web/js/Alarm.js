/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-23
 * Time: 下午3:53
 * 10s检测 报警
 * To change this template use File | Settings | File Templates.
 */


/*function all1(num){
    alert("No."+num);
    setTimeout("all1(1)",1000);
}
all1(1);*/
/*$(function(){
    function all(num){
        alert("No."+num);
        num++;
        setInterval("all(1)",1000);
    }
    all(1);


});*/
    /*----1----*/
    function smokeAlarm(){
        $.get("GetSRSAlert.do",{
            name : encodeURI("烟雾")
        }, function(data, textStatus) {
            var name = data.name;
            name = decodeURI(name);
            var state=data.state;
            var realTimeData=data.realTimeData;
            var realData=realTimeData.split("\t");
            var value=realData[2];
            if(value<532){
                Alarm1(name,"冒烟了！");
                /*alert(name);*/
            }
        },"json");
        setTimeout("smokeAlarm()",3000);//10s刷新
    }
    /*----2----*/
    function gasAlarm(){
        $.get("GetSRSAlert.do",{
            name : encodeURI("燃气")
        }, function(data, textStatus) {
            var name = data.name;
            name = decodeURI(name);
            var state=data.state;
            var realTimeData=data.realTimeData;
            var realData=realTimeData.split("\t");
            var value=realData[2];
            if(value<950){
                Alarm1(name,"漏气了！");
                /*alert(name);*/
            }
        },"json");
        setTimeout("gasAlarm()",3000);//10s刷新
    }
    /*----3----*/
    function noiseAlarm(){
        $.get("GetSRSAlert.do",{
            name : encodeURI("噪声")
        }, function(data, textStatus) {
            var name = data.name;
            name = decodeURI(name);
            var state=data.state;
            var realTimeData=data.realTimeData;
            var realData=realTimeData.split("\t");
            var value=realData[2];
            if(value>1488){
                Alarm1(name,"吵死了！");
                /*alert(name);*/
            }
        },"json");
        setTimeout("noiseAlarm()",3000);//10s刷新
    }
    /*----4----*/
    function fireAlarm(){
        $.get("GetSRSAlert.do",{
            name : encodeURI("火焰")
        }, function(data, textStatus) {
            var name = data.name;
            name = decodeURI(name);
            var state=data.state;
            var realTimeData=data.realTimeData;
            var realData=realTimeData.split("\t");
            var value=realData[2];
            if(value<976){
                Alarm1(name,"着火了！");
                /*alert(name);*/
            }
        },"json");
        setTimeout("fireAlarm()",3000);//10s刷新
    }
    /*----5----*/
    function rainAlarm(){
        $.get("GetSRSAlert.do",{
            name : encodeURI("雨滴")
        }, function(data, textStatus) {
            var name = data.name;
            name = decodeURI(name);
            var state=data.state;
            if(state==1){
                Alarm1(name,"下雨了！");
                /*alert(name);*/
            }
        },"json");
        setTimeout("rainAlarm()",1000);//10s刷新
    }
    /*----6----*/
    function glassAlarm(){
        $.get("GetSRSAlert.do",{
            name : encodeURI("玻璃破碎")
        }, function(data, textStatus) {
            var name = data.name;
            name = decodeURI(name);
            var state=data.state;
            if(state==1){
                Alarm1(name,"玻璃碎了！");
                /*alert(name);*/
            }
        },"json");
        setTimeout("glassAlarm()",1000);//10s刷新
    }

    smokeAlarm();
    gasAlarm();
    noiseAlarm();
    fireAlarm();

function Alarm1(chr1,chr2){//提醒
    var name=chr1;
    var state=chr2;
    $.msgbox({
        autoClose:10,
        /*closeImg: 'close.gif',*/
        height:163,
        width:386,
        title:'来自 '+chr1+' 的提醒：',
        content:'<br>'+chr1+": "+chr2+'<br><br>',
        type :'alert'
    });
}

    /*rainAlarm();*/
    /*glassAlarm();*/
