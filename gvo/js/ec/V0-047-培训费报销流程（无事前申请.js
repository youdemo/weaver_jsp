<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
     var ysssqj_dt1="#field11717_";//预算所属期间
    var cbzx_dt1="#field11719_";//成本中心
    var km_dt1="#field11720_";//科目
    var sqje_dt1="#field11722_";//申请金额
    var ndkyje_dt1="#field11952_";//年度可用金额
    
    var fplx_dt4="#field12517_";//发票类型4
    var fphm_dt4="#field12518_";//发票号码4
    var sfcf_dt4="#field12520_";//是否重复4
    	   
    var fplx_dt5="#field12513_";//发票类型5
    var fphm_dt5="#field12514_";//发票号码5
    var sfcf_dt5="#field12516_";//是否重复5
    	   
    var fplx_dt6="#field12521_";//发票类型6
    var fphm_dt6="#field12522_";//发票号码6
    var sfcf_dt6="#field12524_";//是否重复6
    	   
    var fplx_dt7="#field12525_";//发票类型7
    var fphm_dt7="#field12526_";//发票号码7
    var sfcf_dt7="#field12528_";//是否重复7
	
	var djbh="#field11629";//单据编号
    jQuery(document).ready(function(){
    	checkCustomize = function(){
			var djbh_val = jQuery(djbh).val();
    		 var indexnum0 = jQuery("#indexnum0").val();
    		 var countnum=0;
    		 for(var index=0; index<indexnum0;index++){
    		 	 if(jQuery(ysssqj_dt1+index).length>0){
    		 	 	 countnum=countnum+1;
    		 	 	 var ysssqj_dt1_val=jQuery(ysssqj_dt1+index).val().substring(0,4);
    		 	 	 var cbzx_dt1_val=jQuery(cbzx_dt1+index).val();
    		 	 	 var km_dt1_val=jQuery(km_dt1+index).val();
    		 	 	 var sqje_dt1_val=jQuery(sqje_dt1+index).val();
    		 	 	  var ndkyje_dt1_val=jQuery(ndkyje_dt1+index).val();
    		 	 	  if(sqje_dt1_val == ''){
    		 	 	      sqje_dt1_val='0';	  
    		 	 	  }
    		 	 	  if(ndkyje_dt1_val == ''){
    		 	 	      ndkyje_dt1_val='0';	  
    		 	 	  }
    		 	 	  if(ysssqj_dt1_val !='' && cbzx_dt1_val !='' && sqje_dt1_val !='') {
    		 	 	  var checkresult=checkyearmoney(cbzx_dt1_val,km_dt1_val,ysssqj_dt1_val,index+1,sqje_dt1_val,ndkyje_dt1_val);
    		 	 	  if(checkresult == '1'){
    		 	 	  	  Dialog.alert("第"+countnum+"行明细当前申请金额大于年度可用预算，请检查");
    		 	 	  	  return false;
    		 	 	  }
    		 	    	 }
    		        }
    		}
    			var indexnum3 = jQuery("#indexnum3").val();
    		 var countnum4=0;
    		 for(var index=0; index<indexnum3;index++){
    		 	 if(jQuery(fplx_dt4+index).length>0){
    		 	 	 countnum4=countnum4+1;
    		 	 	  var fplx_dt4_val=jQuery(fplx_dt4+index).val();
    		 	    	  var fphm_dt4_val=jQuery(fphm_dt4+index).val();
    		 	    	   var sfcf_dt4_val=jQuery(sfcf_dt4+index).val();
    		 	    	   if(fplx_dt4_val == "1" && fphm_dt4_val !=""){
    		 	    	   	   if(sfcf_dt4_val !=""&& sfcf_dt4_val != djbh_val){
    		 	    	   	    Dialog.alert("交通费 第"+countnum4+"行明细的发票号码（"+fphm_dt4_val+"）已在流程编号为（"+sfcf_dt4_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    			var indexnum4 = jQuery("#indexnum4").val();
    		 var countnum5=0;
    		 for(var index=0; index<indexnum4;index++){
    		 	 if(jQuery(fplx_dt5+index).length>0){
    		 	 	 countnum5=countnum5+1;
    		 	 	  var fplx_dt5_val=jQuery(fplx_dt5+index).val();
    		 	    	  var fphm_dt5_val=jQuery(fphm_dt5+index).val();
    		 	    	   var sfcf_dt5_val=jQuery(sfcf_dt5+index).val();
    		 	    	   if(fplx_dt5_val == "1" && fphm_dt5_val !=""){
    		 	    	   	   if(sfcf_dt5_val !=""&& sfcf_dt5_val != djbh_val){
    		 	    	   	    Dialog.alert("住宿费第"+countnum5+"行明细的发票号码（"+fphm_dt5_val+"）已在流程编号为（"+sfcf_dt5_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    		
    			var indexnum5 = jQuery("#indexnum5").val();
    		 var countnum6=0;
    		 for(var index=0; index<indexnum5;index++){
    		 	 if(jQuery(fplx_dt6+index).length>0){
    		 	 	 countnum6=countnum6+1;
    		 	 	  var fplx_dt6_val=jQuery(fplx_dt6+index).val();
    		 	    	  var fphm_dt6_val=jQuery(fphm_dt6+index).val();
    		 	    	   var sfcf_dt6_val=jQuery(sfcf_dt6+index).val();
    		 	    	   if(fplx_dt6_val == "1" && fphm_dt6_val !=""){
    		 	    	   	   if(sfcf_dt6_val !=""&& sfcf_dt6_val != djbh_val){
    		 	    	   	    Dialog.alert("餐补费第"+countnum6+"行明细的发票号码（"+fphm_dt6_val+"）已在流程编号为（"+sfcf_dt6_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    			var indexnum6 = jQuery("#indexnum6").val();
    		 var countnum7=0;
    		 for(var index=0; index<indexnum6;index++){
    		 	 if(jQuery(fplx_dt7+index).length>0){
    		 	 	 countnum7=countnum7+1;
    		 	 	  var fplx_dt7_val=jQuery(fplx_dt7+index).val();
    		 	    	  var fphm_dt7_val=jQuery(fphm_dt7+index).val();
    		 	    	   var sfcf_dt7_val=jQuery(sfcf_dt7+index).val();
    		 	    	   if(fplx_dt7_val == "1" && fphm_dt7_val !=""){
    		 	    	   	   if(sfcf_dt7_val !=""&& sfcf_dt7_val != djbh_val){
    		 	    	   	    Dialog.alert("其他费用第"+countnum7+"行明细的发票号码（"+fphm_dt7_val+"）已在流程编号为（"+sfcf_dt7_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    		return true;
       }
   });
   function checkyearmoney(cbzx,fykm,year,startindex,checkval,ckeckallval){
   	   var indexnum0 = jQuery("#indexnum0").val();
     	  var values=checkval;
     	  for (var index2= startindex; index2 < indexnum0; index2++) {   
     	  	    if (jQuery(sqje_dt1+ index2).length > 0) {
     	  	    	 var ysssqj_dt1_val=jQuery(ysssqj_dt1+index2).val().substring(0,4);
    		 	 	 var cbzx_dt1_val=jQuery(cbzx_dt1+index2).val();
    		 	 	 var km_dt1_val=jQuery(km_dt1+index2).val();
    		 	 	 var sqje_dt1_val=jQuery(sqje_dt1+index2).val();
    		 	 	  if(sqje_dt1_val == ''){
    		 	 	      sqje_dt1_val='0';	  
    		 	 	  }
     			if(cbzx_dt1_val==cbzx && km_dt1_val==fykm && ysssqj_dt1_val==year){
     					values=accAdd(values,sqje_dt1_val);
     					
     		      }
     	  	   }
     	  }
     	  if(Number(values)>Number(ckeckallval)){
 	 	 return "1";	
 	  }
 	  return "0";
   }
 function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
    m=Math.pow(10,Math.max(r1,r2)) 
    return (arg1*m+arg2*m)/m 
} 
</script>


