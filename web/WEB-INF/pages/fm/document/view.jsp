<%@page import="com.globalwave.system.entity.SessionUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
SessionUser sUser = (SessionUser)session.getAttribute(SessionUser.SESSION_PK) ;
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/fm/document_list.action" ,
    create_url:root + "/fm/document_create.action" ,
    update_url:root + "/fm/document_update.action" ,
    get_url:root + "/fm/document_get.action" ,
    delete_url:root + "/fm/document_delete.action" ,
    entityName:"document",
    
    init:function (){
        this.pageIndex = E("documentSO.pageIndex") ;
        fillOptions({id:"document.record_status", dictName:"CM.status", firstLabel:"请选择..."}) ;//  改为字典取值
        //E$('editDiv').hide() ;

        
        //$("thead", $newTable).css("display", "none") ;
        this.initDataGrid("documentTB", {height:"400px"}) ;
        
        //E$("document.expired_date").datepicker({dateFormat: "yy-mm-dd" });
        this.convertors = {
                record_status_name:["record_status",function (_v) {
                    return dVal("CM.status", "name_", {PK_ID:_v});
                }]
        } ;

        E$("sForm").validator();
        E$("eForm").validator();

        this.states.a.onBeforeShow = function(_view, _state) {
            E$("documentFileTR").show();
        } ;
        this.states.e.onBeforeShow = function(_view, _state) {
            E$("documentFileTR").hide();
        } ;
        
        this.first();


        <% if (!sUser.hasPrivilege((short)2210)) { %>
        E$("addLi").hide();
        E$("editLi").hide();
        E$("deleteLi").hide();
        <% } %>
    },

    save:function() {
        if(!E("eForm").checkValidity()) {
            alert("请正确填写表单！") ;
            E("eForm").setErrorFocus() ;
            return ;
        }
        
        var isAdd = (V("document.id")=="") ;
        
        if (isAdd && E$("document.document_file").val() == "") {
            alert("请选择要上传的文件！") ;
            return ;
        }
        
        if (!window.confirm("是否确定要保存？")) {
            return ;
        }

        
        if (isAdd) {
            showLoading();
            E("eForm").submit() ;
        } else {
            ajax(
            	root + "/fm/document_update.action" , 
                E$("eForm").serialize(),
                function(data, textStatus){
                    //alert(data.message) ;
                    if (data.code == "0") {
                        viewJs.toPage('s') ;
                        viewJs.list() ;
                    }
                }
            );  
        }
    },

    uploadOnReturn:function(msg) { 
        // iframe.contentWindow.document - for IE<7
        //var iframe = $("#save_iframe")[0] ;
        //var msg = iframe.contentDocument ? iframe.msg: iframe.contentWindow.msg;
        
        if (msg) {
            hideLoading();
            
            if (msg.code == "0") {
                viewJs.toPage('s') ;
                viewJs.list() ;
            }
            
            alert(msg.message) ;
        }
    },

    setDocumentName:function (fileInput) {
        var fileName = $(fileInput).val();
        
        var i = fileName.lastIndexOf("/") ;

        if (i < 0) {
            i = fileName.lastIndexOf("\\") ;
        }

        if (i > 0) {        
            E$('document.name_').val(fileName.substring(i + 1)) ;
        } else {
            E$('document.name_').val(fileName) ;
        }
        
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0" >
        <input name="documentSO.pageIndex" id="documentSO.pageIndex" value="1" type="hidden" />
        <input name="documentSO.pageSize" id="documentSO.pageSize" value="10" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td style="width:60px;" class="label">名称：</td>
           <td style="width:100px;">
             <input name="documentSO.name_" value="" type="text" />
           </td>
           <td style="width:60px;" class="label">编码：</td>
           <td style="width:100px;">
             <input name="documentSO.code_" value="" type="text" />
           </td>
           <td style="width:60px;" class="label">标签：</td>
           <td style="width:100px;">
             <input name="documentSO.tags_" value="" type="text" />
           </td>
           <td style="width:100px;">
             <button onclick="viewJs.first();" accesskey="Q" >查找(Q)</button>
           </td>
           <td>
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="documentTB" title="文档列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="30%">名称</th>
            <th width="15%">上传时间</th>
            <th width="10%">大小</th>
            <th width="25%">标签</th>
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
            <td><a href="<%=request.getContextPath() %>/fm/document_download.action?id={id}" target="_blank">{name_}</a></td>
            <td>{created_on}</td>
            <td>{size_}</td>
            <td>{tags_}</td>
            <td>{record_status_name}</td>
          </tr>
        </tbody>
    </table>
    
  </div>
    
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0" enctype="multipart/form-data" target="save_iframe" action="<%=request.getContextPath() %>/fm/document_create.action">
      <input type="hidden" name="document.id" id="document.id"/>
      <input type="hidden" name="document.version_id" id="document.version_id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td width="90%">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr id="documentFileTR">
                <td class="label" width="10%">浏览：</td>
                <td><input type="file" name="document.document_file" onchange="viewJs.setDocumentName(this)" /></td>
              </tr>
              <tr>
                <td class="label">名字：</td>
                <td><input type="text" name="document.name_" id="document.name_" required="required" maxlength="250"/></td>
              </tr>
              <tr>
                <td width="25%" class="label">编码：</td>
                <td><input type="text" name="document.code_" maxlength="25"/></td>
              </tr>
              <tr>
                <td class="label">标签：</td>
                <td><input type="text" name="document.tags_" maxlength="250"/>(以英文【,】分隔)</td>
              </tr>
              <tr>
                <td class="label">描述：</td>
                <td><textarea name="document.desc_" maxlength="250" style="width: 100%;height: 80px;"></textarea></td>
              </tr>
              <tr>
                <td class="label">状态：</td>
                <td>
                  <select name="document.record_status" id="document.record_status" required="required">
                  </select>
                </td>
              </tr>
              <tr>
                <td class="label">次序：</td>
                <td><input type="number" name="document.order_" id="document.order_" maxlength="4" required="required"/></td>
              </tr>
            </table> 
          </td>

          <td width="10%">
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
    
    <iframe name="save_iframe" id="save_iframe" style="display:none;"></iframe>
    
    
  </div>
</div>
