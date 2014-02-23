<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
String sub_id=request.getParameter("sub_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/system/config_items.action" ,
    create_url:root + "/system/config_create.action" ,
    update_url:root + "/system/config_update.action" ,
    get_url:root + "/system/config_item.action" ,
    delete_url:root + "/system/config_delete.action" ,
    entityName:"confItem",
    
    init:function (){
        this.initSelect() ;
        this.pageIndex = E("confItemSO.pageIndex") ;
        
        //fillOptions({id:"confItem.status_", dictName:"CM.status", firstLabel:"请选择..."}) ;// 改为字典取值
        //fillOptions({id:"confItemSO.status_", dictName:"CM.status", firstLabel:"全部"}) ;
        
        //fillOptions({id:"confItem.domain_", dictName:"sys.dict.configable_list"}) ;
        //fillOptions({id:"confItemSO.domain_", dictName:"sys.dict.configable_list"}) ;
        
        this.initDataGrid("confItemTB", {height:"400px"}) ;
        
        //E$("dict.expired_date").datepicker({dateFormat: "yy-mm-dd" });
        E$("eForm").validator();
        E$("sForm").validator();
        E("sForm").setFirstFocus();
        
        this.convertors = {/*
        		status_:function (_v) {
        			return ["record_status_name",dVal("CM.status", "name_", {PK_ID:_v})];
        		}*/
        } ;
        this.eFormInitData = {sub_id:<%=sub_id %>} ;
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="confItemSO.pageIndex" id="confItemSO.pageIndex" value="1" type="hidden" />
        <input name="confItemSO.pageSize" id="confItemSO.pageSize" value="10" type="hidden" />
        <input name="confItemSO.sub_id" value="<%=sub_id %>" type="hidden" />
        
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td style="width:60px;" class="label">编码：</td>
           <td style="width:100px;">
             <input name="confItemSO.code" value="" type="text" />
           </td>
           <td style="width:80px;" class="label">中文名称：</td>
           <td style="width:100px;">
             <input name="confItemSO.name" value="" type="text" />
           </td>
           
           <!-- 
           <td width="6%" class="label">英文名称：</td>
           <td width="15%">
             <input name="confItemSO.ename" value="" type="text" />
           </td>
           <td width="8%" class="label">状态：</td>
           <td width="10%">
             <select name="confItemSO.status_" id="confItemSO.status_">
             </select>
           </td>
            -->
           <td style="width:100px;">
             <button onclick="viewJs.first();" accesskey="Q" >查 找(Q)</button>
           </td>
           <td>
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="confItemTB" title="配置项列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="15%">编码</th>
            <th width="30%">中文名称</th>
            <th width="35%">英文名称</th>
          </tr>
        </thead>
        
        <tbody id="listBody" >
        </tbody>
         
        <tbody id="templateBody" style="display:none;visibility: false;" disabled="true">
          <tr id="{id}" ondblclick="viewJs.toEdit($('#ids', this)[0]);">
            <td>
              <input type="checkbox" name="ids" id="ids" value="{id}" />
            </td>
            <td>{code}</td>
            <td>{name}</td>
            <td>{ename}</td>
          </tr>
        </tbody>
    </table>
    
  </div>
    
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="confItem.id" id="confItem.id"/>
      <input type="hidden" name="confItem.version_id" id="confItem.version_id"/>
      <input type="hidden" name="confItem.sub_id" id="confItem.sub_id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td valign="top" width="15%">
          </td>
          <td width="45%">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td width="25%" class="label">编码：</td>
                <td><input type="text" name="confItem.code" required="required"/></td>
              </tr>
              <tr>
                <td class="label">中文名称：</td>
                <td><input type="text" name="confItem.name" required="required" maxlength="100"/></td>
              </tr>
              <tr>
                <td class="label">英文名称：</td>
                <td><input type="text" name="confItem.ename" maxlength="100"/></td>
              </tr>
              <tr>
                <td class="label">次序：</td>
                <td><input type="integer" name="confItem.sequence" maxlength="3"/></td>
              </tr>
            </table> 
          </td>
          <td width="15%" valign="top">
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
