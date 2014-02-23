<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/system/eventLog_list.action" ,
    create_url:root + "/system/eventLog_create.action" ,
    update_url:root + "/system/eventLog_update.action" ,
    get_url:root + "/system/eventLog_get.action" ,
    delete_url:root + "/system/eventLog_delete.action" ,
    entityName:"eventLog",
    
    init:function (){
        
        this.pageIndex = E("eventLogSO.pageIndex") ;
        //fillOptions({id:"eventLog.record_status", dictName:"CM.status", firstLabel:"请选择..."}) ;//  改为字典取值
        //E$('editDiv').hide() ;

        
        
        this.convertors = {
        		biz_data_html:["biz_data",function (_v) {
                    return _v.replaceAll("\"", "\'");
                }]
        } ;
        
        E$("sForm").validator();

        E$("addLi").hide();
        E$("editLi").hide();
        E$("deleteLi").hide();

        E$("created_from").datepicker({dateFormat: "yy-mm-dd" }) ;
        E$("created_to").datepicker({dateFormat: "yy-mm-dd" }) ;
        
        this.initDataGrid("eventLogTB", {height:400}) ;
        this.first();
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="eventLogSO.pageIndex" id="eventLogSO.pageIndex" value="1" type="hidden" />
        <input name="eventLogSO.pageSize" id="eventLogSO.pageSize" value="15" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td style="width: 80px;" class="label">开始时间：</td>
           <td style="width: 100px;">
             <input name="eventLogSO.created_from" id="created_from" value="" type="text" />
           </td>
           <td style="width: 80px;" class="label">结束时间：</td>
           <td style="width: 100px;">
             <input name="eventLogSO.created_to_closed"  id="created_to" value="" type="text" />
           </td>
           <td style="width: 120px;">
             <button onclick="viewJs.first();" accesskey="Q" >查 找(Q)</button>
           </td>
           <td>
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="eventLogTB" title="日志列表" class="datagrid" style="width: 1000px">
        <thead>
          <tr>
            <%--
            <th width="5%"><input type="checkbox" id="selectMe" onclick="viewJs.selectAll(this.checked)" /></th>
             --%>
            <th width="250px">日志类型</th>
            <th width="250px" title="操作明细">操作内容</th>
            <th width="250px">操作员</th>
            <th width="250px">操作时间</th>
          </tr>
        </thead>
        
        <tbody id="listBody" >
        </tbody>
         
        <tbody id="templateBody" style="display:none;visibility: false;" disabled="true">
          <tr id="{id}" ondblclick_no="viewJs.toEdit($('#ids', this)[0]);">
            <%--
            <td>
              <input type="checkbox" name="id" id="ids" value="{id}" />
            </td>
             --%>
            <td>{event_type_code}</td>
            <td title="{biz_data_html}" >{desc_}</td>
            <td>{user_name}</td>
            <td>{created_on}</td>
          </tr>
        </tbody>
    </table>
    
  </div>
  
  
  <div id="editDiv" style="display:none;">
            <%--
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="eventLog.id" id="eventLog.id"/>
      <input type="hidden" name="eventLog.version_id" id="eventLog.version_id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td>
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td class="label">名字：</td>
                <td><input type="text" name="eventLog.name_" required="required" maxlength="50"/></td>
              </tr>
              <tr>
                <td width="25%" class="label">编码：</td>
                <td><input type="text" name="eventLog.code_" required="required" maxlength="8"/></td>
              </tr>
              <tr>
                <td class="label">描述：</td>
                <td><input type="text" name="eventLog.desc_" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">状态：</td>
                <td>
                  <select name="eventLog.record_status" id="eventLog.record_status" required="required">
                  </select>
                </td>
              </tr>
            </table> 
          </td>
        </tr>
        <tr height="20"><td colspan="2"></td></tr>
      </table>
    </form>
             --%>

    <table cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td colspan="2" align="center" class="tx_center">
            <button onclick="viewJs.save()" accesskey="S" tabindex="-1">保存(S)</button>
          </td>
        </tr>
    </table>
    
    
    
  </div>
</div>
