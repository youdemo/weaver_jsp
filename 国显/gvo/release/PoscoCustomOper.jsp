<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	
	String id = Util.null2String(request.getParameter("mid"));
    String sjfxrq = Util.null2String(request.getParameter("monstarttime2"));
    RecordSet.executeSql("update formtable_main_234 set sjfxrq ='"+sjfxrq+"' where id="+id);
%>
<SCRIPT language=VBS>
//window.close("/gvo/visitor/PoscoCustomOper.jsp");
//window.opener.reload("/gvo/visitor/visitorInfo.jsp"); 
</script> 

<script language="javascript">

alert("登记成功！");

window.opener.location.reload("/gvo/release/releaseInfo.jsp"); //刷新父窗口中的网页
window.open('','_self');//关闭IE提醒
window.close("/gvo/release/PoscoCustomOper.jsp");//关闭当前窗窗口

</script>