<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="gw" class="gvo.work.GetWebValue" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String qjr_code = request.getParameter("qjr_code");//请假人工号
new BaseBean().writeLog("请假人工号--"+qjr_code);

if(!"".equals(qjr_code) && qjr_code != null){	
	
 	json = gw.getInfo(qjr_code);
// 	json.append("{");
// 	json.append("'test':").append("'").append("测试成功").append("'").append(",");
// 	json.append("'test1':").append("'").append("测试成功2").append("'");
// 	json.append("}");
	
	
}
out.println(json.toString());

%>

