/**
 * Created with IntelliJ IDEA.
 * User: StevenH
 * Date: 13-10-14
 * Time: 下午3:24
 * To change this template use File | Settings | File Templates.
 */
function btnClick(num) {
    $.get("Type.do", {
        name : encodeURI($(".send:eq(" + num + ")").val())
    }, function(data, textStatus) {
        var name = data.name;
        var type = data.type;
        var mac=data.mac;
        name = decodeURI(name);
        type = decodeURI(type);
        var txtHtml0 = "<div>您选择的是:&nbsp" + name + "</div><br>";
        txtHtml0 += "<input type='hidden' id='param3' value='"
            + name + "'/>";
        $("#resType").html(txtHtml0); // 把返回的数据添加到页面上
        var emptyHtml="<div></div>";
        $("#resTimeInfo").html(emptyHtml);
        $("#resSetTime").html(emptyHtml);//清空不需要的信息
        /*if (data.state != -1) {*/
        if(data.mac!="null"){
            var txtHtml = "<div>设备状态:&nbsp";
            switch (data.state) {
                case 0 :
                    txtHtml += "关<br><br>";
                    txtHtml += "控制:&nbsp&nbsp&nbsp"
                        + "<button class='switch' onclick='swhClick()'>&nbsp&nbsp开&nbsp&nbsp</button>";
                    // 加入隐藏域传递值
                    txtHtml += "<input type='hidden' id='param1' value='"
                        + data.mac + "'/>";
                    txtHtml += "<input type='hidden' id='param2' value='"
                        + data.state + "'/>";
                    break;
                case 1 :
                    txtHtml += "开<br><br>";
                    txtHtml += "控制:&nbsp&nbsp&nbsp"
                        + "<button class='switch' onclick='swhClick()'>&nbsp&nbsp关&nbsp&nbsp</button>";
                    // 加入隐藏域传递值
                    txtHtml += "<input type='hidden' id='param1' value='"
                        + data.mac + "'/>";
                    txtHtml += "<input type='hidden' id='param2' value='"
                        + data.state + "'/>";
                    break;
                default :
                    txtHtml += "未使用<br><br>";
                    txtHtml += "控制:&nbsp&nbsp&nbsp"
                        + "<button class='switch' onclick='swhClick()'>&nbsp&nbsp开&nbsp&nbsp</button>";
                    // 加入隐藏域传递值
                    txtHtml += "<input type='hidden' id='param1' value='"
                        + data.mac + "'/>";
                    txtHtml += "<input type='hidden' id='param2' value='"
                        + 1 + "'/>";
                    break;
            }
            txtHtml += "</div>";
            $("#resState").html(txtHtml);
        }else{
            var txtHtml2 = "<div>该设备还没有开启！</div>";
            $("#resState").html(txtHtml2);
        }

        /*}else{
         var txtHtml2 = "<div>该设备还没有开启！</div>";
         $("#resState").html(txtHtml2);
         }*/
    }, "json");
}