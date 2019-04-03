<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%
	String url = Util.null2String(request.getParameter("url"));
	String title = Util.null2String(request.getParameter("title"));
	String isclose = Util.null2String(request.getParameter("isclose"));
	String from = Util.null2String(request.getParameter("from"));
	if("batchshare".equals(from)){
		url+="&paraid="+Util.null2String(request.getParameter("paraid"));
	}
%>
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
        mouldID:"<%= MouldIDConst.getID("proj")%>",
        staticOnLoad:true
    });
}); 
if("<%=from %>"=="batchshare"){
	window.notExecute = true;
}
</script>
<script type="text/javascript">
var parentWin;
var parentDialog;
if("<%=isclose%>"=="1"){
	try{
		
		parentWin = parent.getParentWindow(window);
		parentDialog = parent.getDialog(window);
		parentDialog.close();
		parentWin._table.reLoad();
		//parentWin.reloadPage();
	}catch(e){
		if(window.console){
			console.log("error:"+e);
		}
	}
		
}
</script>
<%
	if("1".equals(isclose)){
		return;
	}
%>

</head>
<BODY scroll="no">
	<div class="e8_box demo2">
		<div class="e8_boxhead">
			<div class="div_e8_xtree" id="div_e8_xtree"></div>
			<div class="e8_tablogo" id="e8_tablogo"></div>
			<div class="e8_ultab">
				<div class="e8_navtab" id="e8_navtab">
					<span id="objName"></span>
				</div>
				<div>
		    <ul class="tab_menu">
		       	<li><a href="#" onclick="return false" class="defaultTab" target="tabcontentframe"><%=TimeUtil.getCurrentTimeString() %></a></li>
		    </ul>
	    <div id="rightBox" class="e8_rightBox">
	    </div>
	    </div>
	    </div>
	    </div>
	    <div class="tab_box">
	        <div>
	            <iframe src="<%=url %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	        </div>
	    </div>
	</div>  
<script type="text/javascript">	
$(function(){
	setTabObjName("<%=title %>");
});
</script>   
</BODY>
</HTML>
