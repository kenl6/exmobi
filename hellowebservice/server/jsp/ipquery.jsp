<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*,org.json.*"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<%
	//String ipaddr = aa.req.getParameter(arg0)
	//String ipaddr = aa.req.getParameterFromUrl("ipaddr");//从客户端提交的url里取参数
	String content = aa.req.getContent();//获取客户端提交的非键值对参数体;
	System.out.println("&&&&&&&&&&&&&&&&&"+content);
	JSONObject paramJson = new JSONObject(content);
	String ipaddr = paramJson.getString("ipaddr");
%>
<aa:http id="ipquery" url="http://www.webxml.com.cn/WebServices/IpAddressSearchWebService.asmx" method="post" keepreqdata="false">
<aa:header name="Content-Type" value="application/soap+xml;charset=UTF-8;action=http://WebXml.com.cn/getCountryCityByIp"/>
<aa:content>
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://WebXml.com.cn/">
   <soap:Header/>
   <soap:Body>
      <web:getCountryCityByIp>
         <!--Optional:-->
         
      <web:theIpAddress><%=ipaddr %></web:theIpAddress></web:getCountryCityByIp>
   </soap:Body>
</soap:Envelope>
</aa:content>
</aa:http>
<% 
	String xmlStr = aa.regex.regex(".*", "ipquery");
%>
<aa:datasource value="<%=xmlStr %>" id="ipxml" wellformed="true"></aa:datasource>
<% 
	String addr = aa.xpath.xpath("(//*[local-name() = 'string'])[2]/text()","ipxml");
	out.print("{\"addr\":\""+addr+"\"}");

%>







