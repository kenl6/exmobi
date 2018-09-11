<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String act_uuid = aa.req.getParameter("act_uuid");
	String user_uuid = aa.req.getParameter("user_uuid");
	String insertSql = "insert into tbl_activity_user values (?,?)";
	
	JSONObject outJson = new JSONObject();
	String querySql = "select a.*,(select count(*) FROM tbl_activity_user b WHERE b.activity_uuid=a.activity_uuid) as join_count from tbl_activity_info a where a.activity_uuid = ?";
	TableRow actRow = aa.db.queryRow("activity_mysql", querySql, new Object[]{act_uuid});
	if(null!=actRow){
		int personLimit = actRow.getField("person_limit", 0);
		int joinCount = actRow.getField("joing_count", 0);
		if(joinCount >= personLimit){//报名人数限制校验
			outJson.put("result", "fail");
			outJson.put("msg", "活动报名人数已满");
			out.print(outJson.toString());
			return;
		}
		Timestamp deadlineTimestamp = (Timestamp)actRow.getField("deadline_time");
		long deadlineTime = deadlineTimestamp.getTime();
		long currentMillis = System.currentTimeMillis();
		if(currentMillis >= deadlineTime){//报名截止时间校验
			outJson.put("result", "fail");
			outJson.put("msg", "已过活动报名时间");
			out.print(outJson.toString());
			return;
		}
		
		int ret = aa.db.update("activity_mysql", insertSql, new Object[]{act_uuid,user_uuid});
		if(ret > 0){
			outJson.put("result", "success");
			outJson.put("msg", "报名成功");
		}else{
			outJson.put("result", "fail");
			outJson.put("msg", "报名失败，请联系管理员");
		}
		out.print(outJson.toString());
	}else{
		outJson.put("result", "fail");
		outJson.put("msg", "此活动不存在");
		out.print(outJson.toString());
		return;
	}
	
%>