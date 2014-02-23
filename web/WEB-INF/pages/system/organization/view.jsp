<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/system/organization_list.action" ,
    create_url:root + "/system/organization_create.action" ,
    update_url:root + "/system/organization_update.action" ,
    get_url:root + "/system/organization_get.action" ,
    delete_url:root + "/system/organization_delete.action" ,
    entityName:"organization",
    entity:null,
    proIdName:"pro_organization_id",
    
    init:function (){
        //this.initSelect() ;
        var _this = this ;
        
        this.pageIndex = E("organizationSO.pageIndex") ;
        fillOptions({id:"organization.record_status", dictName:"CM.status", firstLabel:"请选择..."}) ;// 改为字典取值
        fillOptions({id:"organizationSO.record_status", dictName:"CM.status", firstLabel:"全部"}) ;

        fillOptions({id:"organization.leader_id", 
            data:[],
            firstLabel:"请选择...", 
            textProperty:"name_cn", 
            titleProperty:"name_cn", 
            valueProperty:"id"
        }) ;

        E$("organization.pro_organization_id").combobox2({
            data:[], 
            firstLabel:"[无上级级织]", 
            valueProperty:"id", 
            idProperty:"id", 
            textProperty:["name_"]
        });
        E("organization.pro_organization_id").onSelected = function (event, elem) {
            if (elem !=null) {
                var level = elem.level_ ;
                if (typeof(level) == "undefined" || level == null) {
                    level = 1 ;
                } else {
                    level ++ ;
                }
                V("organization.level_", level) ;
            }
        };
        var hltCompanyOptions = filter(g$dict.Company, {company_type:0,record_status:'A'}) ;
        /*
        var hltCompanyOptions = <%=request.getAttribute("hltCompanyOptions")%>;
        fillOptions({id:"organization.company_id", 
            data:hltCompanyOptions, 
            firstLabel:"请选择...", 
            textProperty:"name_cn", 
            titleProperty:"name_cn", 
            valueProperty:"id"
        }) ;
        */
        E$("organizationSO.company_id").combobox2({
            firstLabel:"Choose",
            data:hltCompanyOptions, 
            textProperty:["name_cn", "name_en"],
            idProperty:"PK_ID", 
            valueProperty:"PK_ID"
        });
        
        E("organizationSO.company_id").onSelected = function (event, elem) {
            if (elem !=null) {// is hlt company
                // setting company_id
	            fillOptions({id:"organization.leader_id", 
	                url:root + "/system/user_list.action",
	                data:{"userSO.company_id":elem.PK_ID, "userSO.pageIndex":-2},
	                firstLabel:"请选择...", 
	                textProperty:"name_cn", 
	                titleProperty:"name_cn", 
	                valueProperty:"id"
	            }) ; 
            
                _this.eFormInitData = {"company_id":elem.PK_ID, "company_name":elem.name_cn, "order_":0};
                E$("organization.company_name").html(elem.name_cn) ;
            	_this.first() ;
            } else {
            	alert("请重新选择公司！") ;
            }
        };
        
        /*
        fillOptions({id:"organizationSO.company_id", 
            data:hltCompanyOptions, 
            firstLabel:"全部", 
            textProperty:"name_cn", 
            titleProperty:"name_cn", 
            valueProperty:"id"
        }) ;
        */
        this.initDataGrid("organizationTB", {height:"400px"}) ;
        
        //E$("organization.expired_date").datepicker({dateFormat: "yy-mm-dd" });
        E$("eForm").validator();
        E$("sForm").validator();
        
        this.toPage('s') ;
        
        this.convertors = {
        		record_status_name:["record_status",function (_v) {
        			return dVal("CM.status", "name_", {PK_ID:_v});
        		}],
                company_name:["company_id",function (_v) {
                    return find(hltCompanyOptions, "name_cn", {id:_v});
                }]
        } ;

        //this.first();
	    var orgListFunc = this.list; //record the original
	    this.list = function(){
	    	if (E$("organizationSO.company_id").val() == "") {
	    		alert("请选择公司后查询！") ;
	    		return ;
	    	}
	    	orgListFunc.call(_this) ;
	    };
    },
    
    companyOnChange:function () {
    	var company_id = V("organization.company_id") ;
    	if (company_id == "") {
            fillOptions({id:"organization.leader_id", 
                data:[],
                firstLabel:"请选择...", 
                textProperty:"name_cn", 
                titleProperty:"name_cn", 
                valueProperty:"id"
            }) ;
    	} else {
            fillOptions({id:"organization.leader_id", 
                url:root + "/system/user_list.action",
                data:{"userSO.company_id":V("organization.company_id"), "userSO.pageIndex":-2},
                firstLabel:"请选择...", 
                textProperty:"name_cn", 
                titleProperty:"name_cn", 
                valueProperty:"id",
                value:viewJs.entity.leader_id
            }) ;	
    	}
    }, 
    
    onList:function (_data) {
    	E$("organization.pro_organization_id").combobox2("option", "data", _data.list);
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="organizationSO.pageIndex" id="organizationSO.pageIndex" value="1" type="hidden" />
        <input name="organizationSO.pageSize" id="organizationSO.pageSize" value="100" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td style="width:80px;" class="label">所属公司：</td>
           <td style="width:260px;">
             <input name="organizationSO.company_id" id="organizationSO.company_id" value="" type="text" />
           </td>
           <!-- 
           <td style="width:60px;" class="label">名称：</td>
           <td style="width:100px;">
             <input name="organizationSO.name_cn" value="" type="text" />
           </td>
           <td style="width:60px;" class="label">编码：</td>
           <td style="width:100px;">
             <input name="organizationSO.code_" value="" type="text" />
           </td>
           <td style="width:80px;" class="label">所属公司：</td>
           <td style="width:120px;">
             <select name="organizationSO.company_id" id="organizationSO.company_id" >
             </select>
           </td>
           <td style="width:60px;" class="label">状态：</td>
           <td style="width:100px;">
             <select name="organizationSO.record_status" id="organizationSO.record_status">
             </select>
           </td>
            -->
           <td style="width:100px;">
             <button onclick="viewJs.first();" accesskey="Q" >查找(Q)</button>
           </td>
           <td>
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="organizationTB" title="组织列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="20%">名称</th>
            <!-- 
            <th width="20%">所属公司</th>
             -->
            <th width="10%">编码</th>
            <th width="35%">描述</th>
            <th width="10%">状态</th>
          </tr>
        </thead>
        
        <tbody id="listBody" >
        </tbody>
         
        <tbody style="display:none;">
          <tr>
            <td>
              <textarea rows="1" cols="1" id="templateBody" jTemplate="true">
		          <tr id="{$T.id}" ondblclick="viewJs.toEdit($('#ids', this)[0]);">
		            <td>
		              <input type="checkbox" name="ids" id="ids" value="{$T.id}" />
		            </td>
		            <td style="text-align: left;padding-left: {$T.level_*10 + 10}px;">{$T.name_}</td>
		            <!-- 
		            <td>{$T.company_name}</td>
		             -->
		            <td>{$T.code_}</td>
		            <td>{$T.desc_}</td>
		            <td>{$T.record_status_name}</td>
		          </tr>
              </textarea>
            </td>
          </tr>
        </tbody>
    </table>
    
  </div>
    
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="organization.id" id="organization.id"/>
      <input type="hidden" name="organization.level_" id="organization.level_"/>
      <input type="hidden" name="organization.version_id" id="organization.version_id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td valign="top" width="15%">
          </td>
          <td width="50%">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td class="label">所属公司：</td>
                <td>
                  <input type="hidden"  name="organization.company_id" id="organization.company_id"  />
                  <span id="organization.company_name"></span>
                  <!-- 
                  <select name="organization.company_id" id="organization.company_id" required="required" onchange="viewJs.companyOnChange();">
                  </select>
                   -->
                </td>
              </tr>
              <tr>
                <td class="label">上级部门：</td>
                <td>
                  <input type="text"  name="organization.pro_organization_id" id="organization.pro_organization_id"  />
                </td>
              </tr>
              <tr>
                <td class="label">名字：</td>
                <td><input type="text" name="organization.name_" required="required" maxlength="50"/></td>
              </tr>
              <tr>
                <td width="25%" class="label">编码：</td>
                <td><input type="text" name="organization.code_" required="required" maxlength="8"/></td>
              </tr>
              <tr>
                <td class="label">描述：</td>
                <td><input type="text" name="organization.desc_" maxlength="50"/></td>
              </tr>
              <tr>
                <td class="label">部门负责人：</td>
                <td>
                  <select name="organization.leader_id" id="organization.leader_id" required="required">
                  </select>
                </td>
              </tr>
              <tr>
                <td class="label">次序：</td>
                <td><input type="number" name="organization.order_" maxlength="3" required="required"/></td>
              </tr>
              <tr>
                <td class="label">状态：</td>
                <td>
                  <select name="organization.record_status" id="organization.record_status" required="required">
                  </select>
                </td>
              </tr>
            </table> 
          </td>
          <td valign="top" width="35%">
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
