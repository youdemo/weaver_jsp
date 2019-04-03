<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	
	Calendar now = Calendar.getInstance();
	String alarmid = Util.null2String(request.getParameter("alarmid"));
	String kpicode = Util.null2String(request.getParameter("kpicode"));
	String targetname = Util.null2String(request.getParameter("targetname"));
	String alarmtime = Util.null2String(request.getParameter("alarmtime"));
	String alarmlevel = Util.null2String(request.getParameter("alarmlevel"));
	int userid = user.getUID();
	
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/CRM/report/getProjectReportAll.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">

				

				<wea:item>Alarm ID</wea:item>
				<wea:item>
				 <input name="alarmid" id="alarmid" class="InputStyle" type="text" value=""/>
				</wea:item>
                <wea:item>KPI代码</wea:item>
				<wea:item>
				 <input name="kpicode" id="kpicode" class="InputStyle" type="text" value=""/>
				</wea:item>
				<wea:item>指标名称</wea:item>
				<wea:item>
				 <input name="targetname" id="targetname" class="InputStyle" type="text" value=""/>
				</wea:item>
				<wea:item>Alarm时间段</wea:item>
				<wea:item>
				 <input name="alarmtime" id="alarmtime" class="InputStyle" type="text" value=""/>
				</wea:item>
				<wea:item>Alarm级别</wea:item>
				<wea:item>
				 <input name="alarmlevel" id="alarmlevel" class="InputStyle" type="text" value=""/>
				</wea:item>
				

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		</FORM>
		<table style="width:100%;">
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:40px;">组织单位：福建省区</td>
			<td></td>
			<td   style="text-align:left; width:25%;font-size: 10pt;height:40px;">时间区间：201605.W4</td>
			</tr>
		</table>
		<%
		String backfields = "id,kfcode,kfname,duration,target_val,actual_val,approvestatus,province,creat_ind,Receipt_NO";
		String fromSql  = " uf_alarm_info";
		String sqlWhere = " where 1=1 ";
		String orderby = " kfcode asc";
		String tableString = "";
		if(!"".equals(alarmid)){
		  sqlWhere +=" and id = "+alarmid;
		}
		if(!"".equals(kpicode)){
		  sqlWhere +=" and kfcode = "+kpicode;
		}
		if(!"".equals(targetname)){
		  sqlWhere +=" and kfname = "+targetname;
		}
		if(!"".equals(alarmtime)){
		  sqlWhere +=" and duration = "+alarmtime;
		}
		if(!"".equals(alarmlevel)){
		  sqlWhere +=" and province = "+alarmlevel;
		}
		
		String  operateString= "";
		operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:createAction();\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"新建\" index=\"1\"/> "+
		                    "</operates>";
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"10%\" text=\"Alarm ID\" column=\"takeordermonth\" orderkey=\"takeordermonth\"/>"+
			"               <col width=\"10%\" text=\"KPI代码\" column=\"cusumer\" orderkey=\"cusumer\"/>"+
			"               <col width=\"10%\" text=\"指标名称\" column=\"name\" orderkey=\"name\"/>"+
			"               <col width=\"15%\" text=\"Alarm时间段\" column=\"peracceptancemonth\" orderkey=\"peracceptancemonth\"/>"+
			"               <col width=\"15%\" text=\"目标值\" column=\"quity\" orderkey=\"quity\"/>"+
			"               <col width=\"15%\" text=\"实际值\" column=\"singleprice\" orderkey=\"singleprice\"/>"+
			"               <col width=\"15%\" text=\"审批状态\" column=\"itembuget\" orderkey=\"itembuget\"/>"+	
			"               <col width=\"10%\" text=\"Alarm级别\" column=\"pcentchange\" orderkey=\"pcentchange\"/>"+		
			
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true" />
	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
       function createAction(id){
		url="/alarm/getActionPlanUrl.jsp?alarmid="+id+"";
		window.open(url)
	   }
	</script>
</BODY>
</HTML>