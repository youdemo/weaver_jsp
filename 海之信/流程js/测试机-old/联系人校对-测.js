<script type="text/javascript">
    var ssjt = "#field13141";
	var ssgs = "#field13142";
    var lxr = "field13107_";
    var lx = "#field13105"
   var yddh="#field13111_";
   var bgdh="#field13113_";
   var dzyx="#field13112_";
   
    var xgxl="field13862_";
    var bj="field13861_";
    var bjzt="field13863_";
    var bjzt2 ="disfield13863_";
    var rqid="field13859";
	jQuery(document).ready(function () {
             jQuery("button[name=addbutton0]").live("click", function () {
			var indexnum2 = jQuery("#indexnum0").val();
			bindchange(indexnum2-1);
		});
		var nodenum0 = jQuery("#nodesnum0").val();
              var indexnum1= jQuery("#indexnum0").val();
              if(nodenum0 >0){
              	  for(var index=0;index<indexnum1;index++ ){
                       if(jQuery("#"+lxr+index).length>0){
                       	   var xgxl_val=jQuery("#"+xgxl+index).val();
                       	    var lxr_val=jQuery("#"+lxr+index).val();
                       	    if(lxr_val !=''){
                       	    	jQuery("#"+bj+index+"span").html("<a href=\"javascript:editInfo('"+lxr_val+"','"+xgxl_val+"','"+index+"')\">�༭</a>");
                       	    }
                       	    	bindchange(index);
                       }
                      }
              }
		jQuery(lx).bindPropertyChange(function (){ 
            jQuery(ssjt).val("");
			jQuery(ssjt+"span").text("");
			 jQuery(ssgs).val("");
			jQuery(ssgs+"span").text("");
		})

      	jQuery(ssjt).bindPropertyChange(function (){ 
        deletedetail();
		var lx_val = jQuery(lx).val();
               if(lx_val == ''){
                          lx_val = '5';
                  }
         var ssjt_val = jQuery(ssjt).val();
		 var url="/seahonor/crm/jsp/sureModifyContact.jsp?qf=1&ssjt="+ssjt_val+"&lx="+lx_val;
        insertDetail(url);

        })

		jQuery(ssgs).bindPropertyChange(function (){ 
        deletedetail();
		var lx_val = jQuery(lx).val();
                if(lx_val == ''){
                          lx_val = '3';
                 }
         var ssgs_val = jQuery(ssgs).val();
		 var url="/seahonor/crm/jsp/sureModifyContact.jsp?qf=0&ssjt="+ssgs_val+"&lx="+lx_val;
        insertDetail(url);

        })

   


    });

    function insertDetail(url1){

		var indexnum0=  jQuery("#indexnum0").val();
        var xhr = null;
		if (window.ActiveXObject) {//IE�����
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {			
			xhr.open("GET",url1, false);
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
				
								jQuery("#"+lxr+i).val(tmp_arr[0]);							
								jQuery("#"+lxr+i+"span").text(tmp_arr[1]);
									jQuery("#"+xgxl+i).val(tmp_arr[2]);							
								jQuery("#"+xgxl+i+"span").text(tmp_arr[2]);
								var url="<a href=\"javascript:editInfo('"+tmp_arr[0]+"','"+tmp_arr[2]+"','"+i+"')\">�༭</a>";
						
									jQuery("#"+bj+i).val(url);							
								jQuery("#"+bj+i+"span").html(url);
								document.getElementById(lxr+i+"spanimg").innerHTML = ""; 	
								bindchange(i);																						
						}
					}	
				}
			}
			xhr.send(null);			
		}
	}

    function deletedetail(){
      var indexnum0=  jQuery("#nodesnum0").val();
      if(indexnum0>0){
        jQuery("[name = check_node_0]:checkbox").attr("checked", true);
        deleteRow0(0);                                                               
      }  
    }
    function bindchange(index1){
    		jQuery("#"+lxr+index1).bindPropertyChange(function (){ 
    			jQuery("#"+bjzt+index1).val("0");
			jQuery("#"+bjzt2+index1).val("0");
    		     var lxr_val=jQuery("#"+lxr+index1).val();
    		     if(lxr_val == ''){
    		     	jQuery("#"+bj+index1).val('');							
				jQuery("#"+bj+index1+"span").html('');
				return;
    		     }
    		 
                  jQuery.post("/seahonor/crm/jsp/editContact.jsp", {
                    'qf': "0"
                }, function (data) {
                    //alert(data);
                    	data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
                    	jQuery("#"+xgxl+index1).val(data);							
				jQuery("#"+xgxl+index1+"span").text(data);
				var url="<a href=\"javascript:editInfo('"+lxr_val+"','"+data+"','"+index1+"')\">�༭</a>";
				jQuery("#"+bj+index1).val(url);							
				jQuery("#"+bj+index1+"span").html(url);
                 
                });
		})
    }
    function editInfo(id,xl,index) {
    	     var rqid_val=jQuery("#"+rqid).val();
		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/jsp/forward.jsp?typex=editcontact,"+id+","+xl+","+rqid_val;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 750;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();
		jQuery.post("/seahonor/crm/jsp/editContact.jsp", {
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











