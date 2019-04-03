<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var  cgsqlx="field34226";//采购申请类型
    var  glbmjl="field34229";//管理部门经理
    var  ysgsbm="field34231";//预算归属部门
    var  nbddh="field34233";//内部订单号
    var gc="field34764";//工厂
    var kmflm_dt1="field34667_";//明细1-科目分类码
    var gdzclx_dt1="field34668_";//明细1-固定资产类型
    var wlbh_dt1 ="field34669_";//明细1-物料编号
    var wlms_dt1 = "field34670_";//明细1-物料描述
    var cgdw_dt1 = "field34700_";//明细1-采购单位
    var nbddh_dt1 = "field34728_";//明细1-内部订单号
    var cbzx_dt1 ="field34730_";//明细1-成本中心
    var fykm_dt1 ="field34732_";//明细1-费用科目\
    var wlz_dt1 ="field34748_";//明细1-物料组
    var kcdd_dt1="field34750_";//明细1-库存地点
    var bgr_dt1="field34758_";//明细1-保管人
    var bgbm_dt1="field34760_";//明细1-保管部门
    var cgsqlx_old="";
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
	          	 $(".nbddh_dt").hide();
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
	      	   $(".cbzx_dt").hide();
	     }
	
	     if(cgsqlx_val =='PR04' ){
	     	 $(".gdzclx_dt").hide();
	           $(".kcall_dt").hide();
	           	 $(".nbddh_dt").hide();
	     }
	     
	    
	     dodetail(cgsqlx_val);
	});
	  jQuery("button[name=addbutton0]").live("click", function () {
	  	   var cgsqlx_val= jQuery("#"+cgsqlx).val();   
	  	   dodetail(cgsqlx_val);
	 });
   })
   function dodetail(cgsqlx_val){
   	      var indexnum0 =jQuery("#indexnum0").val();
   	      for( var index=0;index<indexnum0;index++){
   	      if(     jQuery("#"+kmflm_dt1+index).length>0){
	   	      if(cgsqlx_val =='PR02' ){
	   	         jQuery("#"+kmflm_dt1+index).val("A")
	   	        jQuery("#"+kmflm_dt1+index+"span").text("A");
	   	          jQuery("#"+wlz_dt1+index).val("Z002")
	   	        jQuery("#"+wlz_dt1+index+"span").text("Z002");
	   	          addcheck(gdzclx_dt1+index,'0');
	   	          addcheck(nbddh_dt1+index,'0');
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
	   	          addcheck(nbddh_dt1+index,'0');
	   	           addcheck(fykm_dt1+index,'1');
	   	             jQuery("#"+wlz_dt1+index).val("Z006")
	   	        jQuery("#"+wlz_dt1+index+"span").text("Z006");
	   	          addcheck(bgr_dt1+index,'1');
	   	      	  addcheck(bgbm_dt1+index,'1');
	   	      }
   	   }
   	  }
   }
   function showhide(){
      var cgsqlx_val= jQuery("#"+cgsqlx).val();   
      if(cgsqlx_val !='PR02' ){
           jQuery("#gdzcxs0").hide(); 
            jQuery("#gdzcxs5").hide();     
             jQuery("#pgwj0").show();   
      }else{
           jQuery("#gdzcxs0").show();
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
      }else{
           jQuery("#fylxs0").show();     	  
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
           $(".nbddh_dt").hide();
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
	      	   $(".cbzx_dt").hide();
	     }
	     if(cgsqlx_val =='PR04' ){
	     	 $(".gdzclx_dt").hide();
	           $(".kcall_dt").hide();
	           $(".nbddh_dt").hide();
	     }
  }
  
  function addremovecheck(){
  	 var cgsqlx_val= jQuery("#"+cgsqlx).val();   
  	 if(cgsqlx_val == 'PR02'){
  	 	 addcheck(glbmjl,'1');
  	 	 addcheck(ysgsbm,'1');
  	 	 addcheck(nbddh,'1');

       }else{
             removecheck(glbmjl,'1');
             removecheck(ysgsbm,'1');
  	      removecheck(nbddh,'1');

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
</script>




