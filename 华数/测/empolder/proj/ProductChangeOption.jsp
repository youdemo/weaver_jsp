<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util,weaver.docs.docs.CustomFieldManager" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%

	String[] ids = request.getParameterValues("keyID");//主键ID
	String[] description = request.getParameterValues("description");// 描述
	String[] content = request.getParameterValues("content");//变更内容
	String[] changeUSER = request.getParameterValues("changeUSER");//变更人
	String[] changeData = request.getParameterValues("changeData");//变更时间
	String[] productVersionID = request.getParameterValues("productVersionID");//产品线
	String[] isDelete = request.getParameterValues("isDelete");//删除标识

	String sql = "";
	if(ids != null && ids.length > 0){
		for(int i = 0;i < ids.length ; i++){
			if("-1".equals(ids[i]) && "1".equals(isDelete[i])){//新添加的且被删除了，不进行任何操作
				continue;
			}else if("-1".equals(ids[i]) && "0".equals(isDelete[i])){//新添加的且删除标志为否，进行添加操作
				sql = "INSERT INTO Productchange (description,content,changeUSER,changeData,productVersionID,description1,isShow) VALUES ('" + description[i] + "','" + content[i] + "','" + changeUSER[i] + "','" + changeData[i] + "','" + productVersionID[i] + "','" + description[i] + "','0')";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "1".equals(isDelete[i])) {//已存在的记录且删除标志为是，进行删除操作
				sql = "DELETE from Productchange WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "0".equals(isDelete[i])) {//已存在的记录且删除标志为否，进行修改操作
				sql = "UPDATE Productchange SET description = '" + description[i] + "',content = '" + content[i] + "',changeUSER = '" + changeUSER[i] + "',changeData = '" + changeData[i] + "' WHERE id = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
			}
		}
	}

	response.sendRedirect("ProductAdd.jsp?id="+productVersionID[0]) ;
		
%>

