<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.globalwave.util.GsonUtil"%>
<%@page import="com.globalwave.system.entity.SessionUser"%>

<!DOCTYPE html>
<html>
<head>
	<%//request.setAttribute("_noDictLib", Boolean.TRUE); %>
	<%@include file="/WEB-INF/pages/common/head_easy.jsp" %>

	<title><%=i18n.html("CompanyName") %></title>
	<meta name="description" content="<%=i18n.html("CompanyName") %>" />
	<meta name="keywords" content="<%=i18n.html("CompanyName") %>" />
	<meta name="viewport" content="width=960" />
	<meta name="robots" content="all" />
	
</head>

<%
SessionUser sUser = (SessionUser)session.getAttribute(SessionUser.SESSION_PK) ;
boolean isHltUser = true;//sUser.isHltUser();
%>

<body class="body_login">

    <%@include file="/WEB-INF/pages/share_header.jsp" %>
	<div style="height:20px"></div>
	<div class="main">
		<div class="main_icon" style="height: 320px;">
		    <% if (sUser.hasPrivilege((short)1010)) { %>
			<a href="<%=root %>/biz/order_view.action" class="i_xj">询价<span class="png_tra" id="inquire_tatal">0</span></a>
			<a href="<%=root %>/biz/order_view.action?actionType=1" class="i_zjxd">直接下单</a>
			<%}%>
			
			<% if (sUser.hasPrivilege((short)1070)) { %>
			<a href="<%=root %>/biz/order_list.action" class="i_my">我的订单<span class="png_tra" id="order_tatal">0</span></a>
			<%}
            if (isHltUser){ 
			if (sUser.hasPrivilege((short)3000)) { %>
            <a href="<%=root %>/biz/arAp_view.action" class="i_arap">应收应付</a>
			<%}%>
			<% if (sUser.hasPrivilege((short)2040)) { %>
			<a href="<%=root %>/report.jsp" class="i_report">报表</a>
			<%}%>
            <% if (sUser.hasPrivilege((short)2050) 
            		|| sUser.hasPrivilege((short)2060) 
            		|| sUser.hasPrivilege((short)2070) 
            		|| sUser.hasPrivilege((short)2072) 
                    || sUser.hasPrivilege((short)2073) 
                    || sUser.hasPrivilege((short)2140)
            		) { %>
            <a href="<%=root %>/system.jsp" class="i_system">系统设置</a>
            <%}%>
			<%}%>
			
			<%-- if (sUser.hasPrivilege((short)2210)) { --%>
            <a href="<%=root %>/document.jsp" class="i_document">文件管理</a>
            <%--}--%>
			
		</div>
	</div>
	
	<div class="footer" >
		<div class="footer_line png_tra">-</div>
		<p style="height: 25px;"><%=i18n.html("CompanyName") %></p>
		

        <p style="height: 20px;" id="links1"></p>
        <p style="height: 20px;" id="links2"></p>
        <p style="height: 20px;" id="links3"></p>

	</div>

<script type="text/javascript">
$(function () {
	/*
    ajax(
        root+'/biz/order_getOrderTotal.action', 
        '',
        function(data, textStatus){
            if (data['inquiry-total'] != undefined) {
                document.getElementById('inquire_tatal').innerHTML = data['inquiry-total'];
            }
            if (data['order-total'] != undefined) {
                document.getElementById('order_tatal').innerHTML = data['order-total'];
            }
            if (data['doc-total'] != undefined) {
                document.getElementById('doc_tatal').innerHTML = data['doc-total'];
            }
            if (data['fee-total'] != undefined) {
                document.getElementById('fee_tatal').innerHTML = data['fee-total'];
            }
        }
    );
	*/

    var linkTemplate = "<img width='3' height='3' style='background-color: #BDE0F4'>&nbsp;<a href='{$T.ename}' target='_blank' style='color: #BDE0F4'>{$T.name}</a>&nbsp;&nbsp;&nbsp;" ;
    $(g$dict["361"]).each(function (i, elem) {
        $("#links1").append(parse(linkTemplate, elem)) ;
    }) ;
    $(g$dict["362"]).each(function (i, elem) {
        $("#links2").append(parse(linkTemplate, elem)) ;
    }) ;
    $(g$dict["363"]).each(function (i, elem) {
        $("#links3").append(parse(linkTemplate, elem)) ;
    }) ;
});

</script>

</body>
</html>
