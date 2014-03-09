<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
	view:document.getElementById("view_<%=view_id%>"), 
	id:<%=view_id%>,
    list_url:root+"/system/user_list.action" ,
    create_url:root + "/system/user_create.action" ,
    update_url:root + "/system/user_update.action" ,
    get_url:root + "/system/user_get.action" ,
    delete_url:root + "/system/user_delete.action" ,
    entityName:"user",
    entity:null,
	
	init:function (){
		this.pageIndex=E("userSO.pageIndex");
		fillOptions({id:"user.status_", dictName:"CM.status", firstLabel:"请选择..."}) ;//  改为字典取值
		//E$("user.status_").combobox();
        //E$('editDiv').hide() ;
        
        this.initDataGrid("userTB", {height:"400px"}) ;
        this.initDataGrid("roleTB", {height:"330px"}) ;
        
        E$("user.expired_date").datepicker({dateFormat: "yy-mm-dd" });

        E$("sForm").validator();
        E$("eForm").validator();
        
        var organizationOptions = filter(g$dict.Organization, {record_status:'A'});
        
        E$("userSO.organization_id").combobox2({id:"userSO.organization_id", 
            data:organizationOptions, 
            firstLabel:"全部", 
            valueProperty:"PK_ID", 
            idProperty:"PK_ID", 
            textProperty:["name_"], 
            titleProperty:"name_"
        });

        E$("user.organization_id").combobox2({id:"user.organization_id", 
            data:organizationOptions, 
            firstLabel:"请选择...", 
            valueProperty:"PK_ID", 
            idProperty:"PK_ID", 
            textProperty:["name_"], 
            titleProperty:"name_"
        });
        /*
        var companyOptions = [];//filter(g$dict.Company, {record_status:'A'});

        E$("userSO.company_id").combobox2({id:"userSO.company_id", 
            data:companyOptions, 
            firstLabel:"全部", 
            valueProperty:"PK_ID", 
            idProperty:"PK_ID", 
            textProperty:["name_cn"], 
            titleProperty:"name_cn"
        });

        E$("user.company_id").combobox2({id:"user.company_id", 
            data:companyOptions, 
            firstLabel:"请选择...", 
            valueProperty:"PK_ID", 
            idProperty:"PK_ID", 
            textProperty:["name_cn"], 
            titleProperty:"name_cn"
        });
        
        E("user.company_id").onSelected = function (event, elem) {
            if (elem !=null && elem.company_type == 0) {// is hlt company
                E$("organizationTr").show() ;

                fillOptions({
                	id:"user.organization_id", 
       	            url:root + "/system/organization_list.action",
                    data:{"organizationSO.company_id":elem.id, "organizationSO.pageIndex":-2}, 
                    firstLabel:"请选择...", 
                    textProperty:"name_", 
                    titleProperty:"name_", 
                    valueProperty:"id",
                    value:viewJs.state=="a"?"":viewJs.entity.organization_id
                }) ;
            } else {
                E$("organizationTr").hide() ;
                fillOptions({id:"user.organization_id", 
                    data:[], 
                    firstLabel:"请选择...", 
                    textProperty:"name_", 
                    titleProperty:"name_", 
                    valueProperty:"id"
                }) ;
            }
        };*/
        
        this.first();
    },
    //$(document).keydown(function(){if(event.keyCode==13){event.keyCode='9';}})  
    
    get:function(id) {
        ajax(
            this.get_url + "?id="+id, 
            null,
            function(data, textStatus){

            	if (data.code || data.code > 0) {
            		viewJs.toPage(viewJs.preState) ;
            		return ;
            	}
            	/*
                fillOptions({id:"user.company_id", 
                             data:data.companyOptions, 
                             firstLabel:"请选择...", 
                             textProperty:"name_cn", 
                             titleProperty:"name_cn", 
                             valueProperty:"id"
                             }) ;
         */


         
                //E$("user.organization_id").combobox();
                viewJs.entity = data;
                formDeserialize("eForm", data, {role_ids:true}) ;//以免处理template中的check-box value值
                
                //E("user.company_id").onSelected();

                $(data.roles).each(function(i, domEle){
                    domEle['checked'] = (domEle['user_id'] == 0 || domEle['user_id'] == null)? "":"checked" ;
                });
                
                viewJs.addRows("roleTB", data.roles) ;
                
                var $eForm = E$("eForm") ;
                if (id == -1) {
                	E$("user.login_id").removeAttr("readonly") ;
                	E$("user.password_").attr("required", true);
                } else {
                    E$("user.login_id").attr("readonly", "readonly") ;
                    E$("user.password_").attr("required", false);
                }
                
                $eForm.validator(/*{
                        position: 'top left',
                        offset: [-12, 0],
                        message: '<div><em/></div>' // em element is the arrow
                        }*/
                );//为了初始化check box
            }
        );
    },
    
    checkEditForm:function(_form) {
    	
    	var pw = _form["user.password_"] ;
    	var pwc = _form["user.password_confirm"] ;
    	
    	if (pw.value != pwc.value) {
    		alert("密码与确认密码不一致，请重新输入！") ;
    		pw.value = "" ;
    		pw.focus();

    		pwc.value = "" ;
    		return false ;
    	}
    	
        return true ;
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">
  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
	  
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="userSO.pageIndex" id="userSO.pageIndex" value="1" type="hidden" />
        <input name="userSO.pageSize" id="userSO.pageSize" value="10" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td style="width:60px;" class="label">名称：</td>
           <td style="width:100px;">
             <input name="userSO.name_cn" value="" type="text" />
           </td>
           <td style="width:80px;" class="label">登录帐号：</td>
           <td style="width:100px;">
             <input name="userSO.login_id_like" value="" type="text" style="text-transform: uppercase;" />
           </td>
           <!-- 
           <td style="width:80px;" class="label">所属公司：</td>
           <td style="width:160px;">
             <input name="userSO.company_id" id="userSO.company_id" value="" type="text" />
           </td>
            -->
           <td style="width:80px;" class="label">所属部门：</td>
           <td style="width:160px;">
             <input name="userSO.organization_id" id="userSO.organization_id" value="" type="text" />
           </td>
           <td style="width:100px;">
             <button onclick="viewJs.first();" accesskey="Q" >查找(Q)</button>
           </td>
           <td>
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="userTB" title="用户列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="30%">名称</th>
            <th width="35%">登录账号</th>
            <th width="35%">描述</th>
          </tr>
        </thead>
        
        <tbody id="listBody" >
        </tbody>
         
        <tbody style="display:none;visibility: false;" disabled="true">
          <tr>
            <td>
              <textarea id="templateBody" jTemplate="yes">
		          <tr id="{$T.id}" ondblclick="viewJs.toEdit($('#ids', this)[0]);">
		            <td>
		              <input type="checkbox" name="ids" id="ids" value="{$T.id}" />
		            </td>
		            <td>{$T.name_cn}</td>
		            <td>{$T.login_id}</td>
		            <td>{$T.desc_}</td>
		          </tr>
              </textarea>
            </td>
          </tr>
        </tbody>
	</table>
	
  </div>
	
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="user.id" id="user.id"/>
      <input type="hidden" name="user.version_id" id="user.version_id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td width="45%">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td class="label">中文名称：</td>
                <td colspan="3"><input type="text" name="user.name_cn" required="required" maxlength="50"/></td>
              </tr>
              <tr>
                <td class="label">英文名称：</td>
                <td colspan="3"><input type="text" name="user.name_en"  maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">登录帐号：</td>
                <td colspan="3"><input type="text" name="user.login_id" id="user.login_id" required="required" maxlength="50" style="text-transform: uppercase;"/></td>
              </tr>
              <tr>
                <td width="20%" class="label">密码：</td>
                <td width="30%"><input type="password" name="user.password_" id="user.password_" maxlength="16" /></td>
                <td width="20%" class="label">密码确认：</td>
                <td><input type="password" name="user.password_confirm" maxlength="16"/></td>
              </tr>
              <!--
              <tr>
                <td class="label">所属公司：</td>
                <td colspan="3">
                  <input name="user.company_id" id="user.company_id" required="required"/>
                </td>
              </tr> 
               -->
              <tr id="organizationTr">
                <td class="label">所属部门：</td>
                <td colspan="3">
                  <input type="text" name="user.organization_id" id="user.organization_id" />
                  <!-- 
                  <select name="user.organization_id" id="user.organization_id" >
                  </select>
                   -->
                </td>
              </tr>
              <tr>
                <td class="label">描述：</td>
                <td colspan="3"><input type="text" name="user.desc_" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">QQ：</td>
                <td colspan="3"><input type="text" name="user.qq_account" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">电子邮件：</td>
                <td colspan="3"><input type="text" name="user.email_" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">区号：</td>
                <td><input type="text" name="user.city_code" maxlength="5"/></td>
                <td class="label">电话：</td>
                <td><input type="text" name="user.phone_" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">移动电话：</td>
                <td><input type="text" name="user.mobile" maxlength="250"/></td>
                <td class="label">传真：</td>
                <td><input type="text" name="user.fax_" maxlength="250"/></td>
              </tr>
              <!-- 
              <tr>
                <td class="label">过期日期：</td>
                <td><input type="text" name="user.expired_date" id="user.expired_date" width="80%" readonly="readonly"/></td>
              </tr>
               -->
              <tr>
                <td class="label">状态：</td>
                <td colspan="3">
                  <select name="user.status_" id="user.status_" required="required">
                  </select>
                </td>
              </tr>
            </table> 
          </td>
          <td width="2%">
          </td>
          <td valign="top">
              <h3>角色列表</h3>
              <table id="roleTB" class="datagrid">
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
                      <input type="checkbox" name="role_ids" value="{id}" {checked} onfocus="$(this).addClass('ui-state-focus');" onblur="$(this).removeClass('ui-state-focus');" />
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

    <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr>
          <td colspan="2" align="center" class="tx_center">
            <button onclick="viewJs.save()" accesskey="S" tabindex="-1">保存(S)</button>
          </td>
        </tr>
    </table>
    
    
    
  </div>
</div>
