<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<!-- [企业法人汇总报表] -->
<%
	if(!cu.canOperate(user,"3"))//不具有入口权限
	{
		response.sendRedirect("/notice/noright.jsp");
		return;
	}	
	String openNew = Util.null2String(request.getParameter("openNew"));
	String companyname = Util.null2String(request.getParameter("companyname"));
 %>
<jsp:include page="/cpcompanyinfo/CompanyInfoContainer.jsp" />

 
<html>
	<head>
		<script type="text/javascript">
		
			jQuery(document).ready(function(){
				
			});
			
			function searchReport1(){
				var o4searchTX="";
				var o4searchSL="";
				o4searchTX = jQuery("#searchTX").val();
				o4searchSL = jQuery("#searchSL").val();
				jQuery("#frame2list").attr("src","CompanyInfoReport1List.jsp?o4searchTX="+o4searchTX+"&o4searchSL="+o4searchSL);
			}
		
			function toExcel(){
				var o4params = {
					o4searchTX : jQuery("#searchTX").val(),
					o4searchSL : jQuery("#searchSL").val()
				};
				jQuery.post("/cpcompanyinfo/action/CPCompanyReport1toExcel.jsp",o4params,function(data){
					//alert("成功");
				});
			}
		</script>
		<!--[if lte IE 6]>
<script type="text/javascript" src="js/DD_belatedPNG_0.0.7a.js"></script>

<script>

DD_belatedPNG.fix('.png,.png:hover');

</script>
<![endif]-->
	</head>
	
	<body>
		<!--头部 end-->
		<!--导航 start-->
		<div class="OBoxW ">
			<div class="FL OBoxW">
				<ul style="width: 300px; float: right">
					<!-- <li class="FontYahei liBtnStyle">
						<a id="cantacts" href="#"><img src="images/k_03.png"
								class="png" />通讯录</a>
					</li>
					<li class="FontYahei liBtnStyle">
						<img src="images/k_02.png" class="png" />
						网上助手
					</li>
					<li class="FontYahei liBtnStyle">
						<img src="images/k_01.png" class="png" />
						知识门户
					</li>
					<div class="clear"></div>
					 -->
				</ul>
			</div>
			<div class="FL BoxWAuto OBoxWBg1 ">
				<div class="border19 ">
					<ul class="ONavSubnav PTop10 cBlue FL PB3">
						<span class="cBlue FontYahei FS16 PL15"><%=SystemEnv.getHtmlLabelName(30939,user.getLanguage())%></span>
					</ul>
					<!--表单 start-->
					<!-- <div class="PTop5 FR PR10">
						<ul class="ONavSubnav cBlack FR MT3">
							<li returerel="">
								<a
									href="javascript:window.location.href='/cpcompanyinfo/CompanyManageMain.jsp?companyid=<=companyid%>&companyname=<=companyname%>&archivenum=<=archivenum%>';"
									class="hover"><div>
										<div>
											返回
										</div>
									</div> </a>
							</li>
						</ul>
					</div>
					<!--表单 end-->
					<div class="clear"></div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<!--导航 end -->
		<!--主要内容 start-->
		<div class="OBoxW PTop5">
			<div class="OBoxTit">
				<span class="FontYahei cWhite PL20 PTop5 FL"><%=SystemEnv.getHtmlLabelName(31034,user.getLanguage())%>：</span><span
					class="FL PT3 PLeft5"><input name="input" type="text" id="searchTX"
						class="OInput BoxW110" value="" /> </span><span class="FL PT3 PLeft5">
					<select class="OSelect" id="searchSL">
						<option value="archivenum"><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
						<option value="companyname"><%=SystemEnv.getHtmlLabelName(1976,user.getLanguage())%></option>
						<option value="corporation"><%=SystemEnv.getHtmlLabelName(23797,user.getLanguage())%></option>
						<option value="d-officename"><%=SystemEnv.getHtmlLabelName(31061,user.getLanguage())%></option>
						<option value="j-officename"><%=SystemEnv.getHtmlLabelName(31062,user.getLanguage())%></option>
						<option value="generalmanager"><%=SystemEnv.getHtmlLabelName(20696,user.getLanguage())%></option>
					</select> </span>
				<span class="FontYahei cWhite PL20 PTop5 FL"
					style="padding-top: 3px;">
					<ul class="OBtnUl FL cBlack6">
						<li>
							<em><i><a href="javascript:searchReport1();"><%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%></a> </i> </em>
						</li>
					</ul> </span>
				<ul class="OContRightMsg cBlack FR MT5">
					<!--<li>
						<a id="viewBtn" href="javascript:toExcel();"
							class="hover"><div>
								<div>
									导出Excel
								</div>
							</div> </a>
					</li>
					<li>
						<a id="newBtn" href="javascript:beforeNew();"
							rel="CompanyBusinessLicenseMaint.jsp?btnid=newBtn&companyid=<=companyid%>&companyname=<=companyname%>"
							class="hover"><div>
								<div>
									新增
								</div>
							</div> </a>
					</li>
					<li>
						<a id="editBtn" href="javascript:beforeEditorView('editBtn');"
							rel="CompanyBusinessLicenseMaint.jsp?btnid=editBtn&companyid=<=companyid%>&companyname=<=companyname%>"
							class="hover"><div>
								<div>
									修改
								</div>
							</div> </a>
					</li>
					<li>
						<a id="delBtn" href="javascript:delMutiList2Info();" class="hover"><div>
								<div>
									删除
								</div>
							</div> </a>
					</li>-->
					<!-- <li>
						<a href="javascript:void(0);" class="hover"><div>
								<div>
									下载
								</div>
							</div> </a>
					</li>
					<li>
						<a href="javascript:void(0);" class="hover"><div>
								<div>
									日志
								</div>
							</div> </a>
					</li> -->
				</ul>
			</div>
			<div id="listcontent" class="OContRightScroll OScrollHeight4 MT5"  style="height: 500px">
				<iframe id="frame2list" src="CompanyInfoReport1List.jsp"
					width="100%" height="100%" frameborder=no scrolling=no>
					
				</iframe>
			</div>


			<!--主要内容 end-->
		</div>
	</body>
</html>