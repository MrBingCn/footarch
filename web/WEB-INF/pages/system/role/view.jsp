<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/system/role_list.action" ,
    create_url:root + "/system/role_create.action" ,
    update_url:root + "/system/role_update.action" ,
    get_url:root + "/system/role_get.action" ,
    delete_url:root + "/system/role_delete.action" ,
    entityName:"role",
    
    init:function (){
        this.pageIndex = E("roleSO.pageIndex") ;
        fillOptions({id:"role.record_status", dictName:"CM.status", firstLabel:"请选择..."}) ;//  改为字典取值
        //E$('editDiv').hide() ;

        
        //$("thead", $newTable).css("display", "none") ;
        this.initDataGrid("roleTB", {height:"400px"}) ;
        this.initDataGrid("privilegeTB", {height:"330px"}) ;
        
        //E$("role.expired_date").datepicker({dateFormat: "yy-mm-dd" });
        this.convertors = {
                record_status_name:["record_status",function (_v) {
                    return dVal("CM.status", "name_", {PK_ID:_v});
                }]
        } ;
        
        E$("sForm").validator();
        
        this.first();
    },
    //$(document).keydown(function(){if(event.keyCode==13){event.keyCode='9';}})  
    
    get:function(id) {
        ajax(
            this.get_url + "?id="+id, 
            null,
            function(data, textStatus){
                
                formDeserialize("eForm", data, {privilege_ids:true}) ;//以免处理template中的check-box value值

                $(data.privileges).each(function(i, domEle){
                    domEle['checked'] = (domEle['role_id'] == 0 || domEle['role_id'] == null)? "":"checked" ;
                });
                
                viewJs.addRows("privilegeTB", data.privileges) ;
                E$("eForm").validator(/*{
                        position: 'top left',
                        offset: [-12, 0],
                        message: '<div><em/></div>' // em element is the arrow
                        }*/);//为了初始化check box
                //viewJs.initFormGrid("eForm") ;
                //E("eForm").setFirstFocus() ;
            }
        );
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="roleSO.pageIndex" id="roleSO.pageIndex" value="1" type="hidden" />
        <input name="roleSO.pageSize" id="roleSO.pageSize" value="10" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td style="width:60px;" class="label">名称：</td>
           <td style="width:100px;">
             <input name="roleSO.name_" value="" type="text" />
           </td>
           <td style="width:60px;" class="label">编码：</td>
           <td style="width:100px;">
             <input name="roleSO.code_" value="" type="text" />
           </td>
           <td style="width:100px;">
             <button onclick="viewJs.first();" accesskey="Q" >查找(Q)</button>
           </td>
           <td>
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="roleTB" title="角色列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="30%">名称</th>
            <th width="15%">编码</th>
            <th width="35%">描述</th>
            <th width="15%">状态</th>
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
            <td>{desc_}</td>
            <td>{record_status_name}</td>
          </tr>
        </tbody>
    </table>
    
  </div>
    
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="role.id" id="role.id"/>
      <input type="hidden" name="role.version_id" id="role.version_id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td width="45%">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td class="label">名字：</td>
                <td><input type="text" name="role.name_" required="required" maxlength="50"/></td>
              </tr>
              <tr>
                <td width="25%" class="label">编码：</td>
                <td><input type="text" name="role.code_" required="required" maxlength="8"/></td>
              </tr>
              <tr>
                <td class="label">描述：</td>
                <td><input type="text" name="role.desc_" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">状态：</td>
                <td>
                  <select name="role.record_status" id="role.record_status" required="required">
                  </select>
                </td>
              </tr>
            </table> 
          </td>
          <td width="2%">
          </td>
          <td valign="top">
              <h3>权限列表</h3>
              <table id="privilegeTB" class="datagrid">
                <thead>
                  <tr>
                    <th width="5%"></th>
                    <th width="60%">名称</th>
                    <th width="35%">描述</th>
                  </tr>
                </thead>
                <tbody id="listBody" >
                </tbody>
                 
                <tbody id="templateBody" style="display:none">
                  <tr>
                    <td>
                      <input type="checkbox" name="privilege_ids" value="{id}" {checked} onfocus="$(this).addClass('ui-state-focus');" onblur="$(this).removeClass('ui-state-focus');" />
                    </td>
                    <td style="text-align: left;">{name_}</td>
                    <td>{desc_}</td>
                  </tr>
                </tbody>
              </table>
          </td>
        </tr>
        <tr height="20"><td colspan="2"></td></tr>
      </table>
    </form>

    <table cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td colspan="2" align="center" class="tx_center">
            <button onclick="viewJs.save()" accesskey="S" tabindex="-1">保存(S)</button>
          </td>
        </tr>
    </table>
    
    
    
  </div>
</div>
