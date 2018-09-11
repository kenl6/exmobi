<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String uuid = UUID.randomUUID().toString().replaceAll("-","");
	String login_id = aa.req.getParameter("login_id");
	String username = aa.req.getParameter("username");
	String loginpwd = aa.req.getParameter("loginpwd");
	String sex = aa.req.getParameter("sex");
	String identifyid = aa.req.getParameter("identifyid");
	String remark = aa.req.getParameter("remark");
	String telno = aa.req.getParameter("tel");


	String insertSql = "insert into tbl_user_info values(?,?,?,?,?,?,?,?)";
	int ret = aa.db.update("mysql_local", insertSql, new Object[]{uuid,login_id,loginpwd,username,sex,telno,identifyid,remark});
	JSONObject resultJson = new JSONObject();
	if(ret > 0 ){
		resultJson.put("result", "success").put("msg", "新增成功");
	}else{
		resultJson.put("result", "fail").put("msg", "新增失败");
	}
	log(resultJson.toString());
	out.print(resultJson.toString());
	
%>