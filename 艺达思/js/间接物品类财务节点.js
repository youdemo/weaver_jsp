<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 var kmzh_dt1="field6479_";//科目组合-明细1
 var sfmap="#field6583";//是否匹配
 var sfmap2="#disfield6583";//是否匹配
    var sfmap_dt1="field6584_";//明细1
     var bdlx="#field6487";//表单类型
  var wpdl="field6695_";//物品大类明细1
  var dlms="field6471_";//大类描述明细1
  var lh="field6467_";//料号明细1
    
     var sfbh_dt1="#field6722_";//是否标红-明细1
  var cgdjhs="field6476_";//采购单价含税明细1
  jQuery(document).ready(function () {
  	   dodetail();
  	   jQuery(bdlx).bind("change",function () {
         	dodetail();
          });
     	jQuery("#indexnum0").bindPropertyChange(function () {
		
		dodetail();
	});
	 jQuery("button[name=addbutton0]").live("click", function () {
	  	   		dodetail();
	 });
  	  	var indexnum1=  jQuery("#indexnum0").val();
  	    	for(var index = 0;index<indexnum1;index++){
  	    	 	 if(jQuery("#"+sfmap_dt1+index).length>0){
  	    	 	 	 var sfmap_dt1_val =jQuery("#"+sfmap_dt1+index).val();
  	    	 	 	 var kmzh_dt1_val =jQuery("#"+kmzh_dt1+index+"span").html();
  	    	 	 	 if(sfmap_dt1_val=="0"){
  	    	 	 	 	 jQuery("#"+kmzh_dt1+index+"span").attr({style:"color:red  !important"});
  	    	 	       }
  	    	 	 }
  	    	}
  	    checkCustomize = function(){
  	    	jQuery(sfmap).val("");
  	    	jQuery(sfmap2).val("");
  	    	var indexnum0=  jQuery("#indexnum0").val();
  	    	var kmzhall="";
  	    	var flag="0";
  	    	 for(var index = 0;index<indexnum0;index++){
  	    	 	 if(jQuery("#"+kmzh_dt1+index).length>0){
  	    	 	 	 var sfmap_dt1_val=jQuery("#"+sfmap_dt1+index).val()
  	    	 	 	 if(sfmap_dt1_val == '0'){
  	    	 	 	 	 flag="1";
  	    	 	 	 	 break;
  	    	 	        }
  	    	        }
  	    	 }
  	     	jQuery(sfmap).val(flag);
  	     	jQuery(sfmap2).val(flag);
  	     	return true;
  	    }
 })
function dodetail(){
 	 var bdlx_val =jQuery(bdlx).val();
 	 if(bdlx_val == ''){
 	 	  jQuery("button[name=addbutton0]").css('display','none');
        }else{
        	 jQuery("button[name=addbutton0]").css('display','');
        }
       	if(bdlx_val == "0"){
        	 $(".lhyc").hide();
        	 $(".wpdlyc").show();
        	}else if(bdlx_val == "1"){
              $(".wpdlyc").hide();
              $(".lhyc").show();
              }
        if(bdlx_val == "0"){
       	var indexnum00=  jQuery("#indexnum0").val();
  	        for(var index = 0;index<indexnum00;index++){
  	        	if(jQuery(sfbh_dt1+index).length>0){	
  	        		 var sfbh_dt1_val =jQuery(sfbh_dt1+index).val();
  	        		 if(sfbh_dt1_val=="1"){
  	        		   	 jQuery("#"+cgdjhs+index).attr({style:"color:red  !important"}); 
  	        		   	  jQuery("#"+cgdjhs+index+"span").attr({style:"color:red  !important"}); 	 
  	        		}
  	              }
  	        }
  	}
       var indexnum0= jQuery("#indexnum0").val();
       for(var index=0;index <indexnum0;index++){
       	if( jQuery("#"+dlms+index).length>0){
       	    	if(bdlx_val == "0"){
       	    		addcheck(wpdl+index,"1");
       	    		 jQuery("#"+dlms+index).attr("readonly", "readonly");
       	    		 removecheck(lh+index,"1");
       	    	}else if(bdlx_val == "1"){
       	    		jQuery("#"+dlms+index).removeAttr("readonly");
       	    	   addcheck(lh+index,"1");
       	    	   removecheck(wpdl+index,"1");
       	      }
    		}
       }

}
 function addcheck(btid,flag){
  	  	var btid_val = jQuery("#"+btid).val();
  	  	var btid_check=btid;
  	      if(btid_val==''){
		    if(flag=='0'){ 
     	 	  jQuery("#"+btid+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }else{
     	 	 	 jQuery("#"+btid+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	 	 	  } 	  
     	 	 	 
     	}
     	var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+btid_check)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=btid_check;
                }
  }
  function removecheck(btid,flag){
      if(flag=='0'){ 
  	   jQuery("#"+btid+"span").html("");
     }else{
     	   jQuery("#"+btid+"spanimg").html("");
    }
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+btid,"");
                document.all('needcheck').value=parastr;
  }

</script>

