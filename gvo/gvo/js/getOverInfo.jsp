<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String sql = "";
String belongDate = request.getParameter("belongDate");//归属日期
//String xjlxbm = request.getParameter("xjlxbm");//休假类型编码
String emp_code = request.getParameter("emp_code");//员工工号
String year = belongDate.substring(0,4);

if(belongDate.length()>0&&emp_code.length()>0){	
	sql = " select * from V_HRJBLJTOTAL_PIVOT where ygh='"+emp_code+"' and year='"+year+"' ";
	rs.executeSql(sql);
	if(rs.next()){
		String month1 = Util.null2String(rs.getString("month1"));
		String month2 = Util.null2String(rs.getString("month2"));
		String month3 = Util.null2String(rs.getString("month3"));
		String month4 = Util.null2String(rs.getString("month4"));
		String month5 = Util.null2String(rs.getString("month5"));
		String month6 = Util.null2String(rs.getString("month6"));
		String month7 = Util.null2String(rs.getString("month7"));
		String month8 = Util.null2String(rs.getString("month8"));
		String month9 = Util.null2String(rs.getString("month9"));
		String month10 = Util.null2String(rs.getString("month10"));
		String month11 = Util.null2String(rs.getString("month11"));
		String month12 = Util.null2String(rs.getString("month12"));

		json.append("{");
		json.append("month1:").append("'").append(month1).append("'").append(",");
		json.append("month2:").append("'").append(month2).append("'").append(",");
		json.append("month3:").append("'").append(month3).append("'").append(",");
		json.append("month4:").append("'").append(month4).append("'").append(",");
		json.append("month5:").append("'").append(month5).append("'").append(",");
		json.append("month6:").append("'").append(month6).append("'").append(",");
		json.append("month7:").append("'").append(month7).append("'").append(",");
		json.append("month8:").append("'").append(month8).append("'").append(",");
		json.append("month9:").append("'").append(month9).append("'").append(",");
		json.append("month10:").append("'").append(month10).append("'").append(",");
		json.append("month11:").append("'").append(month11).append("'").append(",");
		json.append("month12:").append("'").append(month12).append("'");
		json.append("}");
	}
	
	
}
out.println(json.toString());

%>
