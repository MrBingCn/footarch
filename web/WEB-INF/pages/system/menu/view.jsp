<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/system/menu_list.action" ,
    create_url:root + "/system/menu_create.action" ,
    update_url:root + "/system/menu_update.action" ,
    get_url:root + "/system/menu_get.action" ,
    delete_url:root + "/system/menu_delete.action" ,
    entityName:"menu",
    proIdName:"pro_menu_id", 
    
    init:function (){
        this.pageIndex = E("menuSO.pageIndex") ;
        
        fillOptions({id:"menuSO.record_status", dictName:"CM.status", firstLabel:"全部"}) ;
        fillOptions({id:"menu.record_status", dictName:"CM.status", firstLabel:"请选择..."}) ;// 改为字典取值
        fillOptions({id:"menu.pid", dictName:"Privilege", firstLabel:"请选择..."}) ;
        
        
        this.initDataGrid("menuTB", {height:"400px"}) ;
        
        //E$("menu.expired_date").datepicker({dateFormat: "yy-mm-dd" });
        E$("eForm").validator();
        E$("sForm").validator();
        E("sForm").setFirstFocus();
        
        this.convertors = {
        		record_status_name:["record_status",function (_v) {
        			return dVal("CM.status", "name_", {PK_ID:_v});
        		}],
        		level_blank:["level_",function(_v) {
        			var ret = "" ;
        		    for (var i = 1 ; i < _v ; i ++) {
        		    	ret += "&nbsp;&nbsp;&nbsp;&nbsp;" ;
        		    }
        			return ret ;
        		}]
        } ;
        
        this.first();
    },
    
    get:function(id) {
    	var optionParams = {
            id:"menu.pro_menu_id", 
            dictName:"ProMenu", 
            firstLabel:"[顶层--一级菜单]", 
            textProperty:"label", 
            titleProperty:"label"
        } ;
        
        if (id == -1) {
            fillOptions(optionParams) ;
            formDeserialize("eForm", this.eFormInitData, {}) ;// reset form;
            return ;
        }
        ajax(
            this.get_url + "?id="+id, 
            null,
            function(data, textStatus){
            	if (data.pro_menu_id != null && data.pro_menu_id > 0) {
            		delete optionParams["firstLabel"] ;
            	}
                var filterValues = {} ;
                filterValues[data.pro_menu_id] = true ;
            	optionParams["filter"] = filterValues ;
                fillOptions(optionParams) ;
                formDeserialize("eForm", data, {}) ;
            }
        );
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <jsp:include page="/WEB-INF/pages/frame/navigation.jsp">
    <jsp:param name="hidePageSize" value="yes"/>
  </jsp:include>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="menuSO.pageIndex" id="menuSO.pageIndex" value="1" type="hidden" />
        <input name="menuSO.pageSize" id="pageSize" value="100" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td style="width:80px;" class="label">菜单名称：</td>
           <td style="width:100px;">
             <input name="menuSO.label" value="" type="text" />
           </td>
           <td style="width:60px;" class="label">状态：</td>
           <td style="width:100px;">
             <select name="menuSO.record_status" id="menuSO.record_status">
             </select>
           </td>
           <td style="width:100px;">
             <button onclick="viewJs.first();" accesskey="Q" >查 找(Q)</button>
           </td>
           <td>
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="menuTB" title="菜单列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="30%">菜单名称</th>
            <th width="50%">地址</th>
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
            <td style="text-align:left;">{level_blank}{label}</td>
            <td style="text-align:left;">{url}</td>
            <td>{record_status_name}</td>
          </tr>
        </tbody>
    </table>
    
  </div>
    
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="menu.id" id="menu.id"/>
      <input type="hidden" name="menu.level_" id="menu.level_"/>
      <input type="hidden" name="menu.version_id" id="menu.version_id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td valign="top" width="15%">
          </td>
          <td width="45%">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td width="25%" class="label">父菜单：</td>
                <td>
	             <select name="menu.pro_menu_id" id="menu.pro_menu_id" >
	             </select>
                </td>
              </tr>
              <tr>
                <td class="label">菜单名称：</td>
                <td><input type="text" name="menu.label" id="menu.label" required="required"  maxlength="50"/></td>
              </tr>
              <tr>
                <td class="label">地址：</td>
                <td><input type="text" name="menu.url" maxlength="250" required="required"/></td>
              </tr>
              <tr>
                <td class="label">访问权限：</td>
                <td>
                  <select name="menu.pid" id="menu.pid" required="required">
                  </select>
                </td>
              </tr>
              <tr>
                <td class="label">次序：</td>
                <td><input type="integer" name="menu.order_" required="required" maxlength="2"/></td>
              </tr>
              <tr>
                <td class="label">状态：</td>
                <td>
                  <select name="menu.record_status" id="menu.record_status" required="required">
                  </select>
                </td>
              </tr>
            </table> 
          </td>
          <td valign="top" width="25%">
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
