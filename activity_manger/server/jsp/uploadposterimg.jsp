<%-- ExMobi JSP文件，注释和取消快捷键统一为Ctrl+/ 多行注释为Ctrl+Shift+/ --%>
<%@ page language="java" import="java.util.*"
 contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%@ include file="/client/adapt_extend.jsp"%>
<% 
	JSONObject outJson = new JSONObject();
	
	//活动海报
	String posterImgPathStr = aa.req.getAttachAddr("posters_img");

	String posterImgName = aa.req.getAttachName("posters_img");
	String imgSurfix = posterImgName.substring(posterImgName.lastIndexOf("."), posterImgName.length());
	
	File tempPosterImg = new File(posterImgPathStr);
	//图片最终存储名字为“uuid.后缀名”
	File realPosterImgFile = new File("C:\\var\\activityimg\\"+UUID.randomUUID().toString().replaceAll("-","")+imgSurfix);
		
	java.nio.channels.FileChannel inputChannel =  null;
	java.nio.channels.FileChannel outputChannel = null;
	try{
		realPosterImgFile.createNewFile();//创建空图片
			
		inputChannel =  new FileInputStream(tempPosterImg).getChannel(); 
		outputChannel = new FileOutputStream(realPosterImgFile).getChannel(); 
		//把图片内容拷贝至存储目录里的空图片
		outputChannel.transferFrom(inputChannel, 0, inputChannel.size());
		
		String insertSql = "insert into tbl_img value (?,?)";
		String img_uuid = UUID.randomUUID().toString().replaceAll("-","");
		//图片信息入库
		int ret = aa.db.update("activity_mysql", insertSql, new Object[]{img_uuid,realPosterImgFile.getPath()});
		if(ret > 0){
			outJson.put("result", "success");
			outJson.put("img_uuid", img_uuid);
		}else{
			outJson.put("result", "fail");
			outJson.put("msg", "入库失败，请联系管理员");
		}
	}catch(Exception e){
		outJson.put("result", "fail");
		outJson.put("msg", "上传图片失败，请联系管理员");
	}finally{
		inputChannel.close();
		outputChannel.close();
	}
	
	out.print(outJson.toString());
%>