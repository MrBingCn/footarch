<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
	view:document.getElementById("view_<%=view_id%>"), 
	id:<%=view_id%>,
    list_url:root+"/system/template_list.action" ,
    create_url:root + "/system/template_create.action" ,
    update_url:root + "/system/template_update.action" ,
    get_url:root + "/system/template_get.action" ,
    delete_url:root + "/system/template_delete.action" ,
    entityName:"template",
	
	init:function (){
		this.pageIndex=E("templateSO.pageIndex");
		//fillOptions({id:"templateSO.status_", dictName:"CM.status", firstLabel:"请选择..."}) ;//  改为字典取值
        
        this.initDataGrid("templateTB", {height:"400px"}) ;
        
        //E$("template.expired_date").datepicker({dateFormat: "yy-mm-dd" });

        E$("sForm").validator();
        E$("eForm").validator();
        //this.id = 1 ;
        //this.toPage("e") ;
        E$("searchLi").hide() ;
        E$("addLi").hide() ;
        E$("deleteLi").hide() ;
        
        this.toEdit({value:1}) ;
    },
    save:function (fun) {
        if(!E("eForm").checkValidity()) {
            alert("请正确填写表单！") ;
            E("eForm").setErrorFocus() ;
            return ;
        }
        
        if (!this.checkEditForm(E("eForm"))) {
            return ;
        }
        
        if (!window.confirm("是否确定要保存？")) {
            return ;
        }

        var _url = V(this.entityName+".id")==""?this.create_url:this.update_url ;

        ajax(
            _url, 
            E$("eForm").serialize(),
            function(data, textStatus){
            }
        );
    }
}) ;


</script>
<div id="view_<%=view_id%>" style="height: 480px;">
  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
	  
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="templateSO.pageIndex" id="templateSO.pageIndex" value="1" type="hidden" />
        <input name="templateSO.pageSize" id="templateSO.pageSize" value="10" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td width="15%" class="label">名称：</td>
           <td width="15%">
             <input name="templateSO.name_" value="" type="text" />
           </td>
           <td width="15%" class="label">编码：</td>
           <td width="15%">
             <input name="templateSO.code_" value="" type="text" />
           </td>
           <td width="10%">
             <button onclick="viewJs.first();" accesskey="Q" >查 找(Q)</button>
           </td>
           <td width="60%">
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="templateTB" title="模板列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="35%">名称</th>
            <th width="20%">编码</th>
            <th width="20%">版本</th>
            <th width="20%">状态</th>
          </tr>
        </thead>
        
        <tbody id="listBody" >
        </tbody>
         
        <tbody id="templateBody" style="display:none;visibility: false;" disabled="true">
          <tr id="{id}" ondblclick="viewJs.toEdit($('#ids', this)[0]);">
            <td>
              <input type="checkbox" name="ids" id="ids" value="{id}" />
            </td>
            <td>{name_}</td>
            <td>{code_}</td>
            <td>{version_}</td>
            <td>{record_status_name}</td>
          </tr>
        </tbody>
	</table>
	
  </div>
	
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="template.id" id="template.id"/>
      <input type="hidden" name="template.version_id" id="template.version_id"/>
      <input type="hidden" name="template.record_status" />
      <input type="hidden" name="template.code_" />
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td>
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td style="width:50px;" class="label">标题：</td>
                <td><input type="text" name="template.title_" required="required" maxlength="50"/></td>
              </tr>
              <tr>
                <td class="label">内容：</td>
                <td><textarea name="template.content_" id="template.content_"  style="width: 100%;height: 350px;" ></textarea></td>
              </tr>
            </table> 
          </td>
        <tr height="20"><td></td></tr>
      </table>
    </form>

    <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr>
          <td colspan="2" align="center" class="tx_center">
            <button onclick="viewJs.save()" accesskey="S" tabindex="-1">保存(S)</button>
          </td>
        </tr>
    </table>
    
    
    
  </div>
</div>
