<script type="text/javascript">
    var ssjt = "#field11791";
    var gs = "field11796_";
    var lx = "#field11795";
    
    var yjdzt="field11793_";
    var xjdzt="field11794_";
    var kh="field11780_";
    var gys="field11781_";
    var hzhb="field11782_";
     var xgxl="field13488_";
    var bj="field13487_";
    var bjzt="field13489_";
    var bjzt2 ="disfield13489_";
    var rqid="field13485";
	jQuery(document).ready(function () {
        	jQuery("button[name=addbutton0]").live("click", function () {
			var indexnum2 = jQuery("#indexnum0").val();
			bindchange(indexnum2-1);
		});
              var nodenum0 = jQuery("#nodesnum0").val();
              var indexnum1= jQuery("#indexnum0").val();
              if(nodenum0 >0){
              	  for(var index=0;index<indexnum1;index++ ){
                       if(jQuery("#"+gs+index).length>0){
                       	   var xgxl_val=jQuery("#"+xgxl+index).val();
                       	    var gs_val=jQuery("#"+gs+index).val();
                       	    if(gs_val !='' && xgxl_val !=''){
                       	    	jQuery("#"+bj+index+"span").html("<a href=\"javascript:editInfo('"+gs_val+"','"+xgxl_val+"','"+index+"')\">编辑</a>");
                       	    }
                       	    	bindchange(index);
                       }
                      }
              }
		jQuery(lx).bindPropertyChange(function (){ 
            jQuery(ssjt).val("");
			jQuery(ssjt+"span").text("");
		})

      	jQuery(ssjt).bindPropertyChange(function (){ 
        deletedetail();
        var lx_val = jQuery(lx).val();
         var ssjt_val = jQuery(ssjt).val();
        var indexnum0=  jQuery("#indexnum0").val();
        var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {

                        if(lx_val == ''){
                          lx_val = '5';
                        }
			xhr.open("GET","/seahonor/crm/jsp/sureModifyCustom.jsp?ssjt="+ssjt_val+"&lx="+lx_val, false);
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
							var text_arr = text.split("@@@");
                                                         var length1=Number(text_arr.length)-1+Number(indexnum0);
							for(var i=indexnum0;i<length1;i++){                                                          
								addRow0(0);
								var tmp_arr = text_arr[i-indexnum0].split("###");							
								jQuery("#"+gs+i).val(tmp_arr[0]);							
								jQuery("#"+gs+i+"span").text(tmp_arr[1]);
								jQuery("#"+xgxl+i).val(tmp_arr[2]);							
								jQuery("#"+xgxl+i+"span").text(tmp_arr[2]);
								var url="<a href=\"javascript:editInfo('"+tmp_arr[0]+"','"+tmp_arr[2]+"','"+i+"')\">编辑</a>";
						
									jQuery("#"+bj+i).val(url);							
								jQuery("#"+bj+i+"span").html(url);
								document.getElementById(gs+i+"spanimg").innerHTML = ""; 	
								bindchange(i);																							
						}
					}	
				}
			}
			xhr.send(null);			
		}

        })
        	checkCustomize = function () {
        		 var indexnum0=  jQuery("#indexnum0").val();
        		 for(index=0;index<indexnum0;index++){
		     	if(jQuery("#"+yjdzt+index).length>0){
		     	
		                 var yjdzt_val=jQuery("#"+yjdzt+index).val();
		                 var xjdzt_val=jQuery("#"+xjdzt+index).val();
		                 if(yjdzt_val == '0' && xjdzt_val=='0'){
		                  alert("请修改新校对状态后再提交。");
		                  return false;
		                 }
		             }
	      	}
	      	return true;
             }
    });

 
     function bindchange(index1){
    		jQuery("#"+gs+index1).bindPropertyChange(function (){ 
    			jQuery("#"+bjzt+index1).val("0");
			jQuery("#"+bjzt2+index1).val("0");
    		     var gs_val=jQuery("#"+gs+index1).val();
    		     if(gs_val == ''){
    		     	jQuery("#"+bj+index1).val('');							
				jQuery("#"+bj+index1+"span").html('');
				return;
    		     }
    		 
                  jQuery.post("/seahonor/crm/jsp/editCustom.jsp", {
                    'qf': "0"
                }, function (data) {
                    //alert(data);
                    	data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
                    	jQuery("#"+xgxl+index1).val(data);							
				jQuery("#"+xgxl+index1+"span").text(data);
				var url="<a href=\"javascript:editInfo('"+gs_val+"','"+data+"','"+index1+"')\">编辑</a>";
				jQuery("#"+bj+index1).val(url);							
				jQuery("#"+bj+index1+"span").html(url);
                 
                });
		})
    }
    function deletedetail(){
      var indexnum0=  jQuery("#nodesnum0").val();
      if(indexnum0>0){
        jQuery("[name = check_node_0]:checkbox").attr("checked", true);
        deleteRow0(0);                                                               
      }  
    }
    function editInfo(id,xl,index) {
    	     var rqid_val=jQuery("#"+rqid).val();
		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/jsp/forward.jsp?typex=editcustom,"+id+","+xl+","+rqid_val;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 750;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();
		jQuery.post("/seahonor/crm/jsp/editCustom.jsp", {
                    'qf': "1",
                    'xgid':id,
                    'xgseq':xl
                }, function (data) {
                    //alert(data);
                    	data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                    	if(data == '1'){	
				jQuery("#"+bjzt+index).val("1");
				jQuery("#"+bjzt2+index).val("1");
			      }else{
			      jQuery("#"+bjzt+index).val("0");
				jQuery("#"+bjzt2+index).val("0");
			      }
                });	
		};
		diag_vote.show();
		
	}
</script>









