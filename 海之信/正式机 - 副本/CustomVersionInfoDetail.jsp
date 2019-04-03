
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

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
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";

String customID = Util.null2String(request.getParameter("customID"));
String type=Util.null2String(request.getParameter("type"));
String mode=Util.null2String(request.getParameter("mode"));
if("".equals(customID)){
	customID = "-1";
}
String table_name = "";
String billid = "";

//  归集  tablename  和  billid
if("group".equals(type)){
	table_name = "uf_custom_group";
	billid = "-12";
}
if("custom".equals(type)){
	table_name = "uf_custom";
	billid = "-2";
}
if("supplier".equals(type)){
	table_name = "uf_supplier";
	billid = "-25";
}
if("contact".equals(type)){
	table_name = "uf_Contacts";
	billid = "-6";
}
int superid = 0;
String sql = "select SuperID from "+table_name+" where id="+customID;
RecordSet.executeSql(sql);
if(RecordSet.next()){
	superid = RecordSet.getInt("SuperID");
}

sql = "select fieldname,(select indexdesc from HtmlLabelIndex where id=fieldlabel) as remark "
	+" from workflow_billfield where billid="+billid+" order by dsporder";
List<String> list = new ArrayList<String>();
Map<String,String> mapStr = new HashMap<String,String>();
RecordSet.executeSql(sql);
while(RecordSet.next()){
	String tmp_1 = Util.null2String(RecordSet.getString("fieldname"));
		
	// 关联父类排除
	if(!"".equals(tmp_1)&&!"SuperID".equalsIgnoreCase(tmp_1)){
		list.add(tmp_1);
		mapStr.put(tmp_1,Util.null2String(RecordSet.getString("remark")));
	}
}

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
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>

			</tr>
		</table>
<wea:layout type="2col">
<wea:group context="差异值" attributes="test">
<wea:item attributes="{'colspan':'full'}">
<font color="#FF0000">差异值</font>
</wea:item>	
	<%
		// 查找该版本前的一个版本
		sql = "select MAX(id) as beforID from "+table_name+" where SuperID="+superid+" and id<"+customID;
		RecordSet.executeSql(sql);
		int beforID = 0;
		if(RecordSet.next()){
			beforID = RecordSet.getInt("beforID");
		}
	%>
	<wea:item></wea:item>
	<wea:item>
	<table width="80%" cellspacing="0" cellpadding="0" border="1">
		<tr><td><font size=4px>&nbsp;&nbsp;内容项</font></td><td><font size=4px>&nbsp;&nbsp;旧版本内容</font></td><td><font size=4px>&nbsp;&nbsp;新版本内容</font></td></tr>
	<%
		if(beforID > 0){
			Map<String,String> mapVal = new HashMap<String,String>();
			sql = "select * from "+table_name+" where id="+customID;
			RecordSet.executeSql(sql);
			while(RecordSet.next()){
				for(String str : list){
					mapVal.put(str,Util.null2String(RecordSet.getString(str)));
				}
			}
			sql = "select * from "+table_name+" where id="+beforID;
			RecordSet.executeSql(sql);
			while(RecordSet.next()){
				for(String str : list){
					
					String tmp_str = Util.null2String(RecordSet.getString(str));
					String tmp_now = Util.null2String(mapVal.get(str));
			//		out.println("tmp_str = " + tmp_str +" ; tmp_now = " + tmp_now);
					if(!tmp_str.equals(tmp_now)){
	%>
			<tr><td>&nbsp;&nbsp;<%=mapStr.get(str)%></td><td>&nbsp;&nbsp;<font color="blue"><%=tmp_str%></font></td>
				<td>&nbsp;&nbsp;<font color="red"><%=tmp_now%></font></td></tr>
	<%
		}
		}
			}
				}
	%>
		</table>

	</wea:item>

		
	<wea:item>
	<%
		String tmp_requestId = "";
		String tmp_sql_buff1 = "select requestId from "+table_name+" where id="+customID;
		RecordSet.executeSql(tmp_sql_buff1);
		if(RecordSet.next()){
			tmp_requestId = Util.null2String(RecordSet.getString("requestId"));
		}
	%>
		<script type="text/javascript">
			function openNewInfo() {
				//	openFullWindowForXtable("CustomVersionInfoDetail.jsp?type=custom&customID="+id);
				//	alert(123);
				var title = "";
				var url = "/seahonor/workflow/RequestModifyLogViewIframe.jsp?requestid=<%=tmp_requestId%>";
				var diag_vote = new window.top.Dialog();
				diag_vote.currentWindow = window;
				diag_vote.Width = 1200;		
				diag_vote.Height = 700;
				diag_vote.Modal = true;		
				diag_vote.Title = title;
				diag_vote.URL = url;
				diag_vote.isIframe=false;
				diag_vote.show();
			}

	</script>
		
		<a href="javascript:openNewInfo()">详细修改记录</a>
			
		</wea:item><wea:item></wea:item>
	
	
	<%
		String tmp_sql_buff = "select requestId from "+table_name+" where id="+customID;
		sql = "select wt.nodeid,wn.nodename from workflow_track wt join workflow_nodebase wn on wn.id=wt.nodeId where "
		+" wt.requestId in("+tmp_sql_buff+") group by wt.nodeid,wn.nodename order by nodename desc";
		RecordSet.executeSql(sql);
		while(RecordSet.next()){
			String tmp_nodeId = Util.null2String(RecordSet.getString("nodeid"));
			String tmp_nodeName = Util.null2String(RecordSet.getString("nodename"));
			
	%>
	<wea:item><font size=4px><%=tmp_nodeName%></font></wea:item>
	<wea:item>
		<table width="80%" cellspacing="0" cellpadding="0" border="1">
			<tr><td>&nbsp;&nbsp;序号</td><td>&nbsp;&nbsp;修改内容</td><td>&nbsp;&nbsp;修改人</td><td>&nbsp;&nbsp;修改IP</td><td>&nbsp;&nbsp;修改时间</td></tr>
		<%
			sql = "select wt.fieldOldText,wt.fieldNewText,wt.modifierId,wt.modifierIP,wt.modifyTime,x.indexdesc,x.dsporder from workflow_track wt "
			+" join (select wb.id,indexdesc,wb.dsporder from HtmlLabelIndex hi join workflow_billfield wb on wb.fieldlabel=hi.id) x on wt.fieldid = x.id"
			+" where wt.requestId in("+tmp_sql_buff+") and wt.nodeId="+tmp_nodeId+" order by modifyTime desc,x.dsporder asc ";
			rs.executeSql(sql);
			int index_flag = 0;
			while(rs.next()){
				index_flag++;
				String tmp_fieldOld = Util.null2String(rs.getString("fieldOldText"));
				String tmp_fieldNew = Util.null2String(rs.getString("fieldNewText"));
				String tmp_modifier = Util.null2String(rs.getString("modifierId"));
				String tmp_ip = Util.null2String(rs.getString("modifierIP"));
				String tmp_time = Util.null2String(rs.getString("modifyTime"));
				String tmp_desc = Util.null2String(rs.getString("indexdesc"));
		%>
			<tr><td>&nbsp;&nbsp;<%=index_flag%></td>
				<td>&nbsp;&nbsp;[<%=tmp_desc%>]由"<font color="blue"><%=tmp_fieldOld%></font>"改为"<font color="red"><%=tmp_fieldNew%></font>"</td>
				<td>&nbsp;&nbsp;<%=ResourceComInfo.getResourcename(tmp_modifier)%></td>
				<td>&nbsp;&nbsp;<%=tmp_ip%></td><td>&nbsp;&nbsp;<%=tmp_time%></td>
			</tr>
		
		<%}%>
		<table>
	</wea:item>
	<%}%>

 </wea:group>					
	</FORM>

</BODY>
</HTML>
	

