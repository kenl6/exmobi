<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%
JSONObject reqObj = new JSONObject(aa.req.getContent());
String url = (String)reqObj.get("source");
%>
<aa:http id="news" url="<%=url %>" method="get">
</aa:http>
<%
JSONObject resultObj = new JSONObject();
//resultObj.put("title", aa.xpath.copyOfNodeAsStr("//hr[@class='title']", "news"));
resultObj.put("title", aa.xpath.xpath("//h1[@class='main-title']", "news"));
//String content = aa.xpath.copyOfNodeAsStr("//div[@calss='con news_content']", "news");
String content = aa.xpath.copyOfNodeAsStr("//div[@id='article']", "news");
//正则替换img的src属性为data-source，因为内网的url地址在webview上是无法访问，需要再次经过服务端请求
content = content.replaceAll("src", "data-source");
resultObj.put("content", content);
out.println(resultObj.toString());
%>
