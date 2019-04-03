jQuery(document).ready(function() {
    var requestid_def=jQuery("#requestid").val();
    //alert(requestid_def); 
    $.ajax({
    async:"false",
        type: "POST",
        url: "/appdevjsp/HQ/DECODE/get-field-info.jsp",
        data: {"requestid_def":requestid_def},
        dataType: "Text",
        success: function(data){
            data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
            //alert(data);
            var obj = eval("("+data+")");
            var status=obj["status"];
            var code=obj["code"];
            if(status=="success"){
                //alert("status:"+obj["status"]); 
                //alert("code:"+obj["code"]);
                $.each(code,function(i,value) {
                    //alert(code[i]);
                    //alert(i);
                    if(code[i]=="clob"){
                        var clob_val = jQuery("#field"+i).val();
                        if(clob_val != ""){
                            var tmp_val=getDecodeValue(clob_val,"1");
                            jQuery("#FCKiframe"+i).contents().find("div").html(tmp_val);
                        }
                    }else{
                        var char_val = jQuery("#field"+i).val();
                        if(char_val != ""){
                            var tmp_val=getDecodeValue(char_val,"0");
                            jQuery("#field"+i+"span").text(tmp_val);
                        }
                    }
                });
            }else{
                alert("Error:"+code);
            }
        }
    });
});

function getDecodeValue(oldvalue,type){
    var value=encodeURIComponent(oldvalue);
    var name_val="";
    $.ajax({
             type: "POST",
             url: "/appdevjsp/HQ/DECODE/get-decode-value.jsp",
             data: {'oldvalue':oldvalue, 'type':type},
             dataType: "text",
             async:false,//同步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        name_val=data;
                      }
         });
     return name_val;
}





















