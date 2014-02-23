<%@page import="com.globalwave.system.entity.SessionUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="header">
  <h1><%=i18n.html("CompanyName") %></h1>
  <div style="height: 32px;">
    <span style="display: inline-block;vertical-align: top;" id="userInfo_area">
	    <span id="userName"><%=(sUser == null)?"":sUser.getUser().getName_cn()%></span><%=i18n.text(", welcome!", "，欢迎登录") %>
	    <a href="javascript:logout()" id="btnLogout"><%=i18n.text("Logout", "退出") %></a>
	    <a href="javascript:changePassword()"><%=i18n.text("Change Password", "修改密码") %></a>
    </span>
  </div>
</div>

<script type="text/javascript">
function changePassword() {
    load("changePasswordDiv", "<%=root%>/system/user_changePassword.action", {}, function (responseText, textStatus, XMLHttpRequest) {
        changePasswordWin.show() ;
    })  ;
}
</script>