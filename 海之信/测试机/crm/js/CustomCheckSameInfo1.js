jQuery(document).ready(function(){

	var nameCheck = "#field6699";  // 客户名称验证
	var telCheck = "#field6700";  // 客户电话验证信息
	var webCheck = "#field6701";  // 网站验证信息
	
	checkCustomize = function(){ 
		var name_val = jQuery(nameCheck).val();
		
		if(name_val=="重复"){
			alert("名称重复，请查询后重新填写！");
			return false;
		}
		
		var tel_val = jQuery(telCheck).val();
		
		if(tel_val=="重复"){
			alert("电话信息重复，请查询后重新填写！");
			return false;
		}
		
		var web_val = jQuery(webCheck).val();
		
		if(web_val=="重复"){
			alert("网站信息重复，请查询后重新填写！");
			return false;
		}

		return true;
	}
});


