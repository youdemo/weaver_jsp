<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
		<script type="text/javascript">
$(function(){
    $('.e8_box').Tabs({
        getLine:1,
        iframe:"tabcontentframe",

        staticOnLoad:true
    });
}); 
</script>

<style type="text/css"> 
#i{ 
width:100%; 
height:300px; 
} 
</style> 
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());

	String needfav ="1";
	String needhelp ="";
	
	//判断操作
	int userid = user.getUID();
	String billid="";
	String sql="select b.id from hrmresource a,uf_person_detail b where a.loginid=b.loginid and a.id="+userid;
	rs.executeSql(sql);
	if(rs.next()){
		billid = Util.null2String(rs.getString("id"));
	}
	String LOGINID="";//账号
	String idcard_type="";//证件类型
	String idcard_no="";//证件编号
	String residence_address="";//户籍地址
	String home_address="";//现居住地址
	String emergency_contact_person_name="";//紧急联系人姓名
	String emergency_contact_person_phone="";//紧急联系人电话
	String birthday="";//生日
	String is_marry="";//婚姻状况
	String highest_education="";//最高学历
	String highest_degree="";//最高学位
   
    sql="select a.*,(select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id and b.tablename='uf_person_detail' and a.fieldname= 'is_marry' and c.selectvalue=is_marry) as marryval from uf_person_detail a where a.id="+billid;
	rs.executeSql(sql);
	if(rs.next()){
		LOGINID = Util.null2String(rs.getString("LOGINID"));
		idcard_type = Util.null2String(rs.getString("idcard_type"));
		idcard_no = Util.null2String(rs.getString("idcard_no"));
		residence_address = Util.null2String(rs.getString("residence_address"));
		home_address = Util.null2String(rs.getString("home_address"));
		emergency_contact_person_name = Util.null2String(rs.getString("emergency_contact_person_name"));
		emergency_contact_person_phone = Util.null2String(rs.getString("emergency_contact_person_phone"));
		birthday = Util.null2String(rs.getString("birthday"));
		is_marry = Util.null2String(rs.getString("marryval"));
		highest_education = Util.null2String(rs.getString("highest_education"));
		highest_degree = Util.null2String(rs.getString("highest_degree"));
	}
	%>
   <script type="text/javascript"> 
   var billid1=<%=billid%>;
 function jyxx(){ 
var jyxx = document.getElementById("i"); 
jyxx.src = "/opple/personinfo/jyxx-detail.jsp?billid="+billid1; 
jQuery("#yq2").removeClass("current");
jQuery("#yq3").removeClass("current");
jQuery("#yq4").removeClass("current");
jQuery("#yq1").addClass("current");
} 
function zcxx(){ 
var zcxx = document.getElementById("i"); 
zcxx.src =  "/opple/personinfo/zcxx-detail.jsp?billid="+billid1; 
jQuery("#yq1").removeClass("current");
jQuery("#yq3").removeClass("current");
jQuery("#yq4").removeClass("current");
jQuery("#yq2").addClass("current");
} 
function zgxx(){ 
var zgxx = document.getElementById("i"); 
zgxx.src = "/opple/personinfo/zgxx-detail.jsp?billid="+billid1; 
jQuery("#yq1").removeClass("current");
jQuery("#yq2").removeClass("current");
jQuery("#yq4").removeClass("current");
jQuery("#yq3").addClass("current");
} 
function jtcy(){ 
var jtcy = document.getElementById("i"); 
jtcy.src = "/opple/personinfo/jtcyxx-detail.jsp?billid="+billid1; 
jQuery("#yq1").removeClass("current");
jQuery("#yq2").removeClass("current");
jQuery("#yq3").removeClass("current");
jQuery("#yq4").addClass("current");
} 
</script> 
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			
		
		<div >
				<wea:layout type="2col">
				<wea:group context="" attributes="{\"groupDisplay\":\"none\"}">
				<wea:item>账号</wea:item>
				<wea:item><%=LOGINID%></wea:item>
				<wea:item>证件类型</wea:item>
				<wea:item><%=idcard_type%></wea:item>
				<wea:item>证件编号</wea:item>
				<wea:item><%=idcard_no%></wea:item>
				<wea:item>户籍地址</wea:item>
				<wea:item><%=residence_address%></wea:item>
				<wea:item>现居住地址</wea:item>
				<wea:item><%=home_address%></wea:item>
				<wea:item>紧急联系人姓名</wea:item>
				<wea:item><%=emergency_contact_person_name%></wea:item>
				<wea:item>紧急联系人电话</wea:item>
				<wea:item><%=emergency_contact_person_phone%></wea:item>
				<wea:item>生日</wea:item>
				<wea:item><%=birthday%></wea:item>
				<wea:item>婚姻状况</wea:item>
				<wea:item><%=is_marry%></wea:item>
				<wea:item>最高学历</wea:item>
				<wea:item><%=highest_education%></wea:item>
				<wea:item>最高学位</wea:item>
				<wea:item><%=highest_degree%></wea:item>
			
				

			

				</wea:group>			
				</wea:layout>
		</div>
<div class="e8_box">
         <div class="div_e8_xtree" id="div_e8_xtree"></div>
         
       <div>
             <ul class="tab_menu">
                <li class="e8_tree">
                   <a href="#"></a>
                </li>
   
            <li class="current" id="yq1">
            <a href="javascript:jyxx()" >
            教育信息
            </a>
           </li>
           <li id="yq2">
            <a href="javascript:zcxx()" >
            职称信息
            </a>
           </li>
            <li id="yq3">
              <a href="javascript:zgxx()" >
          资格信息
            </a>
           </li>
           <li id="yq4">
              <a href="javascript:jtcy()" >
           家庭成员
            </a>
           </li>
          </ul>
   
     
     </div>
  </div>
           <iframe id = "i" scrolling = "no" src="/opple/personinfo/jyxx-detail.jsp?billid=<%=billid%>" frameborder="0"> 
				
		</FORM>
	<script type="text/javascript">
  
	   function refersh() {
  			window.location.reload();
  		}
 
	</script>
</BODY>
</HTML>