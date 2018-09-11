<%@ page language="java" import="java.util.*,java.io.*,java.nio.*,java.text.SimpleDateFormat"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	JSONObject outJson = new JSONObject();

	String activity_title = aa.req.getParameter("activity_title");
	String activity_content = aa.req.getParameter("activity_content");
		
	SimpleDateFormat formatTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String begin_timeStr = aa.req.getParameter("begin_time");
	java.util.Date beginDate = formatTime.parse(begin_timeStr);
	//活动开始时间
	Timestamp beginTime = new Timestamp(beginDate.getTime());
		
	String end_timeStr = aa.req.getParameter("end_time");
	java.util.Date endDate = formatTime.parse(end_timeStr);
	//活动结束时间
	Timestamp endTime = new Timestamp(endDate.getTime());
	
	if(beginDate.getTime() >= endDate.getTime()){
		outJson.put("result", "fail");
		outJson.put("msg", "开始时间必须早于结束时间");
		out.print(outJson.toString());
		return;
	}
		
	String address = aa.req.getParameter("address");
		
	String deadline_timeStr = aa.req.getParameter("deadline_time");
	java.util.Date deadlineDate = formatTime.parse(deadline_timeStr);
	//活动报名截止时间
	Timestamp deadlineTime = new Timestamp(deadlineDate.getTime());
	if(deadlineDate.getTime() >= beginDate.getTime()){
		outJson.put("result", "fail");
		outJson.put("msg", "报名截止时间必须早于活动开始时间");
		out.print(outJson.toString());
		return;
	}
		
	//活动联系人
	String contact_tel = aa.req.getParameter("contact_tel");
	//活动人数限制
	String person_limitStr = aa.req.getParameter("person_limit");
	Integer person_limit = !person_limitStr.equals("")?new Integer(person_limitStr):null;
	//用户报名必选项
	String nessary = aa.req.getParameter("necessary");
		
	//活动海报
	String poster_img_uuid = aa.req.getParameter("poster_img_uuid");
	//活动图片
	String activity_imgs = aa.req.getParameter("activity_imgs");
	
	
	//创建活动主键
	String activity_uuid = UUID.randomUUID().toString().replaceAll("-","");
	String inserSql = "insert into tbl_activity_info (";
	String sqlParamKey = "activity_uuid,begin_time,end_time,address,contact_tel,deadline_time,poster_img_uuid,activity_title,activity_content";
	String sqlParamCode = "?,?,?,?,?,?,?,?,?";
	List<Object> paramObjects = new ArrayList<Object>();
	paramObjects.add(activity_uuid);
	paramObjects.add(beginTime);
	paramObjects.add(endTime);
	paramObjects.add(address);
	paramObjects.add(contact_tel);
	paramObjects.add(deadlineTime);
	paramObjects.add(poster_img_uuid);
	paramObjects.add(activity_title);
	paramObjects.add(activity_content);
	
	if(null!=person_limit){
		sqlParamKey += ",person_limit";
		sqlParamCode +=",?";
		paramObjects.add(person_limit);
	}
	if(!nessary.equals("")){
		sqlParamKey += ",necessary";
		sqlParamCode +=",?";
		paramObjects.add(nessary);
	}
	if(!activity_imgs.equals("")){
		sqlParamKey += ",activity_imgs";
		sqlParamCode +=",?";
		paramObjects.add(activity_imgs);
	}
	
	inserSql += sqlParamKey+") values ("+sqlParamCode+")";
	int ret = aa.db.update("activity_mysql", inserSql, paramObjects.toArray());
	
	if(ret > 0){
		outJson.put("result", "success");
		outJson.put("msg", "发布活动成功");
	}else{
		outJson.put("result", "fail");
		outJson.put("msg", "入库失败，请联系管理员");
	}
	out.print(outJson.toString());
%>