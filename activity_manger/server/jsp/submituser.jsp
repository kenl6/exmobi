<%@ page language="java" import="java.util.*,org.json.*"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	JSONObject oj = new JSONObject();
	JSONObject currentUser = new JSONObject();
	String user_uuid = aa.req.getParameter("user_uuid");
	String login_id = aa.req.getParameter("login_id");
	String login_pwd = aa.req.getParameter("login_pwd");
	String user_name = aa.req.getParameter("user_name");
	String sex = aa.req.getParameter("sex");
	String tel_no = aa.req.getParameter("tel_no");
	String identify_id = aa.req.getParameter("identify_id"); 
	String remark = aa.req.getParameter("remark"); 
	
	if(login_id.equals("") || login_pwd.equals("") || user_name.equals("")){
		oj.put("result", "fail");
		oj.put("msg", "必填参数缺失");
	}
	
	boolean UpdateFlag = false;
	if(null != user_uuid && !("").equals(user_uuid)){
		UpdateFlag = true;
	}
	String finalSql = "";
	List<Object> sqlParams = new ArrayList<Object>();
	if(UpdateFlag){
		finalSql = "update tbl_user_info set login_pwd = ?,user_name = ?";
		sqlParams.add(login_pwd);
		sqlParams.add(user_name);
		if(!("").equals(sex)){
			finalSql += ",sex = ?";
			sqlParams.add(new Integer(sex));
		}
		if(!("").equals(tel_no)){
			finalSql += ",tel_no = ?";
			sqlParams.add(tel_no);
		}
		if(!("").equals(identify_id)){
			finalSql += ",identify_id = ?";
			sqlParams.add(identify_id);
		}
		if(!("").equals(remark)){
			finalSql += ",remark = ? ";
			sqlParams.add(remark);
		}
		finalSql += "where user_uuid = ?";
		sqlParams.add(user_uuid);
		
	}else{
		finalSql = "insert into tbl_user_info (user_uuid, login_id, login_pwd, user_name";
		user_uuid = UUID.randomUUID().toString().replaceAll("-","");
		sqlParams.add(user_uuid);
		sqlParams.add(login_id);
		sqlParams.add(login_pwd);
		sqlParams.add(user_name);
		String valStrs = "?,?,?,?";
		if(!("").equals(sex)){
			finalSql += ",sex ";
			valStrs += ",?";
			sqlParams.add(sex);
		}
		if(!("").equals(tel_no)){
			finalSql += ",tel_no ";
			valStrs += ",?";
			sqlParams.add(tel_no);
		}
		if(!("").equals(identify_id)){
			finalSql += ",identify_id ";
			valStrs += ",?";
			sqlParams.add(identify_id);
		}
		if(!("").equals(remark)){
			finalSql += ",remark ";
			valStrs += ",?";
			sqlParams.add(remark);
		}
		finalSql+=") values ("+valStrs+")";
		System.out.println(finalSql);
	}
	int sqlResult = aa.db.update("activity_mysql", finalSql, sqlParams.toArray());
	if(sqlResult > 0){
		oj.put("result", "success");
		oj.put("msg", "提交成功");
		if(UpdateFlag){
			currentUser.put("user_uuid", user_uuid);
			currentUser.put("login_id", login_id);
			currentUser.put("login_pwd", login_pwd);
			currentUser.put("user_name", user_name);
			currentUser.put("sex", new Integer(sex));
			currentUser.put("tel_no", tel_no);
			currentUser.put("identify_id", identify_id);
			currentUser.put("remark", remark);
			oj.put("currentUser", currentUser);
		}
	}else{
		oj.put("result", "fail");
		oj.put("msg", "入库失败，请联系管理员");
	}
	out.print(oj.toString());
%>