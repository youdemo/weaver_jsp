<%@page import="java.text.SimpleDateFormat"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util, weaver.file.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>

<%

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String nowDate = sdf.format(new Date());
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String todate = Util.null2String(request.getParameter("todate"));
	String OANO = Util.null2String(request.getParameter("OANO"));
	String resID = Util.null2String(request.getParameter("resID"));
	String endFale = Util.null2String(request.getParameter("endFalg"));
	String inFalg = Util.null2String(request.getParameter("inFalg"));
	String money = Util.null2String(request.getParameter("money"));
	String rzfromdate = Util.null2String(request.getParameter("rzfromdate"));
	String rztodate = Util.null2String(request.getParameter("rztodate"));
	
	double sumsbje = 0.00;
	
	String sql = "";
    String tablename = "";
    String detailtablename = "";
//     sql = "Select tablename From Workflow_bill Where id=(";
// 	sql += "Select formid From workflow_base Where id='37')";
    tablename = "formtable_main_1844";
	detailtablename = " formtable_main_1844_dt1";
	//申请人sqr
	String f_sqr = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqr"));
	//申请部门
	String f_sqbm = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqbm"));
	//申报金额
	String f_sbje = Util.null2String(Prop.getPropValue("FinancialDocuments", "sbje"));
	//实报金额
	String f_bxje = Util.null2String(Prop.getPropValue("FinancialDocuments", "bxje"));
	//申报日期
	String f_sbrq = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqrq"));
	//OA编号
	String f_oabh = Util.null2String(Prop.getPropValue("FinancialDocuments", "oabh"));
	//导入标志
	String f_drbz = Util.null2String(Prop.getPropValue("FinancialDocuments", "drbz"));
	//是否生成凭证
	String f_sfscpz = Util.null2String(Prop.getPropValue("FinancialDocuments", "sfxydr"));
	//所属一级部门
	String f_ssyjbm = Util.null2String(Prop.getPropValue("FinancialDocuments", "ssyjbm"));
	//凭证号
	String f_pzh = Util.null2String(Prop.getPropValue("FinancialDocuments", "pzh"));
	//相关的workflowid
	String workflowid = Util.null2String(Prop.getPropValue("workflowStatusList", "workflowid"));
	//节点ID
	String nodeid = Util.null2String(Prop.getPropValue("workflowStatusList", "nodeid"));
	//是否导出excel
	String f_sfdc = Util.null2String(Prop.getPropValue("FinancialDocuments", "sfdc"));
	//入账日期
	String f_rzrq = Util.null2String(Prop.getPropValue("FinancialDocuments", "rzrq"));
	
	
	
	//设置好搜索条件
//                                 String backFields =" t1.id,t1."+f_sqr+",t1."+f_sqbm+",t1."+f_sbje+",t1."+f_bxje+",t1."+f_sbrq+",t1."+f_oabh+",t1."+f_drbz+",t1."+f_sfscpz+",t2.currentnodetype,t3.nodename ";
                                String backFields =" t1.id,t1."+f_sqr+",t1."+f_sqbm+",t1."+f_sbje+",t1."+f_bxje+",t1."+f_sbrq+",t1."+f_oabh+", case t1."+f_drbz+" when 0 then '未导入' when 1 then '已导入' else '' end as ffdrbz,t1."+f_sfscpz+",t1."+f_ssyjbm+",t1."+f_rzrq+",t1."+f_pzh+",case t1."+f_sfdc+" when 1 then '已导入' else '未导入' end as ff_sfdc,t1.requestid,t2.currentnodetype,t3.nodename,t4.sumamount,'详细' as xx ";
                                String fromSql = tablename + " t1 "+
                                        " left join (select t1.requestid,t2.sumamount from "+tablename+" t1 left join (select t1.id,sum(t1."+f_sbje+") as sumamount from "+detailtablename+" t1 group by t1.id) t2 on t1.id = t2.id) t4 on t1.requestid = t4.requestid"+
                                        " left join workflow_requestbase t2 on t1.requestid = t2.requestid "+
                                        " left join (select t1.id,t1.nodename,t2.requestid from workflow_nodebase t1 left join workflow_requestbase t2 on t2.currentnodeid = t1.id) t3 on t3.requestid = t1.requestid"; 
//                                 String sqlWhere = " where t1.requestid in (select requestid from workflow_requestbase where workflowid in ("+workflowid+")) and t3.id in ("+nodeid+") and t1."+f_sbrq+" is not null";
                          //      String sqlWhere = " where t1.requestid in (select requestid from workflow_requestbase where workflowid in ("+workflowid+")) and t1."+f_sbrq+" is not null";
                                
                                String sqlWhere = " where t1."+f_sbrq+" is not null";
                                
                                String orderBy=" t1.id ";
                                if(!"".equals(fromdate)){
                                	sqlWhere += " and t1."+f_sbrq+" >= '"+fromdate+"'";
                                }
                                if(!"".equals(todate)){
                                	sqlWhere += " and t1."+f_sbrq+" <= '"+todate+"'";
                                }
                                if(!"".equals(OANO)){
                                	sqlWhere += " and t1."+f_oabh+" like '%"+OANO+"%'";
                                }
                                if(!"".equals(resID)){
                                	sqlWhere += " and t1."+f_sqr+" = '"+resID+"'";
                                }
                                if(!"".equals(endFale) && "3".equals(endFale)){
                                	sqlWhere += " and t2.currentnodetype = '"+endFale+"'";
                                }else if(!"".equals(endFale) && !"3".equals(endFale)){
                                	sqlWhere += " and t2.currentnodetype <> '3'";
                                }
                                if(!"".equals(inFalg)){
                                	sqlWhere += " and t1."+f_drbz+" = '"+inFalg+"'";
                                }
                                if(!"".equals(money)){
                                	sqlWhere += " and t1."+f_bxje+" = '"+money+"'";
                                }
                                if(!"".equals(rzfromdate)){
                                	sqlWhere += " and t1."+f_rzrq+" >= '"+rzfromdate+"'";
                                }
                                if(!"".equals(rztodate)){
                                	sqlWhere += " and t1."+f_rzrq+" <= '"+rztodate+"'";
                                }
    String sqlstr="";
    StringBuffer sb ;
    
    sb=new StringBuffer();
	sb.append(backFields);
	sb.append(fromSql);
	sb.append(sqlorderby);
	sb.append("t1.id");
	sb.append("Asc");
	sb.append(Util.toHtmlForSplitPage(sqlWhere));
	
	new BaseBean().writeLog("导出"+sb.toString());
    RecordSet.executeSql(sb.toString());

    
	ExcelFile.init() ;
	ExcelFile.setFilename("流程凭证表") ;

	ExcelStyle style;
	//表头样式
	style = ExcelFile.newExcelStyle("Header") ;
	style.setFontbold(ExcelStyle.Strong_Font);
	style.setAlign(ExcelStyle.ALIGN_CENTER);
	style.setValign(ExcelStyle.VALIGN_CENTER);
	style.setFontheight(16);
	//标题样式
	style = ExcelFile.newExcelStyle("Title") ;
	style.setFontbold(ExcelStyle.Strong_Font);
	style.setAlign(ExcelStyle.ALIGN_CENTER);
	style.setValign(ExcelStyle.VALIGN_CENTER);
	style.setCellBorder(ExcelStyle.WeaverBorderThin);
	style.setGroundcolor(43);

	ExcelSheet es = new ExcelSheet();
	//列宽度
    es.addColumnwidth(5000);//报销日期
	es.addColumnwidth(5000);//OA单据号
	es.addColumnwidth(5000);//报销人
	es.addColumnwidth(5000);//所属一级部门
	es.addColumnwidth(5000);//报销部门
	es.addColumnwidth(5000);//申报金额
	es.addColumnwidth(5000);//实报金额
	es.addColumnwidth(5000);//导入标志
	es.addColumnwidth(5000);//凭证号
	es.addColumnwidth(5000);//流程标记
	es.addColumnwidth(5000);//导出日期
    //表头
    ExcelRow er = es.newExcelRow();
    er.addStringValue("流程凭证表","Header",14);
    
    
    er = es.newExcelRow();
    er.addStringValue("报销日期","Title");
    er.addStringValue("OA单据号","Title");
    er.addStringValue("报销人","Title");
    er.addStringValue("所属一级部门","Title");
    er.addStringValue("报销部门","Title");
    er.addStringValue("申报金额","Title");
    er.addStringValue("实报金额","Title");
    er.addStringValue("导入标志","Title");
    er.addStringValue("凭证号","Title");
    er.addStringValue("流程标记","Title");
    er.addStringValue("导出日期","Title");
    
    while(RecordSet.next()){
    	er = es.newExcelRow();
    	er.addStringValue(RecordSet.getString(f_sbrq));
//     	new BaseBean().writeLog(RecordSet.getString(f_sbrq));
		er.addStringValue(RecordSet.getString(f_oabh));
		er.addStringValue(ResourceComInfo.getLastname(RecordSet.getString(f_sqr)));
		er.addStringValue(DepartmentComInfo.getDepartmentname(RecordSet.getString(f_ssyjbm)));
		er.addStringValue(DepartmentComInfo.getDepartmentname(RecordSet.getString(f_sqbm)));
		er.addValue(Util.getDoubleValue(RecordSet.getString(f_sbje)));
		er.addValue(Util.getDoubleValue(RecordSet.getString(f_bxje)));
		er.addStringValue(RecordSet.getString("ffdrbz"));
		er.addStringValue(RecordSet.getString(f_pzh));
		er.addStringValue(RecordSet.getString("requestid"));
		er.addStringValue(nowDate);
		sumsbje+=Util.getDoubleValue(RecordSet.getString(f_bxje));
// 		new BaseBean().writeLog(sumsbje+"金额");
		
// 		rs.executeSql("update "+tablename+" set "+f_sfdc+" = '1' where requestid = '"+RecordSet.getString("requestid")+"'");
    }

    er = es.newExcelRow();
    er.addStringValue("");
    er.addStringValue("");
    er.addStringValue("");
    er.addStringValue("");
    er.addStringValue("");
    er.addStringValue("");
    er.addStringValue("");
    er.addStringValue("");
    er.addStringValue("");
    er.addStringValue("");
    
    er = es.newExcelRow();
    er.addStringValue("合计", "", 6);
    er.addValue(sumsbje);
    ExcelFile.addSheet("流程凭证表", es) ;
%>
<!-- success -->
<script language="javascript">
    window.location="/weaver/weaver.file.ExcelOut?type=1";
	alert('导出成功');
    parent.location.replace(parent.location.href); 
</script>