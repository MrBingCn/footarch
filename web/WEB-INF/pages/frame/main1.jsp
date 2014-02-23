<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>List of Dict</title>

    <%@include file="/WEB-INF/pages/common/head_easy.jsp" %>
    <script type="text/javascript">
        //hlt.user.checkLogin();
	    $(function() {
	        $("#login_body").hide() ;
	        $("#menu_body").hide() ;
	        $("#operation_body").show() ;
	
	    });
	    
        function show(domName) {
            $("#login_body").hide() ;
            $("#menu_body").hide() ;
            $("#operation_body").hide() ;
        	$(domName).show( "Blind");
        }
        

    </script>   
    <title><%=company_name %></title>
    <meta name="description" content="<%=company_name %>" />
    <meta name="keywords" content="<%=company_name %>" />
    <meta name="viewport" content="width=960" />
    <meta name="robots" content="all" />
</head>
<body class="body_login">
    <div class="header">
        <h1><%=company_name %></h1>
        <div>
            <span id="userName">x</span>，欢迎登录<a href="#" id="btnLogout">退出</a>
        </div>
        <script type="text/javascript">
            hlt.user.initLogout();
        </script>
    </div>
    
    <div style="width: 100%;height: 550px;">
    <div class="main" id="login_body">
      this is login body
      <button onclick="show('#menu_body')">#menu_body</button>
    </div>
    
    <div class="main" id="menu_body">
        <div class="main_icon">
            <a href="order.html" class="i_xj">询价</a>
            <!--<a href="#" class="i_order">订单</a>-->
            <a href="#" class="i_my">我的订单<span class="png_tra">18</span></a>
            <a href="javascript:show('#operation_body')" class="i_query">查询</a>
            <a href="#" class="i_report">报表<span class="png_tra">29</span></a>
            <a href="admin.html" class="i_system">系统设置</a>
        </div>
    </div>
    
    
    
    <div class="admin_main" id="operation_body">
      <%@include file="operation_body.jsp" %>
    </div>
    
    <div class="footer">
        <div class="footer_line png_tra">-</div>
        <p><%=company_name %></p>
    </div>

</body>
</html>
