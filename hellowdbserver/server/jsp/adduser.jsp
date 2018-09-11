<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*,org.json.*"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
String username = aa.req.getParameter("username");

String loginid = aa.req.getParameter("loginid");
String loginpwd = aa.req.getParameter("loginpwd");
String sex = aa.req.getParameter("sex");
String department = aa.req.getParameter("department");
String title = aa.req.getParameter("title");
String tel = aa.req.getParameter("tel");
String userUuid = UUID.randomUUID().toString().replaceAll("-",""); 

String inserSql = "insert into tbl_user_info values (?,?,?,?,?,?,?,?)";
int ret = aa.db.update("mysql_local", inserSql, new Object[]{userUuid,loginid,loginpwd,username,sex,department,title,tel});
JSONObject resultJson = new JSONObject();
if(ret > 0 ){
	resultJson.put("result", "success").put("msg", "新增人员成功");
}else{
	resultJson.put("result", "fail").put("msg", "新增人员失败");
}
out.print(resultJson.toString());
%>
