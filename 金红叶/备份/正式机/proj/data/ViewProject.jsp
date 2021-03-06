<%@page import="weaver.cpt.util.OAuth"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="org.json.JSONObject"%>
<%@page import="weaver.proj.util.SQLUtil"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.Document"%>
<%@page import="org.dom4j.DocumentHelper"%>
<%@page import="java.text.DecimalFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.docs.docs.CustomFieldManager"%>
<%@ page import="weaver.fna.budget.BudgetHandler"%>
<%
String querystr=request.getQueryString();
String projectid = Util.null2String(request.getParameter("ProjID"));
String isfromProjTab = Util.null2String(request.getParameter("isfromProjTab"));
if(!"1".equals(isfromProjTab)){
	response.sendRedirect("/proj/data/ProjTab.jsp?projectid="+projectid+"&"+querystr);
	return;
}
%>


<jsp:useBean id="RecordSetFF" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet_cus" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet3" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetR" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetM" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetLog" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetRight" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="RecordSetV" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetEX" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetC" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="workPlanSearch" class="weaver.WorkPlan.WorkPlanSearch" scope="session" />

<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />
<jsp:useBean id="ProjectStatusComInfo" class="weaver.proj.Maint.ProjectStatusComInfo" scope="page" />
<jsp:useBean id="ProjectTypeComInfo" class="weaver.proj.Maint.ProjectTypeComInfo" scope="page" />
<jsp:useBean id="WorkTypeComInfo" class="weaver.proj.Maint.WorkTypeComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />
<jsp:useBean id="LocationComInfo" class="weaver.hrm.location.LocationComInfo" scope="page" />
<jsp:useBean id="RelatedRequestCount" class="weaver.workflow.request.RelatedRequestCount" scope="page"/>
<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>
<jsp:useBean id="CoworkDAO" class="weaver.cowork.CoworkDAO" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DocSearchManage" class="weaver.docs.search.DocSearchManage" scope="page" />
<jsp:useBean id="DocSearchComInfo" class="weaver.docs.search.DocSearchComInfo" scope="page" />
<jsp:useBean id="CRMSearchComInfo" class="weaver.crm.search.SearchComInfo" scope="session" />
<jsp:useBean id="ContractComInfo" class="weaver.crm.Maint.ContractComInfo" scope="page"/>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="ProjTempletUtil" class="weaver.proj.Templet.ProjTempletUtil" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="WFUrgerManager" class="weaver.workflow.request.WFUrgerManager" scope="page" />
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page" />
<jsp:useBean id="DocImageManager" class="weaver.docs.docs.DocImageManager" scope="page" />
<jsp:useBean id="ProjectTransUtil" class="weaver.proj.util.ProjectTransUtil" scope="page" />
<jsp:useBean id="CptFieldComInfo" class="weaver.proj.util.PrjFieldComInfo" scope="page"/>
<jsp:useBean id="CptFieldManager" class="weaver.proj.util.PrjFieldManager" scope="page"/>
<jsp:useBean id="CodeUtil" class="weaver.proj.util.CodeUtil" scope="page"/>
<jsp:useBean id="KnowledgeTransMethod" class="weaver.general.KnowledgeTransMethod" scope="page"/>
<jsp:useBean id="CommonShareManager" class="weaver.cpt.util.CommonShareManager" scope="page" />
<%
String nameQuery=Util.null2String(request.getParameter("flowTitle"));

weaver.system.CusFormSettingComInfo CusFormSettingComInfo = new weaver.system.CusFormSettingComInfo();
weaver.system.CusFormSetting CusFormSetting= CusFormSettingComInfo.getCusFormSetting("prj","PrjCardView");
if(CusFormSetting!=null&&CusFormSetting.getStatus()==2){//自定义布局页面
	//request.getRequestDispatcher("/proj/data/ViewProject_l.jsp").forward(request, response);
	response.sendRedirect("/proj/data/ViewProject_l.jsp"+"?"+querystr);
}

%>
<%

DecimalFormat df=new DecimalFormat("##0.00");
String ProjID = Util.null2String(request.getParameter("ProjID"));
String message = Util.null2String(request.getParameter("message"))  ;
/*查看项目成员*/
String sql_mem=SQLUtil.filteSql(RecordSet.getDBType(),  "select members,contractids,accessory,dbo.getPrjFinish(id) as finish from Prj_ProjectInfo where id= "+ProjID );
RecordSet.executeSql(sql_mem);
RecordSet.next();
String finish=""+Util.getIntValue(RecordSet.getString("finish"),0);
String Members=Util.null2String(RecordSet.getString("members"));
String project_accessory = Util.null2String(RecordSet.getString("accessory"));//相关附件
String Memname=ProjectTransUtil.getResourceNamesWithLink(Members);
int projidss=1;//为区别项目报表和项目卡片的返回，项目卡片为1



/*合同－－项目收入*/
String contractids_prj="";
String sql_conids="select id from CRM_Contract where projid ="+ProjID;
RecordSet.executeSql(sql_conids);
while(RecordSet.next()){
    contractids_prj += ","+ Util.null2String(RecordSet.getString("id"));
}
if(!contractids_prj.equals("")) contractids_prj =contractids_prj.substring(1);






/*项目状态*/
String sql_tatus="select isactived from Prj_TaskProcess where prjid="+ProjID;
RecordSet.executeSql(sql_tatus);
RecordSet.next();
String isactived=Util.null2String(RecordSet.getString("isactived"));

// added by lupeng 2004-08-26.
RecordSet.executeSql("SELECT SUM(realManDays) FROM Prj_TaskProcess WHERE prjid = " + ProjID);
RecordSet.next();
float totalWorkTime = Util.getFloatValue(RecordSet.getString(1), 0);
// end.



//isactived=0,为计划
//isactived=1,为提交计划
//isactived=2,为批准计划

String sql_prjstatus="select status,manager from Prj_ProjectInfo where id = "+ProjID;
RecordSet.executeSql(sql_prjstatus);
RecordSet.next();
boolean isExecProject=false;
String status_prj=Util.null2String(RecordSet.getString("status"));
String manager_prj=Util.null2String(RecordSet.getString("manager"));
if(status_prj.equals("1")||status_prj.equals("2")||status_prj.equals("3")||status_prj.equals("4")||status_prj.equals("5")) {
	isactived="2";
	isExecProject=true;
}
//status_prj=5&&isactived=2,立项批准
//status_prj=1,正常
//status_prj=2,延期
//status_prj=3,完成
//status_prj=4,冻结

String ProcPara = "";
int userid = user.getUID();
String logintype = ""+user.getLogintype();
int usertype = 0;
if(logintype.equals("2"))
	usertype= 1;

char flag=Util.getSeparator() ;



boolean hasFF = true;
RecordSetFF.executeProc("Base_FreeField_Select","p1");
if(RecordSetFF.getCounts()<=0)
	hasFF = false;
else
	RecordSetFF.first();

RecordSet.executeProc("PRJ_Find_LastModifier",ProjID);
RecordSet.first();
String Modifier = Util.null2String(RecordSet.getString(1));
String ModifyDate = Util.null2String(RecordSet.getString(2));


RecordSet.executeProc("Prj_ProjectInfo_SelectByID",ProjID);
if(RecordSet.getCounts()<=0)
	response.sendRedirect("/proj/DBError.jsp?type=FindData_VP");
RecordSet.first();

String Creater = Util.null2String(RecordSet.getString("creater"));
String CreateDate = Util.null2String(RecordSet.getString("createdate"));
String projTypeId=Util.null2String(RecordSet.getString("prjtype"));
boolean isfromws="1".equals(Util.null2String(RecordSet.getString("isfromws")));//ws生成的项目

/*权限－begin*/
boolean canview=false;
boolean canedit=false;
boolean iscreater=false;
boolean ismanager=false;
boolean ismanagers=false;
boolean ismember=false;
boolean isrole=false;
boolean isshare=false;
String iscustomer="0";

//4E8 项目权限等级(默认共享的值设置:项目成员0.5,项目经理2.5,项目经理上级3,项目管理员4;手动共享值设置:查看1,编辑2)
double ptype=Util.getDoubleValue( CommonShareManager.getPrjPermissionType(""+ProjID, user),0 );
if(ptype==2.5||ptype==2){
	canview=true;
	canedit=true;
	ismanager=true;
}else if (ptype==3){
	canview=true;
	canedit=true;
	ismanagers=true;
}else if (ptype==4){
	canview=true;
	canedit=true;
	isrole=true;
}else if (ptype==0.5){
	canview=true;
	ismember=true;
}else if (ptype==1){
	canview=true;
	isshare=true;
}


int requestid = Util.getIntValue(request.getParameter("requestid"),0);
boolean onlyview=false;
if(!canview){
	if(OAuth.onlyView(user, "prj", request, new JSONObject())){
		onlyview=true;
	}else if(!WFUrgerManager.UrgerHavePrjViewRight(requestid,userid,Util.getIntValue(logintype),ProjID) && !WFUrgerManager.getMonitorViewObjRight(requestid,userid,""+ProjID,"2")
		&&!CoworkDAO.haveRightToViewPrj(Integer.toString(user.getUID()),ProjID)
		){
        response.sendRedirect("/notice/noright.jsp") ;
        return;
    }else{
        onlyview=true;
    }
}
/*权限－end*/

//写viewlog表
String needlog = Util.null2String(request.getParameter("log"));
if(!needlog.equals("n"))
{


String clientip=request.getRemoteAddr();
Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);
RecordSetLog.executeProc("Prj_ViewLog1_Insert",ProjID+""+flag+userid+""+flag+user.getLogintype()+""+flag+CurrentDate+flag+CurrentTime+flag+clientip);
}

//added by lupeng 2004-07-08
String[] params = new String[] {String.valueOf(userid), ProjID};
ArrayList results = new ArrayList();
int resultCount = workPlanSearch.getProjAssociatedCount(params);
//end



%>

<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript"  type='text/javascript' src="/js/weaver_wev8.js"></SCRIPT>
<SCRIPT language="javascript"  type='text/javascript' src="/js/ArrayList_wev8.js"></SCRIPT>
<SCRIPT language="javascript"  type='text/javascript' src="/js/projTask/ProjTaskUtil_wev8.js"></SCRIPT>
<SCRIPT language="javascript"  type='text/javascript'src="/js/projTask/TaskNodeXmlDoc_wev8.js"></SCRIPT>
<SCRIPT language="javascript"  type='text/javascript' src="/js/projTask/TaskDrag_wev8.js"></SCRIPT> 
<SCRIPT language="javascript" src="/proj/js/common_wev8.js"></script>
<LINK href="/js/ecology8/base/jquery.ui.all_wev8.css" type=text/css rel=STYLESHEET>
<LINK href="/js/ecology8/base/jquery.ui.progressbar_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/js/ecology8/base/jquery-ui_wev8.js"></script>
<style>
.progress-label {
     float: left;
     margin-left: 50%;
     margin-top: 5px;
     font-weight: bold;
     text-shadow: 1px 1px 0 #fff;
}
.ui-progressbar{ 
background : ; 
padding:1px; 
}	
.ui-progressbar-value{ 
background : #A5E994; 
} 
</style>
<script type="text/javascript">
function expDiscussion(prjid){
	window.open("/docs/docs/DocList.jsp?prjid="+prjid+"&isExpDiscussion=y","newwindow","height=600,width=800,toolbar=no,menubar=no,status=no,resizable=yes,scrollbars=yes");
}
</script> 
</HEAD>
<%
String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(610,user.getLanguage())+" - "+Util.null2String(RecordSet.getString("name"));
String newtitlename = titlename;
titlename += " <B>" + SystemEnv.getHtmlLabelName(401,user.getLanguage()) + ":</B>"+CreateDate ;
titlename += " <B>" + SystemEnv.getHtmlLabelName(623,user.getLanguage()) + ":</B>";
if(user.getLogintype().equals("1"))
	titlename += " <A href=/hrm/resource/HrmResource.jsp?id=" + Creater + ">" + Util.null2String(ResourceComInfo.getResourcename(Creater)) + "</a>";
titlename += " <B>" + SystemEnv.getHtmlLabelName(103,user.getLanguage()) + ":</B>"+ModifyDate ;
titlename += " <B>" + SystemEnv.getHtmlLabelName(623,user.getLanguage()) + ":</B>";
if(user.getLogintype().equals("1"))
	titlename += " <A href=/hrm/resource/HrmResource.jsp?id=" + Modifier + ">" + Util.null2String(ResourceComInfo.getResourcename(Modifier)) + "</a>";

String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%
	session.setAttribute("fav_pagename" , newtitlename ) ;	
%>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>

<%


 //modify by dongping  当其为项目的中的项目经理和项目某任务的负责人时都可以进

 //TD4078	项目成员可以进入项目卡片编辑页面编辑自己负责的任务
 //modified by hubo,2006-04-05
 //modified by mackjoe,2007-01-04 TD5672 只有项目经理才能编辑卡片和任务
 
String editPrjUrl="/proj/data/EditProject.jsp?ProjID="+ProjID+"&from=viewProject&isManager="+canedit;
 
if(!onlyview){
 if((canedit)&&!status_prj.equals("6")&&!status_prj.equals("3")&&!status_prj.equals("4")){ //项目状态为3：完成，4：冻结时;6:待审批，不能编辑
	RCMenu += "{"+SystemEnv.getHtmlLabelName(93,user.getLanguage())+","+editPrjUrl+",_self}";
	RCMenuHeight += RCMenuHeightStep;

	//RCMenu += "{"+SystemEnv.getHtmlLabelName(19771,user.getLanguage())+",/proj/data/EditProjectTask.jsp?ProjID="+ProjID+"&from=viewProject&isManager="+canedit+",_self}";
	//RCMenuHeight += RCMenuHeightStep;
	
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(20521,user.getLanguage())+", /weaver/weaver.file.ExcelOut, ExcelOut} " ;
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(20521,user.getLanguage())+", javascript:expTask(), ExcelOut} " ;
    //RCMenuHeight += RCMenuHeightStep;
};

//RCMenu += "{"+SystemEnv.getHtmlLabelName(1332,user.getLanguage())+",/proj/process/ViewProcess.jsp?log=n&ProjID="+ProjID+",_self}";
//RCMenuHeight += RCMenuHeightStep;
/**
if(0<Util.getIntValue(status_prj, -1)&&Util.getIntValue(status_prj, -1)<=5){//1,正常2,延期3,完成4,冻结5,立项批准 才有分析报告
	RCMenu += "{"+SystemEnv.getHtmlLabelName(1297,user.getLanguage())+",/proj/report/PlanAndProcess.jsp?ProjID="+ProjID+",_self}";
	RCMenuHeight += RCMenuHeightStep;
}**/


RCMenu += "{"+SystemEnv.getHtmlLabelName(16392,user.getLanguage())+",javascript:document.workflow.submit(),_top}" ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1986,user.getLanguage())+",javascript:document.doc.submit(),_top}" ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(18481,user.getLanguage())+",javascript:onNewWorkplan("+ProjID+"),_top}" ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(15008,user.getLanguage())+",javascript:onNewMeeting("+ProjID+"),_top}" ;
RCMenuHeight += RCMenuHeightStep ;
/**
if(!user.getLogintype().equals("2")){
RCMenu += "{"+SystemEnv.getHtmlLabelName(926,user.getLanguage())+",/meeting/search/SearchOperation.jsp?log=n&projectid="+ProjID+",_self}";
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(119,user.getLanguage())+",/proj/data/AddShare.jsp?prjid="+ProjID+",_self}";
RCMenuHeight += RCMenuHeightStep;
};**/


if(isactived.equals("2")  && ismanager){

RCMenu += "{"+SystemEnv.getHtmlLabelName(2228,user.getLanguage())+",javascript:onNormal("+ProjID+"),_self}";
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(2229,user.getLanguage())+",javascript:onOver("+ProjID+"),_self}";
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(2230,user.getLanguage())+",javascript:onFinish("+ProjID+"),_self}";
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(2231,user.getLanguage())+",javascript:onFrozen("+ProjID+"),_self}";
RCMenuHeight += RCMenuHeightStep;
};

/* added by hubo 2005-08-29*/
if(ismanager){
RCMenu += "{"+SystemEnv.getHtmlLabelName(350,user.getLanguage())+SystemEnv.getHtmlLabelName(64,user.getLanguage())+",javascript:saveAsTemplet(),_self}";
RCMenuHeight += RCMenuHeightStep;

//RCMenu += "{"+SystemEnv.getHtmlLabelName(17416,user.getLanguage())+SystemEnv.getHtmlLabelName(15153,user.getLanguage())+",javascript:expDiscussion("+ProjID+"),_self}";
//RCMenuHeight += RCMenuHeightStep;
}
//RCMenu += "{"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+",/proj/data/ViewLog.jsp?log=n&ProjID="+ProjID+",_self}";
RCMenu += "{"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+",javascript:onLog("+ProjID+"),_self}";
RCMenuHeight += RCMenuHeightStep;
}
//只有项目经理才能删除草稿和审批退回的项目
if(manager_prj.equals(""+user.getUID())&&("0".equals(""+status_prj )||"7".equals(""+status_prj ))){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:onDel("+ProjID+");,_self} " ;
	RCMenuHeight += RCMenuHeightStep;
}
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

	<%
	String topage= URLEncoder.encode("/proj/data/ViewProject.jsp?ProjID="+ProjID);
	%>
	<form name=workflow method=get action="/workflow/request/RequestType.jsp" target="_blank">
		<input type=hidden name=topage value='<%=topage%>'>
		<input type=hidden name=prjid value='<%=ProjID%>'>
	</form>
	<form name=doc method=post action="/docs/docs/DocList.jsp" target="_blank">
		<input type=hidden name=topage value='<%=topage%>'>
		<input type=hidden name=prjid value='<%=ProjID%>'>
	</form>

<!--added by hubo, 2005/09/01-->
<form name="formProjInfo" id="formProjInfo" method="post" style="display:">
	<!--ProjectBaseInfo-->
	<input type="hidden" name="templetName">
	<input type="hidden" name="txtPrjType" value="<%=RecordSet.getString("prjtype")%>">
	<input type="hidden" name="workType" value="<%=RecordSet.getString("worktype")%>">
	<input type="hidden" name="members" value="<%=RecordSet.getString("members")%>">
	<input type="hidden" name="isMemberSee" value="<%=RecordSet.getString("isblock")%>">
	<input type="hidden" name="crms" value="<%=RecordSet.getString("description")%>">
	<input type="hidden" name="isCrmSee" value="<%=RecordSet.getString("managerview")%>">
	<input type="hidden" name="parentProId" value="<%=RecordSet.getString("parentid")%>">
	<input type="hidden" name="commentDoc" value="<%=RecordSet.getString("envaluedoc")%>">
	<input type="hidden" name="confirmDoc" value="<%=RecordSet.getString("confirmdoc")%>">
	<input type="hidden" name="adviceDoc" value="<%=RecordSet.getString("proposedoc")%>">
	<input type="hidden" name="manager" value="<%=RecordSet.getString("manager")%>">


<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
		<%
		if(canedit){
			%>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%> " class="e8_btn_top" onclick="onEdit(<%=projectid %>)"/>
			<%
		}
		if(manager_prj.equals(""+user.getUID())&&("0".equals(""+status_prj )||"7".equals(""+status_prj ))){
			%>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%> " class="e8_btn_top" onclick="onDel(<%=projectid %>)"/>
			<%
		}
		%>
			<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<wea:layout>
	<!-- baseinfo -->
	<wea:group context='<%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>'>
		<wea:item><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></wea:item>
		<wea:item><%=RecordSet.getString("name")%></wea:item>
<%
if(!"0".equals( CodeUtil.getPrjCodeUse())){
	%>
		<wea:item><%=SystemEnv.getHtmlLabelName(17852,user.getLanguage())%></wea:item>
		<wea:item><%=RecordSet.getString("proCode")%></wea:item>
	<%
}
%>		
		<wea:item><%=SystemEnv.getHtmlLabelName(586,user.getLanguage())%></wea:item>
		<wea:item><%=Util.toScreen(ProjectTypeComInfo.getProjectTypename(RecordSet.getString("prjtype")),user.getLanguage())%></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(18375,user.getLanguage())%></wea:item>
		<wea:item>
			<%
                String templetId = RecordSet.getString("proTemplateId");
                if (!"".equals(templetId)) {
                    rs.executeSql("select templetName from Prj_Template where id="+templetId);
                    if (rs.next()){
                        out.println(rs.getString(1));
                    }
                }            
            %>
		</wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(432,user.getLanguage())%></wea:item>
		<wea:item><%=Util.toScreen(WorkTypeComInfo.getWorkTypename(RecordSet.getString("worktype")),user.getLanguage())%></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(783,user.getLanguage())%></wea:item>
		<wea:item>
			<%if(!RecordSet.getString("description").equals("")){
				ArrayList arraycrmids = Util.TokenizerString(RecordSet.getString("description"),",");
				for(int i=0;i<arraycrmids.size();i++){
			%>
						<A href='/CRM/data/ViewCustomer.jsp?CustomerID=<%=""+arraycrmids.get(i)%>'><%=CustomerInfoComInfo.getCustomerInfoname(""+arraycrmids.get(i))%></a>&nbsp
			<%}}%>
		</wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(15263,user.getLanguage())%></wea:item>
		<wea:item><INPUT type=checkbox  value=1 <%if(RecordSet.getString("ManagerView").equals("1")){%> checked <%}%> disabled ></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(6161,user.getLanguage())%></wea:item>
		<wea:item>
			<%

        String connames="";
        if(!contractids_prj.equals("")){

            ArrayList conids_muti = Util.TokenizerString(contractids_prj,",");
            int connum = conids_muti.size();

            for(int i=0;i<connum;i++){
                connames= connames+"<a href=/CRM/data/ContractView.jsp?id="+conids_muti.get(i)+">"+Util.toScreen(ContractComInfo.getContractname(""+conids_muti.get(i)),user.getLanguage())+"</a>" +" ";
            }
        }
          %>
          <%=connames%>
		</wea:item>
	</wea:group>
	
	<!-- manageinfo -->
	<wea:group context='<%=SystemEnv.getHtmlLabelName(27858,user.getLanguage())%>'>
		<wea:item><%=SystemEnv.getHtmlLabelName(636,user.getLanguage())%></wea:item>
		<wea:item><A href="javascript:void(0)" onclick="window.parent.location.href='/proj/data/ViewProject.jsp?ProjID=<%=RecordSet.getString("parentid")%>' "><%=ProjectInfoComInfo.getProjectInfoname(RecordSet.getString("parentid"))%></a></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(144,user.getLanguage())%></wea:item>
		<wea:item><%if(user.getLogintype().equals("1")){%><a href="/hrm/resource/HrmResource.jsp?id=<%=RecordSet.getString("manager")%>"><%}%><%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("manager")),user.getLanguage())%><%if(user.getLogintype().equals("1")){%></a><%}%></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(101,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(431,user.getLanguage())%></wea:item>
		<wea:item><%=Memname %></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(624,user.getLanguage())%></wea:item>
		<wea:item><INPUT type=checkbox  value=1 <%if(RecordSet.getString("isblock").equals("1")){%> checked <%}%> disabled ></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(587,user.getLanguage())%></wea:item>
		<wea:item>
			<span id="prjstatus_span"><%=ProjectStatusComInfo.getProjectStatusdesc(status_prj) %></span>
		</wea:item>
<%
if(isExecProject){
	%>
		<wea:item><%=SystemEnv.getHtmlLabelName(847,user.getLanguage())%></wea:item>
		<wea:item>
			<div style="width:30%!important;"><%=KnowledgeTransMethod.getPercent(finish,  ProjectTransUtil.getPrjTaskProgressbar(finish, "") ) %></div>
		</wea:item>
	<%
}
%>		
		<wea:item><%=SystemEnv.getHtmlLabelName(637,user.getLanguage())%></wea:item>
		<wea:item><a href="/docs/docs/DocDsp.jsp?id=<%=RecordSet.getString("envaluedoc")%>"><%=Util.toScreen(DocComInfo.getDocname(RecordSet.getString("envaluedoc")),user.getLanguage())%></a></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(638,user.getLanguage())%></wea:item>
		<wea:item><a href="/docs/docs/DocDsp.jsp?id=<%=RecordSet.getString("confirmdoc")%>"><%=Util.toScreen(DocComInfo.getDocname(RecordSet.getString("confirmdoc")),user.getLanguage())%></a></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(639,user.getLanguage())%></wea:item>
		<wea:item><a href="/docs/docs/DocDsp.jsp?id=<%=RecordSet.getString("proposedoc")%>"><%=Util.toScreen(DocComInfo.getDocname(RecordSet.getString("proposedoc")),user.getLanguage())%></a></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(22194,user.getLanguage())%></wea:item>
		<wea:item>
			<%
		      String[] fjmultiID = Util.TokenizerString2(project_accessory,",");
	          String fjnamestr = "";
			  int linknum=-1;
			  for(int j=0;j<fjmultiID.length;j++){			  									
				String sql = "select id,docsubject,accessorycount from docdetail where id ="+fjmultiID[j]+" order by id asc";
				rs.executeSql(sql);
				linknum++;
				if(rs.next()){
				  String showid = Util.null2String(rs.getString(1)) ;
				  String tempshowname= Util.toScreen(rs.getString(2),user.getLanguage()) ;
				  int accessoryCount=rs.getInt(3);
				  DocImageManager.resetParameter();
				  DocImageManager.setDocid(Integer.parseInt(showid));
				  DocImageManager.selectDocImageInfo();
				  String docImagefilename = "";
				  if(DocImageManager.next()){
					//DocImageManager会得到doc第一个附件的最新版本
					docImagefilename = DocImageManager.getImagefilename();
				  }
				  fjnamestr += "<a href='/docs/docs/DocDsp.jsp?id="+fjmultiID[j]+"' target='_blank'>"+docImagefilename+"</a>&nbsp;";
			    }			
			  }
	        %>
		
			<%=Util.toScreen(fjnamestr,user.getLanguage())%>
		</wea:item>
	</wea:group>
	
	
	<!-- otherinfo -->
	<wea:group context='<%=SystemEnv.getHtmlLabelName(410,user.getLanguage())%>'>

<%
//cusfield

TreeMap<String,JSONObject> openfieldMap= CptFieldComInfo.getOpenFieldMap();
if(!openfieldMap.isEmpty()){
	Iterator it=openfieldMap.entrySet().iterator();
	while(it.hasNext()){
		Entry<String,JSONObject> entry=(Entry<String,JSONObject>)it.next();
		String k= entry.getKey();
		JSONObject v= entry.getValue();
	
	%>
	<wea:item><%=SystemEnv.getHtmlLabelName(v.getInt("fieldlabel"),user.getLanguage())%></wea:item>
	<wea:item><%=CptFieldManager.getFieldvalue(user, v.getInt("id"), v.getInt("fieldhtmltype"), v.getInt("type"), Util.null2String( RecordSet.getString(v.getString("fieldname"))) , 0) %></wea:item>
	
	<%
	}
}

%>


<%
//ws自定义字段
if(isfromws){
	String ws_other=Util.null2String(RecordSet.getString("ws_other"));
	if(!"".equals(ws_other)){
		Document doc= DocumentHelper.parseText(ws_other);
		List<Element> otherElements= doc.selectNodes("xmlinfo/*");
		for(Element element : otherElements){
			String label=Util.null2String( element.attribute("label").getText());
			if("".equals(label)) label=Util.null2String( element.getName());
			String value=element.getText();
			%>
		<wea:item><%=label %></wea:item>	
		<wea:item><%=value %></wea:item>	
			<%
		}
	}
}

%>



<%
//项目类型自定义字段 

CustomFieldManager cfm = new CustomFieldManager("ProjCustomField",Util.getIntValue(RecordSet.getString("prjtype")));
cfm.getCustomFields4prj();                                            
cfm.getCustomData4prj("ProjCustomFieldReal",Util.getIntValue(RecordSet.getString("prjtype")),Util.getIntValue(ProjID));
while(cfm.next()){
    String fieldvalue = "";
    if(cfm.getHtmlType().equals("2")){
    	//fieldvalue = Util.null2String(cfm.getData("field"+cfm.getId()));
    	fieldvalue = Util.null2String(cfm.getData(cfm.getFieldName(""+ cfm.getId())));
    }else{
    	//fieldvalue = Util.toHtml(cfm.getData("field"+cfm.getId()));
    	fieldvalue = Util.toHtml(cfm.getData(cfm.getFieldName(""+ cfm.getId())));
    }
%>
<wea:item><%=cfm.getLable()%></wea:item>
<wea:item>
   
    <%
      if(cfm.getHtmlType().equals("1")||cfm.getHtmlType().equals("2")){
    %>
    <%=fieldvalue%>
    <%
	   	}else if(cfm.getHtmlType().equals("3")){
	
	        String fieldtype = String.valueOf(cfm.getType());
	        String url=BrowserComInfo.getBrowserurl(fieldtype);     // 浏览按钮弹出页面的url
	        String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // 浏览值点击的时候链接的url
	        String showname = "";                                   // 新建时候默认值显示的名称
	        String showid = "";                                     // 新建时候默认值
	
	
	        if(fieldtype.equals("2") ||fieldtype.equals("19")){
	            showname=fieldvalue; // 日期时间
	        }else if(!fieldvalue.equals("")) {
	            String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //浏览框对应的表,比如人力资源表
	            String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //浏览框对应的表名称字段
	            String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //浏览框对应的表值字段
	            String sql = "";
	
	            HashMap temRes = new HashMap();
	
	            if(fieldvalue.startsWith(",")){
					fieldvalue = fieldvalue.substring(1);
}
              	if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")||fieldtype.equals("65")||fieldtype.equals("152") ||  fieldtype.equals("135")||  fieldtype.equals("168")||  fieldtype.equals("170")) {    // 多人力资源,多客户,多会议，多文档
                      sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                  }
                  else {
                      sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                  }

                  RecordSet2.executeSql(sql);
                  while(RecordSet2.next()){
                      showid = Util.null2String(RecordSet2.getString(1)) ;
                      String tempshowname= Util.null2String(RecordSet2.getString(2)) ;
                      if(!linkurl.equals(""))
                          //showname += "<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " ;
                          temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"' target='_fullwindow'>"+tempshowname+"</a> ");
                      else{
                          //showname += tempshowname ;
                          temRes.put(String.valueOf(showid),tempshowname);
                      }
                  }
                  StringTokenizer temstk = new StringTokenizer(fieldvalue,",");
                  String temstkvalue = "";
                  while(temstk.hasMoreTokens()){
                      temstkvalue = temstk.nextToken();

                      if(temstkvalue.length()>0&&temRes.get(temstkvalue)!=null){
                          showname += temRes.get(temstkvalue);
                      }
                  }
                  if(fieldtype.equals("16")||fieldtype.equals("152")){
                  	showname = Util.StringReplace(showname,"isrequest=1&","");
                  } 
                  
                  if(fieldtype.equals("129")){
                  	url=url+"?projTypeID="+projTypeId;
                  	if(fieldvalue.equals("0")) 
                  		showname="<a href='"+linkurl+showid+"' target='_fullwindow'>"+SystemEnv.getHtmlLabelName(17907,user.getLanguage())+"</a> "; //空模板
                  }

              }


                                %>
      <span id="customfield<%=cfm.getId()%>span"><%=Util.toScreen(showname,user.getLanguage())%></span>
     <%
      }else if(cfm.getHtmlType().equals("4")){
     %>
      <input type=checkbox value=1 name="customfield<%=cfm.getId()%>" <%=fieldvalue.equals("1")?"checked":""%> disabled >
     <%
      }else if(cfm.getHtmlType().equals("5")){
          cfm.getSelectItem(cfm.getId());
     %>
     <%
          while(cfm.nextSelect()){
              if(cfm.getSelectValue().equals(fieldvalue)){
     %>
          <%=cfm.getSelectName()%>
     <%
                  break;
              }
          }
     %>
     <%
      }
     %>
</wea:item>
<%
}
%>




		
	</wea:group>
	
	
	
</wea:layout>

<%
// added by lupeng 2004-07-16 to set viewed log.
ProcPara = ProjID + flag + String.valueOf(userid) + flag + user.getLogintype();
rs.executeProc("Prj_ViewedLog_Insert", ProcPara);
// end
%>
<SCRIPT language="javascript" src="/js/xmlextras_wev8.js"></script>
<script type='text/javascript' src='/dwr/interface/ProjTaskUtil.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/js/ArrayList_wev8.js'></script>
<script language="javascript">


jQuery(document).ready(function(){
	jQuery("#topTitle").topMenuTitle();
	jQuery("#hoverBtnSpan").hoverBtn();
});

function submitData(){
	if (check_form(Exchange,'ExchangeInfo'))  {    
        //alert(Exchange.tagName)
        document.getElementById("Exchange").submit();
    }	
}


  function doSave1(){
	if(check_form(document.Exchange,"ExchangeInfo")){
		document.Exchange.submit();
	}
}

function displaydiv_1()
	{
		if(WorkFlowDiv.style.display == ""){
			WorkFlowDiv.style.display = "none";
			WorkFlowspan.innerHTML = "<a href='#' onClick=displaydiv_1()><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></a>";
		}
		else{
			WorkFlowspan.innerHTML = "<a href='#' onClick=displaydiv_1()><%=SystemEnv.getHtmlLabelName(15154,user.getLanguage())%></a>";
			WorkFlowDiv.style.display = "";
		}
	}


//项目另存模板
//added by hubo, 2005/09/01
function saveAsTemplet(){
	var strTempletName = prompt("<%=SystemEnv.getHtmlLabelNames("18510",user.getLanguage())%>","<%=RecordSet.getString("name")%>模板");
	if(strTempletName==null || trim(strTempletName)==""){
		return false;
	}else{
		//alert(templetName);
		with(document.getElementById("formProjInfo")){
			templetName.value = strTempletName;
			action = "SaveAsTemplet.jsp?projId=<%=ProjID%>";
			submit();
		}
	}
}

function onHiddenImgClick(divObj,imgObj){
     if (imgObj.objStatus=="show"){
        divObj.style.display='none' ;       
        imgObj.src="/images/down_wev8.jpg";
        imgObj.title="点击展开";
        imgObj.objStatus="hidden";        
     } else {        
        divObj.style.display='' ;    
        imgObj.src="/images/up_wev8.jpg";
        imgObj.title="点击隐藏";
        imgObj.objStatus="show";       
     }
 }

function onImgClick(objImg,taskid,level){ 	
		var parentTrObj=objImg.parentNode.parentNode.parentNode.parentNode.parentNode;
		
		if($(objImg).attr("status")=="hidden"){//展开
				objImg.src="/images/loading2_wev8.gif";
				ProjTaskUtil.getTaskTRs("<%=user.getLanguage()%>","<%=ProjID%>",taskid,level,
					{callback:function(dataFromServer) {			
						doOtherThing(dataFromServer, objImg,parentTrObj);
					}
					}
				);
			
		} else if($(objImg).attr("status")=="show") {//收缩		    
			var childrenList=new ArrayList();
			getAllChildrenIds(parentTrObj,childrenList)				
			for(var i=0;i<childrenList.size();i++) {
				var tempTr=document.getElementById("TR"+childrenList.get(i));
				$(tempTr).next().remove();
				$(tempTr).remove();				
			}
			objImg.src="/images/project_rank2_wev8.gif";
			$(objImg).attr("status","hidden");
			$(parentTrObj).attr("childStrs","");
		}
 }

function getAllChildrenIds(trObj,childrenList){	
	var childStrs=$(trObj).attr("childStrs");	
	//1.求TROBJ上的子节点属性 和子孙节点的记录
	if(childStrs){  //只记录一级子ID
		var childArrays=childStrs.split(",");		
		for(var i=0;i<childArrays.length;i++) {
			
			//alert("TR"+childArrays[i])			
			var tempTrObj=document.getElementById("TR"+childArrays[i]);
			//alert(tempTrObj.tagName)
			childrenList.add(childArrays[i]);

			getAllChildrenIds(tempTrObj,childrenList);
		}		
	} else{			
		return childrenList;
	}
}

function doOtherThing(viewTaskTrArray,objImg,parentTrObj){	
	var oldTrObj=parentTrObj.nextSibling;	
	for(var i=0;i<viewTaskTrArray.length;i++){			  
          var tempStrs=viewTaskTrArray[i].split("\u0002");
		  var rowTR=document.createElement("TR");
		  rowTR.id="TR"+tempStrs[0];
		  rowTR.className=replaceStr(tempStrs[1]);	
		  rowTR.childStrs=""
		  
		  var tempTD1=document.createElement("TD");
		  tempTD1.innerHTML=replaceStr(tempStrs[2]);
		  var tempTD2=document.createElement("TD");
		  tempTD2.innerHTML=replaceStr(tempStrs[3]);
		  var tempTD3=document.createElement("TD");
		  tempTD3.innerHTML=replaceStr(tempStrs[4]);
		  var tempTD4=document.createElement("TD");
		  tempTD4.innerHTML=replaceStr(tempStrs[5]);		  
		  var tempTD5=document.createElement("TD");
		  tempTD5.innerHTML=replaceStr(tempStrs[6]);
		  var tempTD6=document.createElement("TD");
		  tempTD6.innerHTML=replaceStr(tempStrs[7]);	 
		  var tempTD7=document.createElement("TD");
		  tempTD7.innerHTML=replaceStr(tempStrs[8]);
		  
		  rowTR.appendChild(tempTD1);
		  rowTR.appendChild(tempTD2);
		  rowTR.appendChild(tempTD3);
		  rowTR.appendChild(tempTD4);
		  rowTR.appendChild(tempTD5);
		  rowTR.appendChild(tempTD6);
		  rowTR.appendChild(tempTD7);
		  
		  var lineTR=document.createElement("TR");
		  lineTR.className="line";
		  var lineTD=document.createElement("TD");
		  lineTD.colSpan=7;
		  $(lineTD).css("padding","0");
		  $(lineTR).css("height","1px");
		  $(lineTR).css("display","none");
		  lineTR.appendChild(lineTD);		 
		 
		  oldTrObj=$(oldTrObj).after(rowTR);
		  oldTrObj=$(rowTR).after(lineTR);

		  objImg.src="/images/project_rank1_wev8.gif";
		  objImg.status="show";

		  //TR 记录子的记录
		  $(parentTrObj).attr("childStrs",$(parentTrObj).attr("childStrs")+","+tempStrs[0]);
    }
	if($(parentTrObj).attr("childStrs")!=""){
		 $(parentTrObj).attr("childStrs",$(parentTrObj).attr("childStrs").substr(1));
	}
}

function replaceStr(str){
	if(str=="[none]") return "";
	else return str;
}
</script>
<iframe id="ExcelOut" name="ExcelOut" border=0 frameborder=no noresize=NORESIZE height="0%" width="0%"></iframe>


<script type="text/javascript">
function onDel(id){
	if(id){
		window.top.Dialog.confirm('<%=SystemEnv.getHtmlLabelNames("83600",user.getLanguage())%>',function(){
			jQuery.post(
				"/system/systemmonitor/MonitorOperation.jsp",
				{"from":"mymanagerproject","operation":"deleteproj","deleteprojid":id},
				function(data){
					window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelNames("83472",user.getLanguage())%>",function(){
						try{
							//parent.window.close();
							parent.opener.location.reload();
							parent.window.opener= null;
							parent.window.open("","_self"); 
							parent.window.close();
						}catch(e){}
						try{
							parent.window.location.href="/proj/data/ProjectBlankTab.jsp?isclose=1";
						}catch(e){}
					});
				}
			);
			
		});
	}
}
function onEdit(id){
	if(id){
		window.location.href="<%=editPrjUrl %>";
	}
}
function onLog(id){
	if(id){
		var url="/proj/data/ViewLog.jsp?ProjID="+id+"&isdialog=1";
		var title="<%=SystemEnv.getHtmlLabelNames("33782",user.getLanguage())%>";
		openDialog(url,title,1000,720,true);
	}
}
function onNewWorkplan(id){
	if(id){
		var url="/workplan/data/WorkPlanAdd.jsp?projectid="+id+"&isdialog=1";
		var title="<%=SystemEnv.getHtmlLabelNames("18481",user.getLanguage())%>";
		openDialog(url,title,1000,720);
	}
}
function onNewMeeting(id){
	if(id){
		var url="/meeting/data/NewMeetingTab.jsp?projectid="+id+"&isdialog=1";
		var title="<%=SystemEnv.getHtmlLabelNames("15008",user.getLanguage())%>";
		openDialog(url,title,1000,720,false,true);
	}
}
function onNormal(id){
	if(id){
		var url="/proj/plan/PlanOperation.jsp";
		var label='<%=ProjectStatusComInfo.getProjectStatusdesc("1") %>';
		jQuery.post(
			url,
			{"method":"normal","ProjID":id},
			function(data){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelNames("16746",user.getLanguage())%>",function(){
					$("#prjstatus_span").html(label);
				});
			}
		);
	}
}
function onOver(id){
	if(id){
		var url="/proj/plan/PlanOperation.jsp";
		var label='<%=ProjectStatusComInfo.getProjectStatusdesc("2") %>';
		jQuery.post(
			url,
			{"method":"delay","ProjID":id},
			function(data){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelNames("16746",user.getLanguage())%>",function(){
					$("#prjstatus_span").html(label);
				});
			}
		);
	}
}
function onFinish(id){
	if(id){
		var url="/proj/plan/PlanOperation.jsp";
		var label='<%=ProjectStatusComInfo.getProjectStatusdesc("3") %>';
		jQuery.post(
			url,
			{"method":"complete","ProjID":id},
			function(data){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelNames("16746",user.getLanguage())%>",function(){
					$("#prjstatus_span").html(label);
				});
			}
		);
	}
}
function onFrozen(id){
	if(id){
		var url="/proj/plan/PlanOperation.jsp";
		var label='<%=ProjectStatusComInfo.getProjectStatusdesc("4") %>';
		jQuery.post(
			url,
			{"method":"freeze","ProjID":id},
			function(data){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelNames("16746",user.getLanguage())%>",function(){
					$("#prjstatus_span").html(label);
				});
			}
		);
	}
}


$(function(){
	//initProgressbar();
});

function initProgressbar(){
	$(".progressbar").each(function(i){
		var rate=parseInt($(this).attr("rate"));
		var status=parseInt($(this).attr("status"));
		$(this).find("div.progress-label").text(rate+"%");
		$(this).progressbar({value:rate});
		if(status===1){//overtime task
			$(this).find( ".ui-progressbar-value" ).css({'background':'#F9A9AA'});
		}
		
	});
}
$(function(){
	var objname='<%=ProjectInfoComInfo.getProjectInfoname(""+projectid ) %>';
	parent.setTabObjName(objname);
});
</script>

</body>
</html>
<script language=javascript>
function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
function showdata(){
    var ajax=ajaxinit();
    ajax.open("POST", "ViewProjectData.jsp?ProjID=<%=ProjID%>", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send(null);
    //获取执行状态
    ajax.onreadystatechange = function() {
        //如果执行状态成功，那么就把返回信息写到指定的层里
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
                document.getElementById('TaskListDIV').innerHTML = ajax.responseText;
            }catch(e){
                return false;
            }
        }
    }
}
//showdata();

//tagtag导出任务
function expTask(){
	jQuery.ajax({
		url : "ViewProjectData.jsp?ProjID=<%=ProjID%>&isExpTask=1",
		type : "post",
		async : true,
		processData : false,
		data : "",
		dataType : "html",
		success: function do4Success(msg){
			document.getElementById("ExcelOut").src="/weaver/weaver.file.ExcelOut";
		}
	});	
	
}




</script>
