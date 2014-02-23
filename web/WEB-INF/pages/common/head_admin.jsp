<%@page import="com.globalwave.common.cache.CodeHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>

<%@include file="/WEB-INF/pages/common/head_lib.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=root%>/plugin/multiselect/css/jquery.multiselect.css">
<script type="text/javascript" src="<%=root%>/plugin/multiselect/js/jquery.multiselect.<%=js_min %>js"></script>
<script type="text/javascript" src="<%=root%>/plugin/multiselect/i18n/jquery.multiselect.zh-cn.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>
var root = "<%=root%>" ;
var context = root ;
var contextPath = root ;
</script>
    
<!-- HTL css & js -->    
    <!--[if IE 6]>
    <script type="text/javascript" src="js/bb.js"></script>
    <script type="text/javascript">
        DD_belatedPNG.fix('.png_tra');
    </script>   
    <![endif]--> 
     
<link href="<%=root%>/css/main.css" rel="stylesheet" type="text/css" /> 

