<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String url = "http://127.0.0.1:8990/zq-ssm2/role/springUpload";

%>
<aa:http id="upload" keepreqdata="true" method="get" url="<%=url%>"></aa:http>
<% 
	LogUtil.info("query");
	out.print(aa.regex.regex(".*","upload"));

%>