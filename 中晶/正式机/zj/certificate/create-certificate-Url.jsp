﻿<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
<link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>

<link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css" />
<link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>
<script type="text/javascript">
$(function(){
    $('.e8_box').Tabs({
        getLine:1,
        iframe:"tabcontentframe",

        staticOnLoad:true
    });
}); 
</script>

<%
  
	String url_1 = "";
	String url_2="";
	String url_3= "";
	String url_4="";
	String url_5= "";
	String url_6="";
	url_1 = "/zj/certificate/create-certificate.jsp?bz=0&subid=5";
	url_2 = "/zj/certificate/create-certificate.jsp?bz=1&subid=5";
	url_3 = "/zj/certificate/create-certificate.jsp?bz=0&subid=7";
	url_4 = "/zj/certificate/create-certificate.jsp?bz=1&subid=7";
	url_5 = "/zj/certificate/create-certificate.jsp?bz=0&subid=6";
	url_6 = "/zj/certificate/create-certificate.jsp?bz=1&subid=6";
%>


</head>
 <BODY scroll="no">
 
	<div class="e8_box demo2">
		<div class="e8_boxhead">
			<div class="div_e8_xtree" id="div_e8_xtree"></div>
			<div class="e8_tablogo" id="e8_tablogo" style="margin-left: 6px; background-image: url('/js/tabs/images/nav/mnav0_wev8.png');"></div>
			<div class="e8_ultab">
				<div class="e8_navtab" id="e8_navtab">
					<span id="objName">生成凭证</span>
				</div>
				<div>
		    <ul class="tab_menu">
		       <li class="current">
					<a target="tabcontentframe" href="<%=url_1%>">中晶科技人民币<span id="allNum_span"></span></a>
				</li>
				<li >
					<a target="tabcontentframe" href="<%=url_2%>">中晶科技美元<span id="allNum_span"></span></a>
				</li>
				<li >
					<a target="tabcontentframe" href="<%=url_3%>">中晶数码人民币<span id="allNum_span"></span></a>
				</li>
				<li >
					<a target="tabcontentframe" href="<%=url_4%>">中晶数码美元<span id="allNum_span"></span></a>
				</li>
				<li >
					<a target="tabcontentframe" href="<%=url_5%>">中晶医疗人民币<span id="allNum_span"></span></a>
				</li>
				<li >
					<a target="tabcontentframe" href="<%=url_6%>">中晶医疗美元<span id="allNum_span"></span></a>
				</li>
		    </ul>
	    <div id="rightBox" class="e8_rightBox">
	    </div>
	    </div>
	    </div>
	    </div>
	    <div class="tab_box">
	        <div>
	             <iframe src="<%=url_1 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_2 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_3 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_4 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_5 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_6 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	        </div>
	    </div>
	</div> 
	<!--  -->

</BODY>
</HTML>
