<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
    <%--request.setAttribute("_noDictLib", Boolean.TRUE); --%>
	<%@include file="/WEB-INF/pages/common/head_easy.jsp" %>

	<title><%=i18n.html("CompanyName") %></title>
	<meta name="description" content="宁波华联通国际物流有限公司" />
	<meta name="keywords" content="宁波华联通国际物流有限公司" />
	<meta name="viewport" content="width=960" />
	<meta name="robots" content="all" />
</head>
<body class="body_login">
	<div class="login_form">
    <div class="login_form" id="login_page">
        <div class="login_form_cont">
            <form method="post" id="loginForm" name="loginForm">
                <div>
	                <p style="display: inline-block;">
	                  <label for="user.password_"><%=i18n.text("Language", "语言")%></label>
	                  <!-- 
	                  <select id="language" name="language"></select>
	                   -->
	                  <input type="hidden" name="IS_LOCAL_STORAGE_SUPPORT"  id="IS_LOCAL_STORAGE_SUPPORT" value="true" />
	                </p>
	                <div id="language_radios" style="display:inline-block;vertical-align: top;padding-top: 5px;"></div>
                </div>
                <p>
                  <label for="user.login_id"><%=i18n.text("User", "用户")%></label>
                  <input type="text" name="user.login_id" id="user.login_id"  value="" required="required" label="<%=i18n.text("User", "用户")%>"/>
                  <span>缺少用户名</span>
                </p>
                <p>
                  <label for="user.password_"><%=i18n.text("Password", "密码")%></label>
                  <input type="password" name="user.password_" id="user.password_"  value="" required="required" label="<%=i18n.text("Password", "密码")%>"/>
                  <span>缺少密码</span>
                </p>
                <p style="padding-left: 60px;">
                  <button type="button" class="btn_login" id="btnLogin" onclick="login();"><%=i18n.text("Login", "登录")%></button>
                </p>
                <p id="tip" style="color: red;"></p>
            </form>
        </div>
        <div class="login_form_bg png_tra">-</div>
    </div>
		<div class="login_form_bg png_tra">-</div>
	</div>
	
	<div class="footer">
		<h3><%=i18n.text("H&amp;T", "华联通")%></h3>
		<div class="footer_line png_tra">-</div>
		<p><%=i18n.html("CompanyName") %></p>
	</div>

	<script type="text/javascript">
    function login() {
        if (!validateAll(["user.login_id", "user.password_"])) {
        	return ;
        } 
        ajax(
                "<%=root %>/system/user_login.action", 
                $("#loginForm").serialize(),
                function(data, textStatus){
                    if (data.code == "0") {
                        window.location = "<%=root %>/index.jsp" ;
                    }
                    else {
                        alert(data.message) ;
                        $('#user\\.login_id').focus();
                        $('#user\\.login_id').select();
                    }
                },
                false
            );
    }
    
    $(function () {    	
    	fillRadios({
    		id:"language", 
    		data:[{PK_ID:"zh", name_:"中文"}, {PK_ID:"en", name_:"English"}], 
    		value:"<%=locale.getLanguage()%>"}) ;
    	
    	$('#language_zh, #language_en').bind('click', function (e) {
            window.location = "./logon.jsp?language=" + $(this).val() ;
        });
    	
        $('#user\\.login_id').bind('keydown', function (e) {
            if (e.which == 13) {
                $("#user\\.password_").focus() ;
                $("#user\\.password_").select() ;
            }
        });
        $('#user\\.password_').bind('keydown', function (e) {
            if (e.which == 13) {
            	login() ;
            }
        });

        $('#user\\.login_id').focus();
        
        $("#IS_LOCAL_STORAGE_SUPPORT").attr("disabled", !g$LS.isEnabled()) ;
        
        if (!g$LS.isEnabled()) {
        	$("#tip").text("你的浏览器不支持本地缓存，建议使用更高版本的浏览器（如：chrome26+、IE8+)，\n以达到更好的体验效果！") ;
        }
    }) ;
	</script>
	
</body>
</html>
