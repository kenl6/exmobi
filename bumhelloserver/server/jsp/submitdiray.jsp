<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<aa:http id="submitdiray" method="post" reqcharset="gbk" url="https://webdomain/general/diary/new/submit.php" autoredirect="false"></aa:http>
<% 

	String location = aa.rsp.getHeader("location", "submitdiray");
	if(location.contains("../index.php")){
		out.print("{\"result\":\"success\"}");
	}else{
		out.print("{\"result\":\"fail\"}");
	}
%>