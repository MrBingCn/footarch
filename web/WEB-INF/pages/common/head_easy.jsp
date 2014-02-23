<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.globalwave.system.entity.SessionUser"%>
<%@page import="com.globalwave.common.message.I18N"%>

<%@ taglib prefix="s" uri="/struts-tags"%>

<%@include file="/WEB-INF/pages/common/head_lib.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>
var root = "<%=root%>" ;
var context = root ;
var contextPath = root ;
</script>

<%
I18N i18N = new I18N();
%>

<!-- HTL css & js -->    
    <!--[if IE 6]>
    <script type="text/javascript" src="<%=root%>/js/bb.js"></script>
    <script type="text/javascript">
        DD_belatedPNG.fix('.png_tra');
    </script>   
    <![endif]--> 
    <script type="text/javascript" src="<%=root%>/js/t.js"></script>
    <link href="<%=root%>/css/style.<%=i18n.getLang()%>.css" rel="stylesheet" type="text/css" />
     

