<%@ page language="java" import="java.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
String filename = aa.req.getParameterFromUrl("filename");
%>
<aa:http id="getfile"></aa:http>
<%-- 判断客户端发起的是否是下载指令，通常是基座fileset控件的下载按钮，或者超链接设置了urltype=” download” --%>
<aa:if test="<%=aa.req.isDownload() %>">
	<aa:file-download filename="<%=filename%>" dsId="getfile"/>
</aa:if>
<aa:if test="<%=!aa.req.isDownload() %>">
	<aa:file-preview filename="<%=filename%>" dsId="getfile"/>
</aa:if>