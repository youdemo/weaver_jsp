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
	 String action = (String)session.getAttribute("actionid");
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String alarmid1="";
	String actionid1="";
	String xdfa="";
	String jzrq="";
	String famb="";
	String sjwc="";
	String wcbl="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String sql="select alarmid,actionid ,xdfa,jzrq,famb,sjwc,wcbl  from uf_action_plan where id= '"+action+"'";
	rs.execute(sql);
	if(rs.next()){
	  alarmid1 = Util.null2String(rs.getString("alarmid"));
	  actionid1 = Util.null2String(rs.getString("actionid"));
	  xdfa = Util.null2String(rs.getString("xdfa"));
	  jzrq = Util.null2String(rs.getString("jzrq"));
	  famb = Util.null2String(rs.getString("famb"));
	  sjwc = Util.null2String(rs.getString("sjwc"));
	  wcbl = Util.null2String(rs.getString("wcbl"));
	}
	sql="select requestid from  formtable_main_15  where id=(select max(id) from  formtable_main_15  where alarmid='"+alarmid1+"' and actionid='"+actionid1+"')";
	      int requestid1=0;
		  rs.execute(sql);
		  if(rs.next()){
		  requestid1 = rs.getInt(1);
		  }
		  
	 sql="select is_approve from uf_action_plan where id='"+action+"'";
	      String is_approve_action="";
		  rs.execute(sql);
		  if(rs.next()){
		  is_approve_action = Util.null2String(rs.getString("is_approve"));
		  }
		  int approve1=0;
		  if("2".equals(is_approve_action)){
		  approve1=2;
		  }
      sql="select is_send from uf_sub_action where rownum=1 and alarmid='"+alarmid1+"' and actionid='"+actionid1+"'";

		 String is_send1="";
		 String is_approve1="";
		  rs.execute(sql);
		  if(rs.next()){
		  is_send1 =  Util.null2String(rs.getString("is_send"));
		  }
		   sql="select is_approve from uf_action_plan where alarmid='"+alarmid1+"' and actionid='"+actionid1+"'";
		  rs.execute(sql);
		  if(rs.next()){
		  is_approve1 =  Util.null2String(rs.getString("is_approve"));
		  }
		  
	%>

	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					
					<td class="rightSearchSpan" style="text-align:right;">	
				    <%if(requestid1==0){%>				
					<input type="button" value="新建" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="onBtnNewClick();"/>
				    <%}%>
					<%if(!"2".equals(is_approve1)){%>	
					<input type="button" value="提交审批" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="onBtnApproveClick();"/>				
					<%}%>
					<input type="button" value="返回" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="returnBack();"/>					
					<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
					
				</tr>
			</table>
			
			<% // 查询条件 %>
			
		</FORM>
		<table style="width:100%;">
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">Action ID： <%=actionid1%></td>
			<td></td>
			<td   style="text-align:left; width:25%;font-size: 10pt;height:25px;">Alarm ID： <%=alarmid1%></td>
		</tr>
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">行动方案： <%=xdfa%></td>
			<td></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">截止日期： <%=jzrq%></td>
		</tr>
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">方案目标： <%=famb%></td>
			<td></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">实际完成： <%=sjwc%></td>
		</tr>
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">完成比率： <%=wcbl%> </td>
			<td></td>
			<td   style="text-align:left; width:25%;font-size: 10pt;height:25px;"><a href="javascript:viewApprove();" style="color:blue;text-decoration:underline;">审批意见查询</a></td>
		</tr>
		
		</table>
		<%
		
		String backfields = "id,id as idkey,subitem,xdfajd,decode(jdjz,1,'进行中',2,'已完成','未开始') as jdjz,jzrq,wcrq,wcbl,'编辑' as xianshi";
		String fromSql  = " uf_sub_action ";
		String sqlWhere = " where 1=1 ";
		String orderby = " id asc";
		sqlWhere +=" and alarmid='"+alarmid1+"' and actionid='"+actionid1+"'";
		String tableString = "";
		String  operateString= "";
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"10%\" text=\"Sub Item\" column=\"subitem\" orderkey=\"subitem\"/>"+
			"               <col width=\"20%\" text=\"行动方案阶段\" column=\"xdfajd\" orderkey=\"xdfajd\"/>"+
			"               <col width=\"15%\" text=\"阶段进展\" column=\"jdjz\" orderkey=\"jdjz\"/>"+
			"               <col width=\"15%\" text=\"截止日期\" column=\"jzrq\" orderkey=\"jzrq\"/>"+
			"               <col width=\"10%\" text=\"完成日期\" column=\"wcrq\" orderkey=\"wcrq\"/>"+
			"               <col width=\"10%\" text=\"完成比率\" column=\"wcbl\" orderkey=\"wcbl\"/>";
			if(requestid1 ==0){
			tableString+="               <col width=\"10%\" text=\"操作\" column=\"xianshi\" orderkey=\"xianshi\" linkkey=\"billid\" linkvaluecolumn=\"idkey\"  href=\"/formmode/view/AddFormMode.jsp?mainid=0&amp;modeId=21&amp;formId=-3&amp;type=2\" target=\"_fullwindow\" />";
		    }else{
			tableString+="               <col width=\"10%\" text=\"操作\" column=\"\" orderkey=\"\"  />";
			}
		    tableString+="			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
	var subWindows;
	var t_q;
		function onBtnNewClick() {
			var id_alarm=<%=alarmid1%>;
			var id_action= "<%=actionid1%>";
			var title = "";
		var url = "";
		title = "新建 Sub Action";
		url="/formmode/view/AddFormMode.jsp?mainid=0&modeId=21&formId=-3&type=1&field5835="+id_action+"&field6062="+id_alarm+"";

		var width = screen.width ;
		var height = screen.height ;
		if (height == 768 ) height -= 75 ;
		if (height == 600 ) height -= 60 ;
		var szFeatures = "top=0," ; 
		szFeatures +="left=0," ;
		szFeatures +="width="+width+"," ;
		szFeatures +="height="+height+"," ;
		szFeatures +="directories=no," ;
		szFeatures +="status=yes," ;
		szFeatures +="menubar=no," ;

		if (height <= 600 ) szFeatures +="scrollbars=yes," ;
		else szFeatures +="scrollbars=no," ;

		szFeatures +="resizable=yes" ; //channelmode
	    subWindows = window.open(url,"",szFeatures) ;
		  t_q=setInterval(function()
        {          
                if(subWindows.closed)        
                {
                    
                    clearInterval(t_q);
                    window.location.reload();
                   
                }
            }
        ,200);		
			
			
		}
	    function returnBack(){
			var alarmid=<%=alarmid1%>;
			var url="/alarm/getActionPlanUrl.jsp?alarmid="+alarmid+"";
			window.open(url,"_parent");
		}
		
		function refersh() {
  			window.location.reload();
  		}
		  
        function onBtnApproveClick() {
			var val=<%=action%>;
		var title = "";
		var url = "";
		<% 
		 int count=0;
		 sql="select count(1) from uf_sub_action where  alarmid = '"+alarmid1+"' and actionid='"+actionid1+"'";
		 rs.execute(sql);
		 if(rs.next()){
			 count= rs.getInt(1);
		 }
		%>
		var aa=<%=requestid1%>;
		var cnt=<%=count%>
		if(!cnt>0){
			alert("请先创建Sub Action")
			return false;
		}
		title = "Sub Action  审批流程";
		if(!aa>0){
		url="/workflow/request/AddRequest.jsp?workflowid=81&field6102="+val;
		}else{
	     url="/workflow/request/ViewRequest.jsp?requestid="+aa;
		}
		var width = screen.width ;
		var height = screen.height ;
		if (height == 768 ) height -= 75 ;
		if (height == 600 ) height -= 60 ;
		var szFeatures = "top=0," ; 
		szFeatures +="left=0," ;
		szFeatures +="width="+width+"," ;
		szFeatures +="height="+height+"," ;
		szFeatures +="directories=no," ;
		szFeatures +="status=yes," ;
		szFeatures +="menubar=no," ;

		if (height <= 600 ) szFeatures +="scrollbars=yes," ;
		else szFeatures +="scrollbars=no," ;

		szFeatures +="resizable=yes" ; //channelmode
	    subWindows = window.open(url,"",szFeatures) ;
		  t_q=setInterval(function()
        {          
                if(subWindows.closed)        
                {
                    
                    clearInterval(t_q);
                    window.location.reload();
                   
                }
            }
        ,200);				
			
		}
		
		function viewApprove(){
			var aa=<%=requestid1%>;
			var app="<%=is_approve1%>";
			var title = "";
		var url = "";
		 if("2"!=app){
			alert("请先提交审批")
		}else{
				title = "审批意见查询";
		url="/workflow/request/ViewRequest.jsp?requestid="+aa;
		
		
		var width = screen.width ;
		var height = screen.height ;
		if (height == 768 ) height -= 75 ;
		if (height == 600 ) height -= 60 ;
		var szFeatures = "top=0," ; 
		szFeatures +="left=0," ;
		szFeatures +="width="+width+"," ;
		szFeatures +="height="+height+"," ;
		szFeatures +="directories=no," ;
		szFeatures +="status=yes," ;
		szFeatures +="menubar=no," ;

		if (height <= 600 ) szFeatures +="scrollbars=yes," ;
		else szFeatures +="scrollbars=no," ;

		szFeatures +="resizable=yes" ; //channelmode
	    subWindows = window.open(url,"",szFeatures) ;
		  t_q=setInterval(function()
        {          
                if(subWindows.closed)        
                {
                    
                    clearInterval(t_q);
                    window.location.reload();
                   
                }
            }
        ,200);
		}
		
		}
	</script>
</BODY>
</HTML>