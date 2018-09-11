<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String uuid = aa.req.getParameter("uuid");
	String login_id = aa.req.getParameter("login_id");
	String username = aa.req.getParameter("username");
	String loginpwd = aa.req.getParameter("loginpwd");
	String sex = aa.req.getParameter("sex");
	String identifyid = aa.req.getParameter("identifyid");
	String remark = aa.req.getParameter("remark");
	String telno = aa.req.getParameter("tel");
	log(login_id);

	String updateSql = "update tbl_user_info set login_pwd=?,user_name=?,sex=?,tel_no=?,identify_id=?,remark=? where user_uuid=?";
	int ret = aa.db.update("mysql_local", updateSql, new Object[]{loginpwd,username,sex,telno,identifyid,remark,uuid});
	JSONObject resultJson = new JSONObject();
	if(ret > 0 ){
		JSONObject userObj = new JSONObject();
		userObj.put("uuid", uuid);
		userObj.put("login_id", login_id);
		userObj.put("user_name", username);
		userObj.put("login_pwd", loginpwd);
		userObj.put("remark", remark);
		userObj.put("sex", sex);
		userObj.put("identify_id", identifyid);
		userObj.put("tel_no", telno);
		resultJson.put("userinfo", userObj);
		resultJson.put("result", "success").put("msg", "修改成功");
	}else{
		resultJson.put("result", "fail").put("msg", "修改失败");
	}
	log(resultJson.toString());
	out.print(resultJson.toString());
	
%>