<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*,org.json.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String login_id = aa.req.getParameter("login_id");
	String login_pwd = aa.req.getParameter("login_pwd");
	JSONObject oj = new JSONObject();
	if(login_id.equals("") || login_pwd.equals("")){
		oj.put("result", "fail");
		oj.put("msg", "用户名或密码缺失");
	}
	String sql = "select * from tbl_user_info where login_id = ? and login_pwd = ?";
	TableRow row  = aa.db.queryRow("activity_mysql", sql, new Object[]{login_id,login_pwd});
	if(null != row){
		oj.put("result", "success");
		JSONObject user_info = new JSONObject();
		user_info.putOpt("user_uuid", row.getField("user_uuid", ""));
		user_info.putOpt("user_name", row.getField("user_name", ""));
		user_info.putOpt("sex", row.getField("sex", 1));
		user_info.putOpt("tel_no", row.getField("tel_no", ""));
		user_info.putOpt("login_id", row.getField("login_id", ""));
		user_info.putOpt("login_pwd", row.getField("login_pwd", ""));
		user_info.putOpt("identify_id", row.getField("identify_id", ""));
		user_info.putOpt("remark", row.getField("remark", ""));
		oj.put("user_info", user_info);
	}else{
		oj.put("result", "fail");
		oj.put("msg", "用户名或密码错误");
	}
	out.print(oj.toString());
%>