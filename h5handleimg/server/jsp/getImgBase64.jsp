<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%
JSONObject reqObj = new JSONObject(aa.req.getContent());
String url = (String)reqObj.get("source");
%>
<aa:http id="img" url="<%=url %>" method="get"></aa:http>
<%
byte body[] = aa.rsp.getAttachBody("img");
sun.misc.BASE64Encoder encode =  new sun.misc.BASE64Encoder();
//将图片转成img元素支持的base64写法
String base64 = encode.encode(body); 
%>
<%="data:image/png;base64,"+base64%>