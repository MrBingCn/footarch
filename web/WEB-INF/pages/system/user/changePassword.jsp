<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String root = request.getContextPath() ;
%>
<script type="text/javascript">
var changePasswordWin = {
    windowDiv$:$("#changePasswordWinDiv"),
    eForm$:null,

	show:function () {
        eForm$ = $("#passwordForm", this.windowDiv$) ;
        eForm$[0].reset();
        eForm$.validator();
	    
		this.windowDiv$.dialog({
	        title: "修改密码",
	        autoOpen: true,
	        width: 350,
	        height: 220,
	        modal: true,
	        resizable: true,
	        autoResize: true,
	        overlay: {
	            opacity: 0.5,
	            background: "black"
	        },
	        resizable:true,
	        beforeClose: function( event, ui ) {
	        	eForm$[0].resetForm() ;
	        }
	    });
	},
	
	changePassword:function () {

	    if(!eForm$[0].checkValidity()) {
	        alert("请正确填写表单！") ;
	        eForm$[0].setErrorFocus() ;
	        return ;
	    }
	    
		var pwd$ = $("#user\\.password_", this.windowDiv$) ;
		var pwdComfirm$ = $("#user\\.password_confirm",this.windowDiv$) ;
        
	    if(pwd$.val() != pwdComfirm$.val()) {
	        alert("新密码与确认密码不一致，请重新输入") ;
	        pwd$.val("") ;
	        pwdComfirm$.val("") ;
	        pwd$.focus();
	        return ;
	    }

	    ajax(
	        "<%=root %>/system/user_changePassword.action", 
	        eForm$.serialize(),
	        function(data, textStatus){
                if (data.code == "0") {
                	changePasswordWin.windowDiv$.dialog( "close" );
	            }
	        }
	    );
	}
		
};
</script>

<div style="display: none;" id="changePasswordWinDiv">
<table width="100%" align="center">
  <tr>
    <td>            
      <form method="post" id="passwordForm" name="passwordForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="user.id" id="user.id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="30%">
            <table cellspacing="0" cellpadding="0" width="100%">
              <tr>
                <td class="item_label">旧密码：</td>
                <td class="item_input"><input type="password" name="user.old_password" required="required"/></td>
              </tr>
              <tr>
                <td class="item_label">新密码：</td>
                <td class="item_input"><input type="password" name="user.password_" id="user.password_" required="required"/></td>
              </tr>
              <tr>
                <td class="item_label">确认密码：</td>
                <td class="item_input"><input type="password" name="user.password_confirm" id="user.password_confirm" required="required"/></td>
              </tr>
            </table> 
          </td>
        </tr>
      </table>
      </form>
    </td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td align="center">
      <button onclick="changePasswordWin.changePassword()">确定</button>
    </td>
  </tr>
</table>
</div>

