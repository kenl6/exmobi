<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String login_id = aa.req.getParameter("login_id");
	String sql = "select * from tbl_user_info where login_id = ?";
	TableRow row = aa.db.queryRow("activity_mysql", sql, new Object[]{login_id});
	if(null != row){
		out.print("{\"repeat\":\"1\"}");
	}else{
		out.print("{\"repeat\":\"0\"}");
	}
%>