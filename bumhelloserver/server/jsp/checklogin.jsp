<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String username = aa.req.getParameter("username");
	String password = aa.req.getParameter("password");		
%>
<%--<aa:http id="dologin" url="https://webdomain/logincheck.php" method="post" keepreqdata="false">
	<aa:param name="UNAME" value="<%=username %>"/>
	<aa:param name="PASSWORD" value="<%=password %>"/>
	<aa:param name="encode_type" value="1"/>
</aa:http>--%>
<aa:http id="dologin">
</aa:http>
<% 

	String rsp = aa.xpath.xpath("//div[@class='big1']/text()", "dologin");
	if(rsp.indexOf("正在进入OA系统") > -1){
		out.print("{\"result\":\"success\"}");
	}else{
		rsp = aa.xpath.xpath("//div[@class='msg-content']/text()", "dologin");
		out.print("{\"result\":\"fail\",\"msg\":\""+rsp+"\"}");
	}
%>
