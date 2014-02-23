<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
	view:document.getElementById("view_<%=view_id%>"), 
	id:<%=view_id%>,
    update_url:root + "/system/user_loginForward.action" ,
    entityName:"user",
	
	init:function (){
        this.toPage("e") ;
        
    },
    save:function () {
    	
        if (!window.confirm("是否需要登录？")) {
            return ;
        }

        ajax(
        	this.update_url, 
            E$("eForm").serialize(),
            function(data, textStatus){
        		if (data.code == 0) {
                    window.location = "<%=request.getContextPath() %>/index.jsp" ;
        		}
            }
        );
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">
  <ul class="hor_nav" id="horNav">
    <li id="editLi"><span tag="e">编辑</span></li>
    

    <div  style="display: inline;" class="admin_act" id="pagination">
        <div class="admin_btns">
            
        </div>
        <div class="admin_pages">
            <label id="paginationInfo">总记录数为0条，当前为第1页，共0页&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <a href="javascript:viewJs.first();">首页</a>
            <a href="javascript:viewJs.preview();">上页</a>
            <a href="javascript:viewJs.next();">下页</a>
            <a href="javascript:viewJs.last();">末页</a>
        </div>
    </div>
  </ul>
	  
  <div id="listDiv">
  </div>
	
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="total" id="total"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td>
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid" id="formTable">
		        <tbody id="listBody" >
	              <tr>
	                <td>login_id:</td>
	                <td><input type="text" name="user.login_id" value=""/></td>
	              </tr>
	              <tr>
	                <td>password:</td>
	                <td><input type="password" name="user.password_" value=""/></td>
	              </tr>
                  <tr>
                    <td colspan="2"><button onclick="viewJs.save() ;">Login</button></td>
                  </tr>
		        </tbody>
		         
            </table> 
          </td>
        </tr>
        <tr height="20"><td></td></tr>
      </table>
    </form>
    
    
    
  </div>
</div>
