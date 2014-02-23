<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
	view:document.getElementById("view_<%=view_id%>"), 
	id:<%=view_id%>,
    update_url:root + "/system/dict_updateDesc.action" ,
    get_url:root + "/system/dict_get.action" ,
    entityName:"dict",
	
	init:function (){
		//this.pageIndex=E("dictSO.pageIndex");
		//fillOptions({id:"dictSO.status_", dictName:"CM.status", firstLabel:"请选择..."}) ;//  改为字典取值
        
        //this.initDataGrid("dictTB", {height:"400px"}) ;
        
        //E$("dict.expired_date").datepicker({dateFormat: "yy-mm-dd" });

        //E$("sForm").validator();
        //E$("eForm").validator();
        //this.id = 1 ;
        //this.toPage("e") ;

        this.toPage("e") ;

        
        this.convertors = {
                input_type:["PK_ID",function (_v) {
                	if (_v.indexOf("password") > 0) {
                		return "password" ;
                	} else {
                		return "text" ;
                	}
                }]
        } ;
        
        this.addRows("formTable", g$dict.get("<%=request.getParameter("domain_")%>")) ;
    },
    save:function (row) {
    	/*
        if(!E("eForm").checkValidity()) {
            alert("请正确填写表单！") ;
            E("eForm").setErrorFocus() ;
            return ;
        }*/
        
        if (!window.confirm("是否确定要保存？")) {
            return ;
        }

        ajax(
        	this.update_url, 
            $("input", row).serialize(),
            function(data, textStatus){
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
		        </tbody>
		         
		        <tbody style="display:none;visibility: false;" disabled="true">
	              <tr>
	                <td>
	                  <textarea id="templateBody" jTemplate="yes">
			          <tr>
			            <td>
			              <input type="hidden" name="dict.code_" value="{$T.PK_ID}"/>
			              <input type="hidden" name="dict.domain_" value="{$T.domain_}"/>
			            </td>
			            <td class="label">{$T.name_}：</td>
			            <td><input type="{$T.input_type}" name="dict.desc_" value="{$T.desc_}"/></td>
			            <td><button onclick="viewJs.save($(this).parent().parent()) ;">保存</button></td>
			          </tr>
	                  </textarea>
	                </td>
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
