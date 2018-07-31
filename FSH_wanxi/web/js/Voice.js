/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-11-18
 * Time: 下午3:45
 * To change this template use File | Settings | File Templates.
 */
//以下语音识别封装
function voiceClick(){
    var voice= $('#voice').val();
    switch (voice){
        case '你好'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('你好','您好!欢迎使用智能家居');
            break;
        case '打开电视电源':
            SwitchVoice('电视电源',1);
            VoiceAlarm('打开电视电源','电视打开始工作了！');
            break;
        case '关闭电视电源':
            SwitchVoice('电视电源',0);
            VoiceAlarm('关闭电视电源','电视停止工作了！');
            break;
        case '打开空调'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('打开空调','空调打开始工作了！');
            break;
        case '关闭空调'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('关闭空调','空调停止工作了！');
            break;
        case '打开红色彩灯':
            LEDVoice('红色LED',100);
            VoiceAlarm('打开红色彩灯','红色彩灯亮了!');
            break;
        case '打开绿色彩灯':
            LEDVoice('绿色LED',100);
            VoiceAlarm('打开绿色彩灯','绿色彩灯亮了!');
            break;
        case '打开蓝色彩灯':
            LEDVoice('蓝色LED',100);
            VoiceAlarm('打开蓝色彩灯','蓝色彩灯亮了!');
            break;
        case '打开门灯':
            LEDVoice('门灯',100);
            VoiceAlarm('打开门灯','门灯亮了!');
            break;
        case '打开红色灯带'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('打开红色灯带','红色灯带亮了!');
            break;
        case '打开绿色灯带'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('打开绿色灯带','绿色彩灯亮了!');
            break;
        case '打开蓝色灯带'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('打开蓝色灯带','蓝色彩灯亮了!');
            break;
        case '关闭红色彩灯':
            LEDVoice('红色LED',0);
            VoiceAlarm('关闭红色彩灯','红色彩灯灭了！');
            break;
        case '关闭绿色彩灯':
            LEDVoice('绿色LED',0);
            VoiceAlarm('关闭绿色彩灯','绿色彩灯灭了！');
            break;
        case '关闭蓝色彩灯':
            LEDVoice('蓝色LED',0);
            VoiceAlarm('关闭蓝色彩灯','蓝色彩灯灭了！');
            break;
        case '关闭门灯':
            LEDVoice('门灯',0);
            VoiceAlarm('关闭门灯','门灯灭了！');
            break;
        case '关闭红色灯带'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('关闭红色灯带','红色灯带灭了！');
            break;
        case '关闭绿色灯带'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('关闭绿色灯带','绿色灯带灭了！');
            break;
        case '关闭蓝色灯带'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('关闭蓝色灯带','蓝色灯带灭了！');
            break;
        case '音量加'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('音量加','电视机音量已增加!');
            break;
        case '音量减'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('音量减','电视机音量已减低!');
            break;
        case '频道加'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('频道加','电视机频道已加!');
            break;
        case '频道减'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('频道减','电视机频道已减!');
            break;
        case '温度'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('温度','空调温度上升！');
            break;
        case '定时'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('定时','空调设置了定时！');
            break;
        case '风向'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('风向','空调风向改变！');
            break;
        case '制热'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('制热','空调选择了制热模式！');
            break;
        case '通风'://~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            VoiceAlarm('通风','空调选择了通风模式！');
            break;
        case '开门':
            SwitchVoice('磁力锁',0);
            VoiceAlarm('打开门','门磁力锁已经解锁，门打开了！');
            break;
        case '关门':
            SwitchVoice('磁力锁',1);
            VoiceAlarm('关闭门','门磁力锁已经工作，门锁上了!');
            break;
        case '打开窗帘':
            SwitchVoice('窗帘',1);
            VoiceAlarm('打开窗帘','窗帘已经打开！');
            break;
        case '关闭窗帘':
            SwitchVoice('窗帘',0);
            VoiceAlarm('关闭窗帘','窗帘已经关闭！');
            break;
        case '打开电热水壶':
            SwitchVoice('电热水壶',1);
            VoiceAlarm('打开电热水壶','电热水壶已经打开！');
            break;
        case '关闭电热水壶':
            SwitchVoice('电热水壶',0);
            VoiceAlarm('关闭电热水壶','电热水壶已经关闭！');
            break;
        case '打开风扇':
            SwitchVoice('风扇',1);
            VoiceAlarm('打开风扇','风扇已经打开！');
            break;
        case '关闭风扇':
            SwitchVoice('风扇',0);
            VoiceAlarm('关闭风扇','风扇已经关闭！');
            break;
        case '打开打印机':
            SwitchVoice('打印机',1);
            VoiceAlarm('打开打印机','打印机已经打开！');
            break;
        case '关闭打印机':
            SwitchVoice('打印机',0);
            VoiceAlarm('关闭打印机','打印机已经关闭！');
            break;
        case '打开投影仪':
            /*SwitchVoice('投影仪',1);*/
            VoiceAlarm('打开投影仪','投影仪已经打开！');
            break;
        case '关闭投影仪':
            /*SwitchVoice('投影仪',0);*/
            VoiceAlarm('关闭投影仪','投影仪已经关闭！');
            break;
        case '打开台灯':
            SwitchVoice('台灯',1);
            VoiceAlarm('打开台灯','台灯已经打开！');
            break;
        case '关闭台灯':
            SwitchVoice('台灯',0);
            VoiceAlarm('关闭台灯','台灯已经关闭！');
            break;
        case '打开电冰箱':
            SwitchVoice('电冰箱',1);
            VoiceAlarm('打开电冰箱','冰箱已经打开！');
            break;
        case '关闭电冰箱':
            SwitchVoice('电冰箱',0);
            VoiceAlarm('关闭电冰箱','冰箱已经关闭！');
            break;
        //以下为灯变色，红橙黄绿青蓝紫
        case '红色灯亮':
            ColorVoice(100,0,0);
            VoiceAlarm('红色灯亮','彩灯的颜色变为红色！');
            break;
        case '橙色灯亮':
            ColorVoice(100,50,0);
            VoiceAlarm('橙色灯亮','彩灯的颜色变为橙色！');
            break;
        case '黄色灯亮':
            ColorVoice(100,100,0);
            VoiceAlarm('黄色灯亮','彩灯的颜色变为黄色！');
            break;
        case '绿色灯亮':
            ColorVoice(0,100,0);
            VoiceAlarm('绿色灯亮','彩灯的颜色变为绿色！');
            break;
        case '青色灯亮':
            ColorVoice(0,100,100);
            VoiceAlarm('青色灯亮','彩灯的颜色变为青色！');
            break;
        case '蓝色灯亮':
            ColorVoice(0,0,100);
            VoiceAlarm('蓝色灯亮','彩灯的颜色变为蓝色！');
            break;
        case '紫色灯亮':
            ColorVoice(100,0,100);
            VoiceAlarm('紫色灯亮','彩灯的颜色变为紫色！');
            break;
        case '白色灯亮':
            ColorVoice(100,100,100);
            VoiceAlarm('白色灯亮','彩灯的颜色变为白色！');
            break;
        case '关灯':
            ColorVoice(0,0,0);
            VoiceAlarm('关灯','彩灯的已经关闭了！');
            break;
        default :
            VoiceAlarm('无法识别','Sorry！系统无法识别命令。');
            break;
    }
    function SwitchVoice(chr,con){//打开开关节点语音控制,chr:设备名,con:控制类型,1:打开，0：关闭。
        $.get("SwitchVoice.do", {
            name:encodeURI(chr),
            state:con
        },function(data,textStatus){

        },"json");
    }
    function LEDVoice(chr,con){//打开LED节点语音控制,chr:设备名,con:控制类型,100:打开，0：关闭。
        $.get("LEDVoice.do", {
            name:encodeURI(chr),
            state:con
        },function(data,textStatus){

        },"json");
    }
    function ColorVoice(red,green,blue){//调节灯颜色，1：红 2：绿 3：蓝
        $.post("ColorVoice.do", {
            red:red,
            green:green,
            blue:blue
        }, function (data, textStatus) {

        }, "json");
    }
    function VoiceAlarm(chr1,chr2){//提醒
        var name=chr1;
        var state=chr2;
        $.msgbox({
            autoClose:5,
            /*closeImg: 'close.gif',*/
            height:163,
            width:386,
            title:'您刚才是说： '+chr1+' ：',
            content:'<br>智能家居： '+chr2+'<br><br>',
            type :'alert'
        });
    }
}