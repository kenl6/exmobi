<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String actTitle = aa.req.getParameter("actTitile");
	String actStatusParam = aa.req.getParameter("actStatus");
	String querySql = "select a.*,(select count(*) FROM tbl_activity_user b WHERE b.activity_uuid=a.activity_uuid) as join_count from tbl_activity_info a where 1=1 ";
	List<Object> params = new ArrayList<Object>();
	if(!actTitle.equals("")){
		querySql += "and a.activity_title like ?";
		params.add(actTitle);
	}
	SimpleDateFormat formatTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	long currentMillis = System.currentTimeMillis();
	java.util.Date currentDate =  new java.util.Date(currentMillis);
	Timestamp currentTime = new Timestamp(currentMillis);
	if(!actStatusParam.equals("")){
		int status = new Integer(actStatusParam);
		switch(status){
			case 1://报名中
				querySql += " and a.deadline_time > ?";
				params.add(currentTime);
				break;
			case 2://报名截止
				querySql += " and a.deadline_time <= ? and a.begin_time > ?";
				params.add(currentTime);
				params.add(currentTime);
				break;
			case 3://进行中
				querySql += " and a.begin_time <= ? and a.end_time > ?";
				params.add(currentTime);
				params.add(currentTime);
				break;
			default://已结束
				querySql += " and a.end_time <= ?";
				params.add(currentTime);
				params.add(currentTime);
				break;
		}
	}
	Object[] paramsObject = null;
	if(params.size() > 0){
		paramsObject = params.toArray();
	}
	List<TableRow> actRows = aa.db.query("activity_mysql", querySql, paramsObject);
	JSONObject outJson = new JSONObject();
	JSONArray acts = new JSONArray();
	for(TableRow row:actRows){
		JSONObject activity = new JSONObject();
		activity.put("activity_uuid", row.getField("activity_uuid", ""));
		activity.put("activity_title", row.getField("activity_title", ""));
		activity.put("activity_content", row.getField("activity_content", ""));
		
		Timestamp beginTimestamp = (Timestamp)row.getField("begin_time");
		long beginTime = beginTimestamp.getTime();
		java.util.Date beginDate = new java.util.Date(beginTime);
		String beginStr = formatTime.format(beginDate);
		activity.put("begin_time",beginStr);
		
		Timestamp endTimestamp = (Timestamp)row.getField("end_time");
		long endTime = endTimestamp.getTime();
		java.util.Date endDate = new java.util.Date(endTime);
		String endStr = formatTime.format(endDate);
		activity.put("end_time", endStr);
		
		activity.put("address", row.getField("address", ""));
		activity.put("contact_tel", row.getField("contact_tel", ""));
		Timestamp deadlineTimestamp = (Timestamp)row.getField("deadline_time");
		long deadlineTime = deadlineTimestamp.getTime();
		java.util.Date deadlineDate = new java.util.Date(deadlineTime);
		String deadlineStr = formatTime.format(deadlineDate);
		activity.put("deadline_time", deadlineStr);
		
		activity.put("person_limit", row.getField("person_limit", 0));
		activity.put("poster_img_uuid", row.getField("poster_img_uuid", ""));
		activity.put("activity_imgs", row.getField("activity_imgs", ""));
		activity.put("necessary", row.getField("necessary", ""));
		
		String actStatus = "";
		if(currentMillis < deadlineTime){
			actStatus = "报名中";
		}else if(currentMillis >= deadlineTime && currentMillis < beginTime){
			actStatus = "报名截止";
		}else if(currentMillis >= beginTime && currentMillis < endTime){
			actStatus = "进行中";
		}else{
			actStatus = "已结束";
		}
		activity.put("actStatus", actStatus);
		activity.put("join_count", row.getField("join_count", 0));
		acts.put(activity);
	}
	outJson.put("acts", acts);
	out.print(outJson.toString());
%>