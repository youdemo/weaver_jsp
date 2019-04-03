
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.general.Util"%>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="GetFormDetailInfo" class="weaver.workflow.automatic.GetFormDetailInfo" scope="page" />
<jsp:useBean id="DataSourceXML" class="weaver.servicefiles.DataSourceXML" scope="page" />
<% 
if(!HrmUserVarify.checkUserRight("OutDataInterface:Setting",user)) {
    response.sendRedirect("/notice/noright.jsp") ;
    return ;
}
%>
<%
String paixu="0";String shifou = "1";
String setname = "";
String datasourceid = "";
String workflowname = "";
String  describe="";
String outermaintable = "";
String keyfield = "";
String datarecordtype = "";
String requestid = "";
String FTriggerFlag = "";
String FTriggerFlagValue = "";
String outermainwhere = "";
String successback = "";
String failback = "";
String outerdetailtables = "";
String outerdetailwheres = "";

ArrayList outerdetailtablesArr = new ArrayList();
ArrayList outerdetailwheresArr = new ArrayList();

String isDialog = Util.null2String(request.getParameter("isdialog"));

String typename = Util.null2String(request.getParameter("typename"));
String backto = Util.null2String(request.getParameter("backto"));
if(!"".equals(backto))
	typename = backto;
String viewid = Util.null2String(request.getParameter("viewid"));
String workflowid = Util.null2String(request.getParameter("workFlowId"));


String operate = Util.null2String(request.getParameter("operate"));
String formID = "";
String isbill = "";
String isview = "";
if(operate.equals("reedit")){//编辑时重新选择流程
    setname = Util.null2String(request.getParameter("setname"));
    workflowid = Util.null2String(request.getParameter("workFlowId"));
	shifou = Util.null2String(request.getParameter("shifou"));
	describe = Util.null2String(request.getParameter("describe"));
    datasourceid = Util.null2String(request.getParameter("datasourceid"));
    
}else{
    RecordSet.executeSql("select * from zoa_wfcode_mapping where id= '"+viewid+"'");
    if(RecordSet.next()){
        setname = Util.null2String(RecordSet.getString("LC_TYPE"));
        workflowid = Util.null2String(RecordSet.getString("WfId"));
        paixu = Util.null2String(RecordSet.getString("shower"));
		shifou = Util.null2String(RecordSet.getString("IsNext"));
        describe = Util.null2String(RecordSet.getString("remark"));
        keyfield = Util.null2String(RecordSet.getString("keyfield"));
        datarecordtype = Util.null2String(RecordSet.getString("datarecordtype"));
        requestid = Util.null2String(RecordSet.getString("requestid"));
        FTriggerFlag = Util.null2String(RecordSet.getString("FTriggerFlag"));
        FTriggerFlagValue = Util.null2String(RecordSet.getString("FTriggerFlagValue"));
        
        outermainwhere = Util.null2String(RecordSet.getString("outermainwhere"));
        successback = Util.null2String(RecordSet.getString("successback"));
        failback = Util.null2String(RecordSet.getString("failback"));
        outerdetailtables = Util.null2String(RecordSet.getString("outerdetailtables"));
        outerdetailwheres = Util.null2String(RecordSet.getString("outerdetailwheres"));
        outerdetailtablesArr = Util.TokenizerString(outerdetailtables,",");
        outerdetailwheresArr = Util.TokenizerString(outerdetailwheres,",");
        isview = Util.null2String(RecordSet.getString("isview"));
        if("".equals(keyfield))
    	keyfield = "id";
    }
}
boolean isexist = false;


if(!"".equals(workflowid))
{
	workflowname = Util.null2String(WorkflowComInfo.getWorkflowname(workflowid));
	isbill = Util.null2String(WorkflowComInfo.getIsBill(workflowid));
	formID = Util.null2String(WorkflowComInfo.getFormId(workflowid));
}
if("".equals(datarecordtype))
	datarecordtype = "1";
int detailcount = GetFormDetailInfo.getDetailNum(formID,isbill);
%>
<html>
<head>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script language="javascript" src="/js/weaver_wev8.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/dragBox/parentShowcol_wev8.js"></script>
<link rel="stylesheet" href="/css/ecology8/request/requestView_wev8.css" type="text/css" />
<script type="text/javascript" src="/wui/common/jquery/plugin/jQuery.modalDialog_wev8.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/wuiform/jquery.wuiform_wev8.js"></script>
<link href="/js/checkbox/jquery.tzCheckbox_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
</head>
<%
String imagefilename = "/images/hdDOC_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(23076,user.getLanguage())+" - "+SystemEnv.getHtmlLabelName(367,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<body id='setbody' <%if("1".equals(isview)){ %> onload="viewSet()"<%} %>>
<%if("1".equals(isDialog)){ %>
<div class="zDialog_div_content">
<script language=javascript >
var parentWin = parent.parent.getParentWindow(parent);

</script>
<%} %>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(1),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(viewid.equals("")){
RCMenu += "{"+SystemEnv.getHtmlLabelName(125540,user.getLanguage())+",javascript:submitData(2),_self} " ;//保存后详细设置
RCMenuHeight += RCMenuHeightStep ;
}

//RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:onBack(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
			<input type="button" id="submitData" value="<%=SystemEnv.getHtmlLabelName(86 ,user.getLanguage()) %>" class="e8_btn_top" onclick="submitData(1)"/>
			<%if(viewid.equals("")){%>
			<input type="button" id="submitAndDetailData" value="<%=SystemEnv.getHtmlLabelName(125540 ,user.getLanguage()) %>" class="e8_btn_top" onclick="submitData(2)"/>
			<%}%>
			<span title="<%=SystemEnv.getHtmlLabelName(23036 ,user.getLanguage()) %>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<form name="frmmain" method="post" action="automaticOperation.jsp">
<input type="hidden" id="operate" name="operate" value="edit">
<input type="hidden" id="typename" name="typename" value="<%=typename%>">
<input type="hidden" id="backto" name="backto" value="<%=backto%>">
<input type="hidden" id="viewid" name="viewid" value="<%=viewid%>">
<input type="hidden" id="detailcount" name="detailcount" value="<%=detailcount%>">
<%if("1".equals(isDialog)){ %>
<input type="hidden" name="isdialog" value="<%=isDialog%>">
<%} %>
<wea:layout>
	<wea:group context='<%=SystemEnv.getHtmlLabelName(21988,user.getLanguage())+SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>' attributes="{'samePair':'BaseInfo','groupOperDisplay':'none'}">
	  <wea:item>SAP流程类型</wea:item>
			<wea:item>
				<wea:required id="setnamespan" required="true" value='<%=setname%>'>
				<input type=text size=35 class=inputstyle style='width:280px!important;' id="setname" name="setname" value="<%=setname%>" onChange="checkinput('setname','setnamespan')">
				</wea:required>
			</wea:item>
	  		<wea:item><%=SystemEnv.getHtmlLabelName(18104,user.getLanguage())%></wea:item>
			<wea:item>
			<%
				if("".equals(viewid)){
			%>
				<!-- input id="workFlowId" class="wuiBrowser" name="workFlowId" _url="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser.jsp" _scroll="no" _callBack="" value="<%=workflowid %>" _displayText="<%=workflowname %>" _displayTemplate="" _required="yes"/ -->
				<brow:browser viewType="0" name="workFlowId" browserValue='<%= ""+workflowid %>'  
					browserUrl="/systeminfo/BrowserMain.jsp?mouldID=workflow&url=/workflow/workflow/WorkflowBrowser.jsp?showvalid=1"
					hasInput="true" isSingle="true" hasBrowser="true" isMustInput='2' hasAdd="false"  
					completeUrl="/data.jsp?type=workflowBrowser&isTemplate=0" linkUrl=""
					browserSpanValue='<%=workflowname %>' width='280px' _callBack="onShowWorkFlowSerach"></brow:browser>
				<%}else{%>
					<%=workflowname %>
					<input type="hidden"  id="workFlowId" name="workFlowId"   value="<%=workflowid%>" >
				<%}%>
			</wea:item>
			<wea:item>是否流转到下一节点</wea:item>
			<wea:item>
				<input type="hidden"  id="shifou" name="shifou"  value="<%=shifou%>" >
				<input type="checkbox" tzCheckbox="true" class=InputStyle id="shifou1" name="shifou1" value="<%=shifou%>" onclick="aa()"   <%if("1".equals(shifou)) {%> checked <%}%>>
				
				
				
			</wea:item>
			<wea:item><%=SystemEnv.getHtmlLabelName(126106,user.getLanguage())%></wea:item>
			<wea:item>
				<wea:required id="paixuspan" required="true" value='<%=paixu%>'>
				<input type=text size=35 class=inputstyle style='width:280px!important;' id="paixu" name="paixu" value="<%=paixu%>" onchange="checkinput('paixu','paixuspan')">
				</wea:required>
			</wea:item>
			<wea:item><%=SystemEnv.getHtmlLabelName(81710,user.getLanguage())%></wea:item><!-- 描述 -->
			<wea:item>
			
				<textarea id="describe" name="describe" cols=100 rows=4   ><%=describe%></textarea>
			
			</wea:item>
		</wea:group>
	</wea:layout>
</form>
<%if("1".equals(isDialog)){ %>
	<div id="zDialog_div_bottom" class="zDialog_div_bottom">
		<input type="button" style="display:none;" class=zd_btn_submit accessKey=S  id=btnsearch value="S-<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%>"></input>
		<wea:layout needImportDefaultJsAndCss="false">
			<wea:group context=""  attributes="{'groupDisplay':'none'}">
				<wea:item type="toolbar">
					<input type="button" class=zd_btn_cancle accessKey=T  id=btncancel value="T-<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>" onclick="onClose();"></input>
				</wea:item>
			</wea:group>
		</wea:layout>
		<script type="text/javascript">
			jQuery(document).ready(function(){
				resizeDialog(document);
			});
		</script>
	</div>
</div>
<%} %>
</body>
</html>
<script language="javascript">
function aa(){
	
	var shifou_val=jQuery("#shifou1").val();
	if(shifou_val==0){
		jQuery("#shifou").val("1");
		jQuery("#shifou1").val("1");
	}else{
		jQuery("#shifou").val("0");
		jQuery("#shifou1").val("0");
	}
	
}



jQuery(document).ready(function(){
	//jQuery("#shifou").val("1");
 jQuery("input[type=checkbox]").each(function(){
  if(jQuery(this).attr("tzCheckbox")=="true"){
   jQuery(this).tzCheckbox({labels:['','']});
  }
 });
});

function checkDetail(objvalue,detailcount,num){
	for(var i=0;i<detailcount;i++){
	  	if(i != num){
		  	var tempouterdetailname = document.getElementById("outerdetailname"+i).value;
		  	if(tempouterdetailname == objvalue){
		  		document.getElementById("outerdetailname"+num).value = "";
		  		alert("<%=SystemEnv.getHtmlLabelName(127192,user.getLanguage())%>");
		  	}
	  	}
        
    }
}
window.onbeforeunload = function protectManageBillFlow(event){
  	if(!checkDataChange())//added by cyril on 2008-06-10 for TD:8828
        return "<%=SystemEnv.getHtmlLabelName(18407,user.getLanguage())%>";
}
$(document).ready(function(){
	wuiform.init();
});
function submitData(type){
	
	var fieldchecks = " setname,workFlowId,paixu,shifou ";//校验必填
	<%
	if("".equals(viewid))
	{
	%>
	if(type==1){//保存
			document.frmmain.operate.value = "add";
	}else if(type==2){//保存后进入详细设置页面
		document.frmmain.operate.value = "addAndDetail";
	}
	<%
	}%>
    if(check_form($GetEle("frmmain"),fieldchecks)){
    	jQuery($GetEle("setbody")).attr("onbeforeunload", "");
		var fan=true;
		var sname =jQuery("#setname").val();	
		var xhr = null;  
		if (window.ActiveXObject) { //IE浏览器 
			
		    xhr = new ActiveXObject("Microsoft.XMLHTTP"); 
		} else if (window.XMLHttpRequest) { 
			xhr = new XMLHttpRequest(); 
		  } 
		if (null != xhr) { 
			
		    xhr.open("GET", "/appdevjsp/HQ/SAPOA/yanzheng.jsp?setname=" +sname+ "&yanbiao=yi&viewid=<%=viewid%>", false);
		              
		    xhr.onreadystatechange = function () { 
		        if (xhr.readyState == 4) { 
		            if (xhr.status == 200) { 
		                var text = xhr.responseText; 
		                text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						if(text!='1'){
						fan=false;	
						top.Dialog.alert(text);//			
						}
		           } 
		        }  
		   } 
		xhr.send(null); 
	    } 
		if(!fan){	
			return fan;
		} 
		$GetEle("frmmain").submit();
       
		
    }
}

function onClose()
{
	parentWin.closeDialog();
}
function ChangeDatarecordType(objvalue)
{
	var type = objvalue;
	if(type=="1")
	{
		hideEle("datarecord");
	}
	else if(type=="2")
	{
		showEle("datarecord");
	}
}
function onShowTableField(type){
	var fieldname = "";
	var datasource = frmmain.datasourceid.value;
	var tablename = frmmain.outermaintable.value;
	//alert("type : "+type+" datasource : "+datasource+" tablename2 : "+tablename2)
   	if(tablename=="")
   	{
   		top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(32253,user.getLanguage())%>");//对应表名未填写，请填写！
   		return "";
   	}
	var urls = "/systeminfo/BrowserMain.jsp?mouldID=workflow&dmltablename="+tablename+"&datasourceid="+datasource+"&url=/workflow/dmlaction/dmlTableFieldsBrowser.jsp";
	return urls;
}
function setTableField(event,data,name,paras,tg){
	//Dialog.alert("event : "+event);
	var obj = null;
	//alert(typeof(tg)+"  event : "+event);
	if(typeof(tg)=='undefined'){
		obj= event.target || event.srcElement;
	}
	else
	{
		obj = tg;
	}
	var fieldname = "";
	if(data){
		if(data.id != ""&& typeof data!='undefined'){
			fieldname = data.name;
		}else{
			fieldname = "";
		}
	}
	//alert("fieldname : "+fieldname+" obj : "+obj)
	obj.nextSibling.value=fieldname;
	$(obj.nextSibling).change();
}
function setDataSource()
{
	jQuery($GetEle("setbody")).attr("onbeforeunload", "");
	parent.parent.document.location.href="/integration/integrationTab.jsp?urlType=3";
}
$(document).ready(function(){
	ChangeDatarecordType(<%=datarecordtype%>);
});
function ChangeDatasource(obj,datasourceidspan){
    if(obj.value!=""&&obj.value!=null) datasourceidspan.innerHTML = "";
    else datasourceidspan.innerHTML = "<img src='/images/BacoError_wev8.gif' align=absmiddle>";
}

</script>
<script type="text/javascript">
function onShowWorkFlowSerach() {
	jQuery($GetEle("setbody")).attr("onbeforeunload", "");
	document.frmmain.operate.value = "reedit";
	document.frmmain.action="/appdevjsp/HQ/SAPOA/automaticsettingEdit.jsp"
   	document.frmmain.submit()
}

</script>
<script language=javascript src="/js/checkData_wev8.js"></script>
