var name = ["field6040","field6041"];  // 客户名称
var code = ["field6044","field6045"];  // 客户代码
var country = ["field6048","field6049"];  // 所属国家
var enter = ["field6052","field6053"];  // 企业类型
var industry = ["field6056","field6056"];  // 企业类型
var tel = ["field6060","field6061"];  // 公司电话
var fax = ["field6064","field6065"];  // 公司传真
var address = ["field6067","field6069"];  // 公司地址
var zipcode = ["field6072","field6073"];  // 公司邮编
var email = ["field6076","field6077"];  // 公司邮箱
var website = ["field6080","field6081"];  // 公司网站
var enRemark = ["field6084","field6085"];  // 英文快速
var jpRemark = ["field6088","field6089"];  // 日文快速
var remark = ["field6092","field6093"];  // 备注
var someB = ["field6096","field6097"];  // 提供人
var status = ["field6100","field6101"]; // 客户状态
var customGroup = ["field6104","field6105"]; // 客户集团
	
// 所有信息数组
var all_pro = [name,code,country,enter,industry,tel,fax,address,zipcode,email,website,enRemark,jpRemark,remark,someB,status,customGroup];

// 延迟循环绑定
setTimeout('yourFunction()',1000);

function yourFunction(){
	for(var i=0;i<all_pro.length;i++){
		var pro_x = all_pro[i];
		for(var j=0;j<pro_x.length;j++){
			bindProArr(pro_x,j);
		}
	}
}

var s_tmp_1 = "#field6041";
jQuery("#"+s_tmp_1).bind("propertychange",function(){	
		alert("123");
		var chk = document.getElementById(s_tmp_1);
		alert("chk = " + chk + " ; chk.checked = " + chk.checked);
	});


function bindProArr(pro_x,index){
	var tmp_1 = pro_x[index];
//	alert("tmp_1 = " + tmp_1);
	
	/*
	jQuery("#"+tmp_1).bind("propertychange",function(){	
		alert("123");
		var chk = document.getElementById(tmp_1);
		alert("chk = " + chk + " ; chk.checked = " + chk.checked);
		if(chk.checked){
			for(var i=0;i<pro_x.length;i++){
				if(i!=index){
					document.getElementById(pro_x[i]).checked = false;
				}
			}
		}else{
			document.getElementById(pro_x[index]).checked = true;
		}
	}); */
}
