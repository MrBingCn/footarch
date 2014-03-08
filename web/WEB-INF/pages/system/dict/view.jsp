<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
String domain=request.getParameter("domain_");
%>


<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/system/dict_list.action" ,
    create_url:root + "/system/dict_create.action" ,
    update_url:root + "/system/dict_update.action" ,
    get_url:root + "/system/dict_get.action" ,
    delete_url:root + "/system/dict_delete.action" ,
    entityName:"dict",
    
    init:function (){
        //this.initSelect() ;
        this.pageIndex = E("dictSO.pageIndex") ;
        
        fillOptions({id:"dict.status_", dictName:"CM.status", firstLabel:"请选择..."}) ;// 改为字典取值
        fillOptions({id:"dictSO.status_", dictName:"CM.status", firstLabel:"全部"}) ;
        
        <%if(domain == null){%>
        fillOptions({id:"dict.domain_", dictName:"sys.dict.configable_list"}) ;
        fillOptions({id:"dictSO.domain_", dictName:"sys.dict.configable_list"}) ;
        <%}%>
        
        this.initDataGrid("dictTB", {height:"400px"}) ;
        
        //E$("dict.expired_date").datepicker({dateFormat: "yy-mm-dd" });
        E$("eForm").validator();
        E$("sForm").validator();
        E("sForm").setFirstFocus();
        
        this.convertors = {
        		record_status_name:["status_",function (_v) {
        			return dVal("CM.status", "name_", {PK_ID:_v});
        		}]
        } ;
    }
    
    <%if(domain != null){%>
    ,checkEditForm:function(_form) {    	
    	E$("dict.domain_").val("<%=domain%>");
        return true ;
    }
    <%} %>
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="dictSO.pageIndex" id="dictSO.pageIndex" value="1" type="hidden" />
        <input name="dictSO.pageSize" id="dictSO.pageSize" value="10" type="hidden" />
        <%if(domain != null){%>
        <input type="hidden" name="dictSO.domain_eq" value="<%=domain%>"/>
        <%} %>
        
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <%if(domain == null){%>
           <td width="6%" class="label">常用参数：</td>
           <td width="15%">
             <select name="dictSO.domain_" id="dictSO.domain_" onchange="setSelectValue(E('dict.domain_'), [this.value])">
             </select>
           </td>
           <%} %>
           <td width="6%" class="label">编码：</td>
           <td width="15%">
             <input name="dictSO.code_" value="" type="text" />
           </td>
           <td width="6%" class="label">名称：</td>
           <td width="15%">
             <input name="dictSO.name_" value="" type="text" />
           </td>
           <td width="8%" class="label">状态：</td>
           <td width="10%">
             <select name="dictSO.status_" id="dictSO.status_">
             </select>
           </td>
           <td width="10%">
             <button onclick="viewJs.first();" accesskey="Q" >查 找(Q)</button>
           </td>
           <td width="60%">
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="dictTB" title="组织列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="15%">编码</th>
            <th width="30%">名称</th>
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
            <td>{code_}</td>
            <td>{name_}</td>
            <td>{desc_}</td>
            <td>{record_status_name}</td>
          </tr>
        </tbody>
    </table>
    
  </div>
    
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="dict.id" id="dict.id"/>
      <input type="hidden" name="dict.version_id" id="dict.version_id"/>
      <%if(domain != null){%>
      <input type="hidden" name="dict.domain_" id="dict.domain_" value="<%=domain%>"/>
      <%} %>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td valign="top" width="25%">
          </td>
          <td width="45%">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <%if(domain == null){%>
              <tr>
                <td class="label">常用参数：</td>
                <td>
	             <select name="dict.domain_" id="dict.domain_" onchange="setSelectValue(E('dictSO.domain_'), [this.value])">
	             </select>
                </td>
              </tr>
              <%} %>
              <tr>
                <td width="25%" class="label">编码：</td>
                <td><input type="text" name="dict.code_" required="required" maxlength="50"/></td>
              </tr>
              <tr>
                <td class="label">名字：</td>
                <td><input type="text" name="dict.name_" required="required" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">描述：</td>
                <td><input type="text" name="dict.desc_" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">次序：</td>
                <td><input type="integer" name="dict.order_" maxlength="3"/></td>
              </tr>
              <tr>
                <td class="label">状态：</td>
                <td>
                  <select name="dict.status_" id="dict.status_" required="required">
                  </select>
                </td>
              </tr>
            </table> 
          </td>
          <td valign="top" width="30%">
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
