<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.util.*" %>
<%@ page import="goodbaby.bid.InsertMx" %>
<%
	
	String gyss = Util.null2String(request.getParameter("gyss"));
	InsertMx ca = new InsertMx();
	String result = "";
	if(gyss.length()>0){
		try {
			
			result = ca.gys(gyss).toString();
			
		} catch (Exception e) {
			result="";
			out.print(e.getMessage());
		}	
	}
		
	out.print(result);



%>