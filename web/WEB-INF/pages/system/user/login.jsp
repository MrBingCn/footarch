<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>User Login</title>

<%--@include file="/WEB-INF/pages/common/head.jsp" --%>


<%@include file="/WEB-INF/pages/common/head_easy_ui.jsp" %>


<script type="text/javascript">

function login() {
    ajax(
        "<%=root %>/system/user_login.action", 
        $("#eForm").serialize(),
        function(data, textStatus){
            //alert(data.message) ;
            if (data.code == "0") {
            	//window.location="<%=root %>/system/user_changePassword.action" ;
            	window.location = "<%=root %>/biz/document_grid.action" ;
            	//window.location="<%=root %>/system/user_grid.action" ;
            }
        }
    );
}



window.onload=function() {
   login();
};

</script>
</head>
<body topmargin="0" leftmargin="0">

<table width="100%" align="center">

  <tr>
    <td colspan="2">用户登录</td>
    <td><hr/></td>
  </tr>
  
  
  <tr>
    <td colspan="3">            
      <form action="<%=root %>/system/user_save.action" method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="user.id" id="user.id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="30%">
            <table cellspacing="0" cellpadding="0" width="100%">
              <tr>
                <td>login_id:</td>
                <td><input type="text" name="user.login_id" value="admin"/></td>
              </tr>
              <tr>
                <td>password:</td>
                <td><input type="password" name="user.password_" value="admin"/></td>
              </tr>
              <tr>
                <td>Language:</td>
                <td><input type="text" name="language" value="!en"/></td>
              </tr>
            </table> 
          </td>
        </tr>
      </table>
      </form>
    </td>
  </tr>
  
  <tr>
    <td colspan="3" align="center">
      <button onclick="login()">登录</button>
      <!-- 
      <input type="reset"/>
       -->
    </td>
  </tr>
</table>


</body>
</html>