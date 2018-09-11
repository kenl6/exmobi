<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*,org.json.*"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String username = aa.req.getParameter("username");
	String password = aa.req.getParameter("password");
	String sql = "select * from tbl_user_info where login_id = ? and login_pwd = ?";
	TableRow row = aa.db.queryRow("mysql_local", sql, new Object[]{username,password});
	JSONObject resultJson = new JSONObject();
	if(row != null ){
		resultJson.put("result", "success");
		JSONObject userObj = new JSONObject();
		userObj.put("uuid", row.getField("user_uuid", ""));
		userObj.put("user_name", row.getField("user_name", ""));
		userObj.put("login_id", row.getField("login_id", ""));
		userObj.put("login_pwd", row.getField("login_pwd", ""));
		userObj.put("remark", row.getField("remark", ""));
		userObj.put("sex", row.getField("sex", ""));
		userObj.put("identify_id", row.getField("identify_id", ""));
		userObj.put("tel_no", row.getField("tel_no", ""));
		resultJson.put("userinfo", userObj);
	}else{
		resultJson.put("result", "fail").put("msg", "用户名或密码错误");
	}
	out.print(resultJson.toString());
%>