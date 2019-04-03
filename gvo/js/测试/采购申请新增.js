<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var  cgsqlx="field34226";//采购申请类型
    var  glbmjl="field34229";//管理部门经理
    var gc="field34764";//工厂
    var kmflm_dt1="field34667_";//明细1-科目分类码
    var gdzclx_dt1="field34668_";//明细1-固定资产类型
    var wlbh_dt1 ="field34669_";//明细1-物料编号
    var wlms_dt1 = "field34670_";//明细1-物料描述
    var cgdw_dt1 = "field34700_";//明细1-采购单位
    var cbzx_dt1 ="field34730_";//明细1-成本中心
    var fykm_dt1 ="field34732_";//明细1-费用科目\
    var wlz_dt1 ="field34748_";//明细1-物料组
    var kcdd_dt1="field34750_";//明细1-库存地点
    var bgr_dt1="field34758_";//明细1-保管人
    var bgbm_dt1="field34760_";//明细1-保管部门
    var cgsqlx_old="";
    var ysje="field36589_";//明细1-预算金额
    var yyje="field36590_";//明细1-已用金额
    var kyje="field36591_";//明细1-可用金额
    var gc_dt1="field36608_";//明细1-工厂
    var zcmc_dt1 ="field36666_";//明细1-资产名称
    var je_dt1="field34727_";//明细1-金额
       var cbzxspzje_dt1="field37087_";//明细1-成本中心审批中金额
    var zcspzje_dt1 = "field37088_";//明细1-资产审批中金额
    var chrq_dt1= "field34806_";//明细1-出货日期
    jQuery(document).ready(function(){
    	  var cgsqlx_val= jQuery("#"+cgsqlx).val();   
    	    if(cgsqlx_val !=''){
    	    	cgsqlx_old = cgsqlx_val;
	          jQuery("#"+cgsqlx+"_browserbtn").attr('disabled',true);
	    }else{
	        jQuery("button[name=addbutton0]").css('display','none');	
	    }
	    showhide();
	     dodetail(cgsqlx_val);
    	  jQuery("#"+cgsqlx).bindPropertyChange(function () {
    		showhide();
    		addremovecheck();
    		 jQuery("#"+cgsqlx+"_browserbtn").attr('disabled',true);
    		   jQuery("button[name=addbutton0]").css('display','');
    		    var cgsqlx_val=jQuery("#"+cgsqlx).val();
    		    if(cgsqlx_old==''){
                	cgsqlx_old = cgsqlx_val; 
              }else{
               jQuery("#"+cgsqlx).val(cgsqlx_old);
                jQuery("#"+cgsqlx+"span").text(cgsqlx_old);	  
            }	
    	 })
    	 jQuery("#indexnum0").bindPropertyChange(function () {
	       var cgsqlx_val= jQuery("#"+cgsqlx).val();   
	     if(cgsqlx_val =='PR01' ){
	     	  $(".gdzclx_dt").hide();
	         $(".kmflm_dt").hide();
	         $(".cbzx_dt").hide();
	         $(".fykm_dt").hide();
	          $(".bg_dt").hide();
	          $(".zcmc_dt").hide();
	          $(".ys_dt").hide();
	     }
	     if(cgsqlx_val =='PR02' ){
	         $(".wlbh_dt").hide();
	          $(".wlmsfj_dt").hide();
	           $(".kcall_dt").hide();
	            $(".cbzx_dt").hide();
	            $(".fykm_dt").hide();
	             $(".bg_dt").hide();
	     }
	      if(cgsqlx_val =='PR06' ){
	      	   $(".gdzclx_dt").hide();
	      	  $(".kcall_dt").hide();
	      	    $(".zcmc_dt").hide();
	      	    $(".ys_dt").hide();
	     }
	
	     if(cgsqlx_val =='PR04' ){
	     	 $(".gdzclx_dt").hide();
	           $(".kcall_dt").hide();
	           	  $(".zcmc_dt").hide();
	     }
	     
	    
	     dodetail(cgsqlx_val);
	});
	  jQuery("button[name=addbutton0]").live("click", function () {
	  	   var cgsqlx_val= jQuery("#"+cgsqlx).val();  
				var index = jQuery("#indexnum0").val()-1;		   
	  	   dodetailindex(cgsqlx_val,index);
	 });
	 checkCustomize = function () {
	  var cgsqlx_val= jQuery("#"+cgsqlx).val();   
	  if(cgsqlx_val=='PR02'||cgsqlx_val=='PR04'){	 	 	 	 	 	
	 	 var indexnum0 = jQuery("#indexnum0").val();
 	 	 for(var index=0;index<indexnum0;index++){
 	 	 	 if (jQuery("#"+je_dt1 + index).length > 0) {
 	 	 	 	 var je_dt1_val=jQuery("#"+je_dt1 + index).val();
 	 	 	 	 if(je_dt1_val==''){
 	 	 	 	 	 je_dt1_val="0";
 	 	 	        }
 	 	 	         var kyje_val=jQuery("#"+kyje + index).val();
 	 	 	 	 if(kyje_val==''){
 	 	 	 	 	 kyje_val="0";
 	 	 	        }
 	 	 	        	 var cbzxspzje_dt1_val=jQuery("#"+cbzxspzje_dt1 + index).val();
 	 	 	 	 var zcspzje_dt1_val=jQuery("#"+zcspzje_dt1 + index).val();
 	 	 	 	 var sykyje="";
 	 	 	 	 if(cgsqlx_val=='PR02'){
 	 	 	 	 	 sykyje=accSub(kyje_val,zcspzje_dt1_val);
 	 	 	          }else{
 	 	 	          	  sykyje=accSub(kyje_val,cbzxspzje_dt1_val);
 	 	 	         }
 	 	 	        if(Number(je_dt1_val)>Number(sykyje)){
 	 	 	        	alert("采购金额大于预算可用金额，请修改需求");
 	 	 	        	return false;	
 	 	 	        }
 	 	 	        var cbzx_dt1_val = jQuery("#"+cbzx_dt1+ index).val();
     	  	    	var fykm_dt1_val = jQuery("#"+fykm_dt1 + index).val();
     	  	    	var chrq_dt1_val = jQuery("#"+chrq_dt1 + index).val().substring(0,7);
     	  	    		var zcmc_dt1_val = jQuery("#"+zcmc_dt1+ index).val();
     	  	    	 var context="";
     	  	    	if(cgsqlx_val=='PR02'){
     	  	    	 context=checkcfdata2(zcmc_dt1_val,index+1,je_dt1_val,sykyje);
     	  	    	}else{
     	  	       context=checkcfdata1(cbzx_dt1_val,fykm_dt1_val,chrq_dt1_val,index+1,je_dt1_val,sykyje);
 	 	     }
 	 	    if(context=="1"){
 	 	    	alert("采购金额大于预算可用金额，请修改需求");
 	 		return false;
 	 	   }
 	 	 	  }
 	        }
 	    }
 	    return true;
	}
   })
   	   function checkcfdata1(cbzx,fykm,chrq,startindex,checkval,ckeckallval){
   	   var indexnum0 = jQuery("#indexnum0").val();
     	  var values=checkval;
     	  for (var index2= startindex; index2 < indexnum0; index2++) {   
     	  	    if (jQuery("#"+je_dt1 + index2).length > 0) {
     	  	    	var je_dt1_val = jQuery("#"+je_dt1 + index2).val();
     	  	    	var cbzx_dt1_val = jQuery("#"+cbzx_dt1+ index2).val();
     	  	    	var fykm_dt1_val = jQuery("#"+fykm_dt1 + index2).val();
     	  	    	var chrq_dt1_val = jQuery("#"+chrq_dt1 + index2).val().substring(0,7);
     	  	    	if(je_dt1_val == ''){
     	 		   je_dt1_val = "0"; 	 
     			}
     			if(cbzx_dt1_val==cbzx&&fykm_dt1_val==fykm&&chrq_dt1_val==chrq){
     					values=accAdd(values,je_dt1_val);
     					
     		      }
     	  	   }
     	  }
     	  if(Number(values)>Number(ckeckallval)){
 	 	 return "1";	
 	  }
 	  return "0";
   }
   
      function checkcfdata2(zcmc,startindex,checkval,ckeckallval){
   	   var indexnum0 = jQuery("#indexnum0").val();
     	  var values=checkval;
     	  for (var index2= startindex; index2 < indexnum0; index2++) {   
     	  	    if (jQuery("#"+je_dt1 + index2).length > 0) {
     	  	    	var je_dt1_val = jQuery("#"+je_dt1 + index2).val();
     	  	    	var zcmc_dt1_val = jQuery("#"+zcmc_dt1+ index2).val();
     	  	    	if(je_dt1_val == ''){
     	 		   je_dt1_val = "0"; 	 
     			}
     			if(zcmc_dt1_val==zcmc){
     			  values=accAdd(values,je_dt1_val);
     					
     		      }
     	  	   }
     	  }
     	  if(Number(values)>Number(ckeckallval)){
 	 	 return "1";	
 	  }
 	  return "0";
   }
   function dodetail(cgsqlx_val){
   	      var indexnum0 =jQuery("#indexnum0").val();
   	      var gc_val=jQuery("#"+gc).val();
   	      for( var index=0;index<indexnum0;index++){
   	      if(     jQuery("#"+kmflm_dt1+index).length>0){
   	      	var gc_dt1_val=jQuery("#"+gc_dt1+index).val();
   	      	if(gc_dt1_val==""){
   	      		jQuery("#"+gc_dt1+index).val(gc_val);
   	      		jQuery("#"+gc_dt1+index+"span").text(gc_val);
   	    		}
   	      	jQuery("#"+ysje+index).attr("readonly", "readonly");
   	      	jQuery("#"+yyje+index).attr("readonly", "readonly");
   	      	jQuery("#"+kyje+index).attr("readonly", "readonly");
	   	      if(cgsqlx_val =='PR02' ){
	   	         jQuery("#"+kmflm_dt1+index).val("A")
	   	        jQuery("#"+kmflm_dt1+index+"span").text("A");
	   	          jQuery("#"+wlz_dt1+index).val("Z002")
	   	        jQuery("#"+wlz_dt1+index+"span").text("Z002");
	   	          addcheck(gdzclx_dt1+index,'0');
	   	          addcheck(zcmc_dt1+index,'1');
	   	      }else if(cgsqlx_val =='PR04' ){
	   	         jQuery("#"+kmflm_dt1+index).val("K")
	   	        jQuery("#"+kmflm_dt1+index+"span").text("K");
	   	      	  addcheck(cbzx_dt1+index,'1');
	   	      	  addcheck(fykm_dt1+index,'1');
	   	      	  addcheck(bgr_dt1+index,'1');
	   	      	  addcheck(bgbm_dt1+index,'1');
	   	      	  jQuery("#"+wlz_dt1+index).val("Z001")
	   	      	  jQuery("#"+wlz_dt1+index+"span").text("Z001");
	   	      }else if(cgsqlx_val =='PR01' ){
	   	      	   addcheck(wlbh_dt1+index,'1');
	   	      	    addcheck(kcdd_dt1+index,'1');
	   	      	   jQuery("#"+wlms_dt1+index).attr("readonly", "readonly");
	   	      	    jQuery("#"+cgdw_dt1+index+"_browserbtn").attr('disabled',true);		
	   	      }else if(cgsqlx_val =='PR06' ){
	   	         jQuery("#"+kmflm_dt1+index).val("F")
	   	        jQuery("#"+kmflm_dt1+index+"span").text("F");
                           addcheck(cbzx_dt1+index,'1');
	   	           addcheck(fykm_dt1+index,'1');
	   	             jQuery("#"+wlz_dt1+index).val("Z006")
	   	        jQuery("#"+wlz_dt1+index+"span").text("Z006");
	   	          addcheck(bgr_dt1+index,'1');
	   	      	  addcheck(bgbm_dt1+index,'1');
	   	      }
   	   }
   	  }
   }
    function dodetailindex(cgsqlx_val,index){
   	      var gc_val=jQuery("#"+gc).val();
   	      if(     jQuery("#"+kmflm_dt1+index).length>0){
   	      	var gc_dt1_val=jQuery("#"+gc_dt1+index).val();
   	      	if(gc_dt1_val==""){
   	      		jQuery("#"+gc_dt1+index).val(gc_val);
   	      		jQuery("#"+gc_dt1+index+"span").text(gc_val);
   	    		}
   	      	jQuery("#"+ysje+index).attr("readonly", "readonly");
   	      	jQuery("#"+yyje+index).attr("readonly", "readonly");
   	      	jQuery("#"+kyje+index).attr("readonly", "readonly");
	   	      if(cgsqlx_val =='PR02' ){
	   	         jQuery("#"+kmflm_dt1+index).val("A")
	   	        jQuery("#"+kmflm_dt1+index+"span").text("A");
	   	          jQuery("#"+wlz_dt1+index).val("Z002")
	   	        jQuery("#"+wlz_dt1+index+"span").text("Z002");
	   	          addcheck(gdzclx_dt1+index,'0');
	   	          addcheck(zcmc_dt1+index,'1');
	   	      }else if(cgsqlx_val =='PR04' ){
	   	         jQuery("#"+kmflm_dt1+index).val("K")
	   	        jQuery("#"+kmflm_dt1+index+"span").text("K");
	   	      	  addcheck(cbzx_dt1+index,'1');
	   	      	  addcheck(fykm_dt1+index,'1');
	   	      	  addcheck(bgr_dt1+index,'1');
	   	      	  addcheck(bgbm_dt1+index,'1');
	   	      	  jQuery("#"+wlz_dt1+index).val("Z001")
	   	      	  jQuery("#"+wlz_dt1+index+"span").text("Z001");
	   	      }else if(cgsqlx_val =='PR01' ){
	   	      	   addcheck(wlbh_dt1+index,'1');
	   	      	    addcheck(kcdd_dt1+index,'1');
	   	      	   jQuery("#"+wlms_dt1+index).attr("readonly", "readonly");
	   	      	    jQuery("#"+cgdw_dt1+index+"_browserbtn").attr('disabled',true);		
	   	      }else if(cgsqlx_val =='PR06' ){
	   	         jQuery("#"+kmflm_dt1+index).val("F")
	   	        jQuery("#"+kmflm_dt1+index+"span").text("F");
                           addcheck(cbzx_dt1+index,'1');
	   	           addcheck(fykm_dt1+index,'1');
	   	             jQuery("#"+wlz_dt1+index).val("Z006")
	   	        jQuery("#"+wlz_dt1+index+"span").text("Z006");
	   	          addcheck(bgr_dt1+index,'1');
	   	      	  addcheck(bgbm_dt1+index,'1');
	   	      }
   	   }
   	  
   }
   function showhide(){
      var cgsqlx_val= jQuery("#"+cgsqlx).val();   
      if(cgsqlx_val !='PR02' ){
           jQuery("#gdzcxs0").hide(); 
           jQuery("#gdzcxs1").hide(); 
            jQuery("#gdzcxs5").hide();     
             jQuery("#pgwj0").show();   
      }else{
           jQuery("#gdzcxs0").show();
           jQuery("#gdzcxs1").show();
            jQuery("#gdzcxs5").show();
           jQuery("#pgwj0").hide();      	  
      }
      if(cgsqlx_val !='PR01' ){
           jQuery("#ybwlxs0").hide();         
      }else{
           jQuery("#ybwlxs0").show();      	  
      }
      if(cgsqlx_val !='PR04' ){
           jQuery("#fylxs0").hide();
           jQuery("#fylxs1").hide();
           jQuery("#fylxs2").hide();           
      }else{
           jQuery("#fylxs0").show();
           jQuery("#fylxs1").show();
           jQuery("#fylxs2").show();     	  
      }
      if(cgsqlx_val !='PR06' ){
           jQuery("#xmlxs0").hide();           
      }else{
           jQuery("#xmlxs0").show();     	  
      }      
      if(cgsqlx_val =='PR01' ){
      	  $(".gdzclx_dt").hide();
         $(".kmflm_dt").hide();  
          $(".cbzx_dt").hide();
           $(".fykm_dt").hide();
           $(".bg_dt").hide();
            $(".zcmc_dt").hide();
            $(".ys_dt").hide();
     }
       
	    if(cgsqlx_val =='PR02' ){
	         $(".wlbh_dt").hide();
	          $(".wlmsfj_dt").hide();
	           $(".kcall_dt").hide();
	            $(".cbzx_dt").hide();
	          $(".fykm_dt").hide();
	         $(".bg_dt").hide();
	     }
	      if(cgsqlx_val =='PR06' ){
	      	  $(".gdzclx_dt").hide();
	      	  $(".kcall_dt").hide();
	      	    $(".zcmc_dt").hide();
	      	    $(".ys_dt").hide();
	     }
	     if(cgsqlx_val =='PR04' ){
	     	 $(".gdzclx_dt").hide();
	           $(".kcall_dt").hide();
	            $(".zcmc_dt").hide();
	     }
  }
  
  function addremovecheck(){
  	 var cgsqlx_val= jQuery("#"+cgsqlx).val();   
  	 if(cgsqlx_val == 'PR02'){
  	 	 addcheck(glbmjl,'1');
       }else{
             removecheck(glbmjl,'1');
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
  	  	var btid_check=btid;
  	  if(flag=='0'){ 
     	  jQuery("#"+btid+"span").html("");
     	}else{
     	 jQuery("#"+btid+"spanimg").html("");
             }
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+btid_check,"");
                document.all('needcheck').value=parastr; 
  }
   function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
    m=Math.pow(10,Math.max(r1,r2)) 
    return (arg1*m+arg2*m)/m 
} 
function accSub(arg1,arg2){ 
   var r1,r2,m,n; 
    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
     try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
       m=Math.pow(10,Math.max(r1,r2)); 
       //动态控制精度长度 
       n=(r1>=r2)?r1:r2; 
       return ((arg1*m-arg2*m)/m).toFixed(n); 
}
</script>


