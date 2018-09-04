<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>

<% 
	LogUtil.info("打印日志信息");
	
	String username = aa.req.getParameter("username");
	String password = aa.req.getParameter("password");
	String url = "http://127.0.0.1:8990/zq-ssm2/user/query?name="+username+"&password="+password;
	//out.print("{\"result\":\"lalala\"}");
	LogUtil.info(username+":"+password);
%>
<aa:http id="login" keepreqdata="false" method="get" url="<%=url%>"></aa:http>
<% 
	LogUtil.info("eos");
	out.print(aa.regex.regex(".*","login"));

%>

