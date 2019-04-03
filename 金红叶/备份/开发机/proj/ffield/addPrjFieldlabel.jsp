<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CptCardGroupComInfo" class="weaver.proj.util.PrjCardGroupComInfo" scope="page"/>
<%
	if(!HrmUserVarify.checkUserRight("ProjectFreeFeild:Edit", user)){
		response.sendRedirect("/notice/noright.jsp");	
		return;
	}
%>
<%
    String ajax=Util.null2String(request.getParameter("ajax"));
%>
<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<SCRIPT language="javascript" src="/js/checkinput_wev8.js"></script>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<SCRIPT language="javascript" src="/proj/js/common_wev8.js"></script>

</HEAD>
<%
	int formid=0;
    int subCompanyId= -1;
	formid=Util.getIntValue(Util.null2String(request.getParameter("formid")),0);
	int prjtype=Util.getIntValue(Util.null2String(request.getParameter("paraid")),-1);
	String qname = Util.null2String(request.getParameter("flowTitle"));
	String fieldname_kwd = Util.null2String(request.getParameter("fieldname_kwd"));
	String fieldlabel_kwd = Util.null2String(request.getParameter("fieldlabel_kwd"));

String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename = "";
String needfav ="";
if(!ajax.equals("1"))
{
needfav ="1";
}
String needhelp ="";

    int detachable=Util.getIntValue(String.valueOf(session.getAttribute("detachable")),0);
    int operatelevel=2;
%>




<body>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:fieldlablesall0(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
%>

<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<form name="fieldlabelfrm" id=fieldlabelfrm method=post action="/cpt/ffield/addcptFieldlabel.jsp">
<input type="hidden" name="prjtype" value="<%=prjtype %>" />
<input type="hidden" name="from" value="<%=prjtype>0?"prjtypefield_def":"" %>" />
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<input type=button class="e8_btn_top" onclick="fieldlablesall0();" value="<%=SystemEnv.getHtmlLabelName(86, user.getLanguage())%>"></input>
						<span id="advancedSearch" class="advancedSearch" style="display:none;"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<div class="advancedSearchDiv" style="display:none;" id="advancedSearchDiv"  >
<wea:layout type="4col">
	<wea:group context='<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage())%>'>
		<wea:item><%=SystemEnv.getHtmlLabelName(685,user.getLanguage())%></wea:item>
		<wea:item><input type="text" id="fieldname_kwd" name="fieldname_kwd" class="InputStyle" value='<%=fieldname_kwd%>'></wea:item>
		<wea:item><%=SystemEnv.getHtmlLabelName(15456,user.getLanguage()) %></wea:item>
		<wea:item><input type="text" id="fieldlabel_kwd" name="fieldlabel_kwd" class="InputStyle" value='<%=fieldlabel_kwd%>'></wea:item>
	</wea:group>
	<wea:group context="">
    	<wea:item type="toolbar">
    		<input class="zd_btn_submit" type="button" name="search" value="<%=SystemEnv.getHtmlLabelNames("197",user.getLanguage())%>" onclick="onBtnSearchClick();"/>
    		<input class="zd_btn_cancle" type="reset" name="reset" value="<%=SystemEnv.getHtmlLabelNames("2022",user.getLanguage())%>"/>
    		<input class="zd_btn_cancle" type="button" name="cancel" id="cancel" value="<%=SystemEnv.getHtmlLabelNames("201",user.getLanguage())%>"  />
    	</wea:item>
    </wea:group>
</wea:layout>	
</div>

<input type="hidden" value="editfieldlabel" name="src">
<input type="hidden" value="<%=formid%>" name="formid">
<input type=hidden name="ajax" value="<%=ajax%>">
<input type="hidden" value="" name="changefieldids">
<input type="hidden" value="" name="checkitems">


<wea:layout type="4col" attributes="{'expandAllGroup':'true'}">


<wea:group context="" attributes="{'groupDisplay':'none'}">
<wea:item attributes="{'isTableList':'true'}">
<TABLE CLASS="ListStyle" valign="top" cellspacing=1 style="position:fixed;z-index:99!important;">
      <colgroup>                           
      <col width="25%">
      <col width="25%">
      <col width="25%">
      <col width="25%">
     <TR class="header">                                
		<TD><%=SystemEnv.getHtmlLabelName(685,user.getLanguage())%></TD>
        <TD><%=SystemEnv.getHtmlLabelName(15456,user.getLanguage())%>(<%=SystemEnv.getHtmlLabelName(1997,user.getLanguage())%>)</TD>
        <TD><%=SystemEnv.getHtmlLabelName(15456,user.getLanguage())%>(English)</TD>     
        <TD><%=SystemEnv.getHtmlLabelName(15456,user.getLanguage())%>(<%=SystemEnv.getHtmlLabelName(33598,user.getLanguage())%>)</TD>
    </TR>
</TABLE>
</wea:item>
</wea:group>

<%    
//遍历分组
CptCardGroupComInfo.setTofirstRow();
while(CptCardGroupComInfo.next()){
	
	ArrayList fieldids = new ArrayList();
    ArrayList fieldnames = new ArrayList();
    ArrayList fieldlables = new ArrayList();
    ArrayList fieldlablenames = new ArrayList();
    ArrayList fieldlablenamesE = new ArrayList();
    ArrayList fieldlablenamesT = new ArrayList();
    ArrayList viewtypes = new ArrayList();
    ArrayList groupids = new ArrayList();
    ArrayList issystems = new ArrayList();
    ArrayList fieldtypes = new ArrayList();
    
    String sql =""; 
    if(prjtype>0){//项目类型(包括项目通用自定义字段,和项目类型自己的自定义字段)
		sql =" select * from ( ";
		sql+=" select '1' as fieldtype,t1.id,t1.isopen,t1.ismand,t1.isused,t1.groupid,t1.issystem,t1.allowhide,t1.fieldname,t1.fieldlabel,t1.fielddbtype,t1.fieldhtmltype,t1.type,t1.dsporder,t1.textheight,t1.imgwidth,t1.imgheight,t1.childfieldid from prjDefineField t1 where t1.prjtype="+prjtype+" and t1.viewtype=0 and t1.groupid="+CptCardGroupComInfo.getGroupid(); 
		sql+=" union ";
		sql+=" select '2' as fieldtype,t2.id,t1.isuse as isopen,t1.ismand,t1.prj_isopen as isused,t1.groupid,null as issystem,null as allowhide,t2.fieldname,t1.prj_fieldlabel as fieldlabel,t2.fielddbtype,t2.fieldhtmltype,t2.type,t1.fieldorder as dsporder,null as textheight,null as imgwidth,null as imgheight,null as childfieldid  ";
		sql+=" from cus_formfield t1, cus_formdict t2 where t1.scope='ProjCustomField'  and t1.fieldid=t2.id ";
		sql+=" and t1.scopeid='"+prjtype+"' and t1.groupid="+CptCardGroupComInfo.getGroupid();
		sql+=" ) tt ";
	}else{//通用项目自定义字段
		sql= "select '1' as fieldtype,t1.id,t1.isopen,t1.ismand,t1.isused,t1.groupid,t1.issystem,t1.allowhide,t1.fieldname,t1.fieldlabel,t1.fielddbtype,t1.fieldhtmltype,t1.type,t1.dsporder,t1.textheight,t1.imgwidth,t1.imgheight,t1.childfieldid from prjDefineField t1 where t1.prjtype=-1 and t1.viewtype=0  and t1.groupid="+CptCardGroupComInfo.getGroupid() ;
	}
  			if(qname.length()>0){
  				sql +=" and (fieldname like '%"+qname+"%' or fieldlabel like '%"+qname+"%' )";
  			} 
  			
  			if(fieldname_kwd.length()>0){
  				sql +=" and fieldname like '%"+fieldname_kwd+"%' ";
  			} 
  			
  			if(fieldlabel_kwd.length()>0){
  				sql +=" and exists (select * from HtmlLabelInfo where fieldlabel = indexid and labelname like '%"+fieldlabel_kwd+"%' )";
  			} 
  			sql += " order by dsporder,id";
  			
  			//System.out.println("sql:\n"+sql);
  			
    RecordSet.executeSql(sql);
  	while(RecordSet.next()){//取得表单的所有字段及字段显示名
    	int tempFieldLableId = RecordSet.getInt("fieldlabel");
    	fieldids.add(RecordSet.getString("id"));
    	fieldnames.add(RecordSet.getString("fieldname"));
    	fieldlables.add(""+tempFieldLableId);
    	fieldlablenames.add(SystemEnv.getHtmlLabelName(tempFieldLableId,7));
    	fieldlablenamesE.add(SystemEnv.getHtmlLabelName(tempFieldLableId,8));
    	fieldlablenamesT.add(SystemEnv.getHtmlLabelName(tempFieldLableId,9));
    	viewtypes.add(RecordSet.getString("viewtype"));
    	groupids.add(RecordSet.getString("groupid"));
    	issystems.add(RecordSet.getString("issystem"));
    	fieldtypes.add(RecordSet.getString("fieldtype"));
    	
    }
  	
  	if(fieldids.size()==0){
  		continue;
  	}
  	
%>
<wea:group context='<%=SystemEnv.getHtmlLabelName(Util.getIntValue(CptCardGroupComInfo.getLabel()), user.getLanguage()) %>' attributes="{'groupDisplay':''}">
<wea:item attributes="{'isTableList':'true'}">
<TABLE CLASS="ListStyle" valign="top" cellspacing=1 style="z-index:1!important;">
      <colgroup>                           
      <col width="25%">
      <col width="25%">
      <col width="25%">
      <col width="25%">    
<%
for(int tmpcount=0; tmpcount< fieldids.size(); tmpcount++){
	String id = (String)fieldids.get(tmpcount);
	String fieldname = (String)fieldnames.get(tmpcount);
	String fieldlablename = (String)fieldlablenames.get(tmpcount);
	String fieldlablenameE = Util.null2String((String)fieldlablenamesE.get(tmpcount));
	String fieldlablenameT = Util.null2String((String)fieldlablenamesT.get(tmpcount));
	String viewtype = (String)viewtypes.get(tmpcount);
	String issystem = (String)issystems.get(tmpcount);
	String fieldtype = (String)fieldtypes.get(tmpcount);
	if("2".equals(fieldtype)){
		id="prjtype_"+id;
	}
	boolean sysField="1".equals(issystem);
	String readonly="1".equals(issystem)?"readonly='readonly'":"";
	%>
	<tr class="DataLight">
		<td><%=fieldname%></td>
		<td>
			<input type="<%=sysField?"hidden":"text" %>" class=InputStyle style="width:95%;" <%=readonly %> name="field_<%=id%>_CN" value="<%=fieldlablename%>" onchange="checkinput('field_<%=id%>_CN','field_<%=id%>_CN_span');setChange('<%=id%>')" maxlength="255" onblur="checkMaxLength(this)" alt="<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>255(<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>)"><span id=field_<%=id%>_CN_span></span>
			<%=sysField?"<span style='margin-right:5px;'>"+fieldlablename+"</span>":"" %>
		</td>
		<td>
			<input type="<%=sysField?"hidden":"text" %>" class=InputStyle style="width:95%;" <%=readonly %> name="field_<%=id%>_En" value="<%=fieldlablenameE%>" onchange="setChange('<%=id%>')" maxlength="255" onblur="checkMaxLength(this)" alt="<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>255(<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>)">
			<%=sysField?"<span style='margin-right:5px;'>"+fieldlablenameE+"</span>":"" %>
		</td>
		<td>
			<input type="<%=sysField?"hidden":"text" %>" class=InputStyle style="width:95%;" <%=readonly %> name="field_<%=id%>_TW" value="<%=fieldlablenameT%>" onchange="setChange('<%=id%>')" maxlength="255" onblur="checkMaxLength(this)" alt="<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>255(<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>)">
			<%=sysField?"<span style='margin-right:5px;'>"+fieldlablenameT+"</span>":"" %>
		</td>
	</tr>
	<%
	
}
%>	
    
</TABLE>
</wea:item>
</wea:group>
<%
  	
}
    
%>



</wea:layout>

</form>

<script type="text/javascript">
function onBtnSearchClick(){
	jQuery("#fieldlabelfrm").submit();
}
function setChange(fieldid){
	//alert("fieldid:"+fieldid);
	$G("checkitems").value += "field_"+fieldid+"_CN,"
	var changefieldids = $G("changefieldids").value;
	if(changefieldids.indexOf(fieldid)<0)
		$G("changefieldids").value = changefieldids + fieldid + ",";
	//alert("changefieldids:"+$G("changefieldids").value);
}
function fieldlablesall0(){
	fieldlabelfrm.action="/proj/ffield/prjFieldOperation.jsp";
	var checks = $G("checkitems").value;
	if(check_form(fieldlabelfrm,checks)){
		fieldlabelfrm.submit();
	}else{
		return;
	}		
}
$(function(){
	//高亮搜索
	$("#topTitle").topMenuTitle({});
});
</script>

</body>
</html>
