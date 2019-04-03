<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<%
    String level= Util.null2String(request.getParameter("level"));
	String id= Util.null2String(request.getParameter("id"));
	
	String name = ""; //名称
	String description = "";//说明
	String code = "";//编码
	
	if(!"".equals(id)){
		String sql = "select * from firstDepLeft where id = '"+id+"'";
		rs.executeSql(sql);
		if(rs.next()){
			name = rs.getString("name");
			description = rs.getString("description");
			code = rs.getString("code");
		}
	}

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "一级部门 : 维护";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!"".equals(id)){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDelete(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",firstDepList.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

<FORM style="MARGIN-TOP: 0px" name=right method=post action="firstDepOperation.jsp" >
  <input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <input class=inputstyle type="hidden" name="operation" />
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title>
      <TH colSpan=2>一级部门维护</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></td>
      <td class=Field> 
        <input class=inputstyle name=name size="30" value="<%=name %>" onchange='checkinput("name","nameimage")'>
              <SPAN id=nameimage></SPAN>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    <td>部门编码</td>
  <td class=field>
  <input type=text name="code" value="<%=code%>"></td>
    <tr> 
    <TR><TD class=Line colSpan=2></TD></TR>
      <td><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></td>
      <td class=Field> 
        <textarea class=inputstyle name="description" cols="60" rows=4><%=description %></textarea>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    </TBODY> 
  </TABLE>
</FORM>
</td>
</tr>
</TABLE>
</td>	
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
<Script language=javascript>
function submitData(obj) {
        if(check_form(right,"name,code")){
            right.submit();
            obj.disabled=true;
        }
}
function doDelete(obj){
	if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
		right.operation.value="delete";
		right.submit();
    }
}
</script>

<script language=vbs>
sub onShowDepartment()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	departmentspan.innerHtml = id(1)
	right.depID.value=id(0)
	else
	departmentspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	right.depID.value=""
	end if
	end if
end sub
sub onShowBudgetfeeType()
    level=right.feelevel.value-1
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp?level="&level)
    if (Not IsEmpty(id)) then
		if id(0)<> 0 then
            supsubjectspan.innerHtml = id(1)
			right.supsubject.value=id(0)
			else
			supsubjectspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			right.supsubject.value=""
		end if
	end if
end sub
</script>

</BODY>
</HTML>