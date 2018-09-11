<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*,org.json.*"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>

<aa:http id="newdiary" method="get" url="https://webdomain/general/diary/new/?FROM_URL=diary"></aa:http>
<% 
	JSONObject result = new JSONObject();
	JSONArray hidParams = new JSONArray();
	
%>
<aa:for-each var="hid" dsId="newdiary" xpath="//input[@type='hidden']">
<% 
	JSONObject hidden = new JSONObject();
		hidden.put("name", aa.xpath.xpath("./@name", "hid"));
		hidden.put("value", aa.xpath.xpath("./@value", "hid"));
		hidParams.put(hidden);
%>
</aa:for-each>
<% 
	result.put("hidParams", hidParams);
		out.print(result.toString());
%>