<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*,java.io.*"
 contentType="image/*; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	String img_uuid = aa.req.getParameterFromUrl("img_uuid").equals("")?aa.req.getParameter("img_uuid"):aa.req.getParameterFromUrl("img_uuid");
	String queryimgSql = "select * from tbl_img where img_uuid = ?";
	TableRow row = aa.db.queryRow("activity_mysql", queryimgSql, new Object[]{img_uuid});
	if(null != row){
		String imgPath  = row.getField("img_path", "");
		String imgname = imgPath.substring(imgPath.lastIndexOf("\\")+1);
		response.addHeader("Content-Disposition","attachment;fileName="+imgname);
		File img = new File(imgPath);
		FileInputStream in = new FileInputStream(img);
		byte data[] = new byte[in.available()];
		in.read(data); // 读数据
		in.close();
		response.setContentType("image/*"); // 设置返回的文件类型
		OutputStream os = response.getOutputStream(); // 得到向客户端输出二进制数据的对象
		os.write(data); // 输出数据
		os.close();
		out.clear(); 
		out = pageContext.pushBody(); 
	}
%>