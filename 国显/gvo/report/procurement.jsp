<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<link rel="stylesheet" type="text/css" href="/gvo/report/css/css.css">

<script type="text/javascript" src="/js/weaver.js"></script>
</head>
<body>

<div class="center">

 <div class="head">
  <div class="headlogo"><img src="images/headlogo.png" /></div></div>
  <div class="reportmenu">
   
    <ul><h3><a href="/gvo/report/index.jsp">首页</a></h3>
	   <li><a href="/gvo/report/report.jsp">生产制造报表</a></li>
	   <li><a href="/gvo/report/production.jsp">品质报表</a></li>
	   <li><a href="/gvo/report/sales.jsp">销售报表</a></li>
	   <li><a href="/gvo/report/procurement.jsp">采购报表</a></li>
	   <li><a href="/gvo/report/inventory.jsp">库存报表</a></li>
	   <li><a href="/gvo/report/financial.jsp">财务报表</a></li>
	   <li><a href="/gvo/report/personnel.jsp">人事报表</a></li>
	</ul>
  </div>
  <div class="content">
     <!--<div class="sidebar">-->
	   <!--<div class="sidebarmenu">
	     <ul>
		   <h3><a href="#">生产制造报表</a></h3>
		   <li><a href="#">模组/屏体工单产出率报表</a></li>
		   <li><a href="#">委外产出率报表</a></li>
		   <li><a href="#">Array/Oled工单产出报表</a></li>
		   
		 </ul>
	   </div>-->
   <table class="special " width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
	  <td width="180" valign="top" bgcolor="#d2d2d2" style="overflow:auto;">
	   <div id="main1" style="color:#333; width:180px;" onclick="document.all.child1.style.display=(document.all.child1.style.display =='none')?'':'none'" >生产制造报表+</div>
        <div id="child1" style="display:none">
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=205&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402375755=" target="main">工单报废率统计报表</a>
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=201&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402465270=" target="main">量产批次良率报表</a>
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=102&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402550789=" target="main">机台状态汇总报表</a>
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=103&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402611711=" target="main">机台通讯状态汇总报表</a>
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=202&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402635232=" target="main">ARRAY段工单产出率明细报表</a>
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=203&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402683095=" target="main">OLED段工单产出率明细报表</a>
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=222&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402724493=" target="main">屏体段工单产出率明细报表</a>
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=221&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402780113=" target="main">模组段工单产出率明细报表</a>		   
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=204&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402829907=" target="main">薄化委外产出率明细报表</a>
		</div>
		<div id="main2" style="color:#333; width:180px;" onclick="document.all.child2.style.display=(document.all.child2.style.display =='none')?'':'none'" >品质报表+</div>
        <div id="child2" style="display:none">
		  <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=225&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402944854=" target="main">敬请期待</a>
		</div>
		<div id="main3" style="color:#333; width:180px;" onclick="document.all.child3.style.display=(document.all.child3.style.display =='none')?'':'none'" >销售报表+</div>
        <div id="child3" style="display:none">
		  <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=225&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402944854=" target="main">敬请期待</a>
		</div>
		<div id="main4" style="color:#333; width:180px;" onclick="document.all.child4.style.display=(document.all.child4.style.display =='none')?'':'none'" >采购报表+</div>
        <div id="child4" style="display:block">
		  <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=225&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402944854=" target="main">敬请期待</a>
		</div>
		<div id="main5" style="color:#333; width:180px;" onclick="document.all.child5.style.display=(document.all.child5.style.display =='none')?'':'none'" >库存报表+</div>
        <div id="child5" style="display:none">
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=223&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402861521=" target="main">物料过期预警报表</a>
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=224&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402883589=" target="main">备品备件安全库存自检表</a>
		</div>
		<div id="main6" style="color:#333; width:180px;" onclick="document.all.child6.style.display=(document.all.child6.style.display =='none')?'':'none'" >财务报表+</div>
        <div id="child6" style="display:none">
		   <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=225&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402944854=" target="main">敬请期待</a>
		</div>
		<div id="main7" style="color:#333; width:180px;" onclick="document.all.child7.style.display=(document.all.child7.style.display =='none')?'':'none'" >人事报表+</div>
        <div id="child7" style="display:none">
		  <a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=226&subCompanyId=24&isfromportal=1&isfromhp=0&e71459403001099=" target="main">月忘打卡次数查询</a>
		</div>
	  <!-- <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr><td width="180" height="30" bgcolor="#d2d2d2" style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">模组/屏体工单产出率报表</a></td></tr>
          <tr bgcolor="#d2d2d2"><td height="30" bgcolor="#d2d2d2"  style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a></td></tr>
          <tr bgcolor="#d2d2d2"><td height="30" valign="top" bgcolor="#d2d2d2"  style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></td></tr>
       </table>-->
      </td>
      <td valign="top" height="800"><iframe name="main" src="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=225&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402944854=" frameborder="0" scrolling="auto" width="100%" height="100%"></iframe></td>
     </tr>
   </table>
	 <!--</div>-->
	 <!--<div class="mainbody"><a href="/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456814771797=" target="_self">00</a></div>-->
  </div>
 
</div>
</body>
</html>
