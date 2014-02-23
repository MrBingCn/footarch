<%@ page language="java" pageEncoding="utf-8"%>
<jsp:directive.page import="org.apache.commons.logging.impl.LogFactoryImpl"/>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%LogFactoryImpl.getLog("").error(request.getAttribute("exceptionStack")); %>
<html>
 <head>
    <title>异常信息</title>
 </head>
 
 <body>
 <h2>
 出现异常啦
 </h2>
 <hr/>
   <h3 style="color:red">
   <!-- 获得异常对象 -->
    <s:property value="exception.message"/>
    </h3>
    <br/>
    <!-- 异常堆栈信息 -->
    <s:property value="exceptionStack"/>
</html>