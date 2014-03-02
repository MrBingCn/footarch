<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/biz/productCategory_list.action" ,
    create_url:root + "/biz/productCategory_create.action" ,
    update_url:root + "/biz/productCategory_update.action" ,
    get_url:root + "/biz/productCategory_get.action" ,
    delete_url:root + "/biz/productCategory_delete.action" ,
    entityName:"productCategory",
    proIdName:"pro_product_category_id", 
    
    init:function (){
        //this.initSelect() ;
        this.pageIndex = E("productCategorySO.pageIndex") ;
        
        fillOptions({id:"productCategory.record_status", dictName:"CM.status", firstLabel:"请选择..."}) ;// 改为字典取值
        fillOptions({id:"productCategory.is_show", dictName:"CM.yes.no", firstLabel:"请选择..."}) ;
        fillOptions({id:"productCategorySO.record_status", dictName:"CM.status", firstLabel:"全部"}) ;
        

        this.initDataGrid("productCategoryTB", {height:"400px"}) ;
        
        //E$("productCategory.expired_date").datepicker({dateFormat: "yy-mm-dd" });
        E$("eForm").validator();
        E$("sForm").validator();
        E("sForm").setFirstFocus();
        
    },
    
    get:function(id) {
    	
        var optionParams = {
        	id:"productCategory.pro_product_category_id", 
        	dictName:"ProProductCategory", 
        	firstLabel:"[顶层--一级目录]", 
            textProperty:"name_cn", 
            titleProperty:"name_cn"} ;
        
        E("productCategory.pro_product_category_id").isEdit = (id != -1);
        
        if (id == -1) {
        	fillOptions(optionParams) ;
            formDeserialize("eForm", this.eFormInitData, {}) ;// reset form;
            return ;
        }
        ajax(
            this.get_url + "?id="+id, 
            null,
            function(data, textStatus){
                if (data.pro_product_category_id != null && data.pro_product_category_id > 0) {
                    delete optionParams["firstLabel"] ;
                }
                var filterValues = {} ;
                filterValues[data.pro_product_category_id] = true ;
                optionParams["filter"] = filterValues ;
                fillOptions(optionParams) ;
                
                formDeserialize("eForm", data, {}) ;
            }
        );
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="productCategorySO.pageIndex" id="productCategorySO.pageIndex" value="1" type="hidden" />
        <input name="productCategorySO.pageSize" id="productCategorySO.pageSize" value="500" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <!-- 
           <td style="width:60px;" class="label">编码：</td>
           <td style="width:100px;">
             <input name="productCategorySO.code_" value="" type="text" />
           </td>
            -->
           <td style="width:80px;" class="label">中文名称：</td>
           <td style="width:100px;">
             <input name="productCategorySO.name_cn" value="" type="text" />
           </td>
           <td style="width:60px;" class="label">状态：</td>
           <td style="width:100px;">
             <select name="productCategorySO.record_status" id="productCategorySO.record_status">
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
      
      
    <table id="productCategoryTB" title="目录列表" class="datagrid">
        <thead>
          <tr>
            <th width="5%"></th>
            <th width="25%">名称</th>
            <th width="30%">描述</th>
            <th width="25%">关键字</th>
            <th width="7%">可见</th>
            <th width="8%">状态</th>
          </tr>
        </thead>
        
        <tbody id="listBody" >
        </tbody>
         
        <tbody style="display:none;visibility: false;" disabled="true">
          <tr>
            <td>
              <textarea id="templateBody" jTemplate="yes">
		          <tr id="{$T.id}" ondblclick="viewJs.toEdit($('#ids', this)[0]);"  style='background:#FFFF{#if $T.pro_product_category_id == null}CC{#else}FF{#/if};'>
		            <td>
		              <input type="checkbox" name="ids" id="ids" value="{$T.id}" />
		            </td>
		            <td style="text-align: left;padding-left: {#if $T.pro_product_category_id == null}5{#else}25{#/if}px;">{$T.name_cn}</td>
		            <td>{$T.keywords_}</td>
		            <td>{fmt.maxlen($T.desc_, 50)}</td>
                    <td>{dVal("CM.yes.no", "name_", {PK_ID:$T.is_show})}</td>
                    <td>{dVal("CM.status", "name_", {PK_ID:$T.record_status})}</td>
		          </tr>
              </textarea>
            </td>
          </tr>
        </tbody>
    </table>
    
  </div>
    
  <div id="editDiv" style="display:none;">
            
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="productCategory.id" id="productCategory.id"/>
      <input type="hidden" name="productCategory.version_id" id="productCategory.version_id"/>
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td valign="top" width="15%">
          </td>
          <td width="45%">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td width="25%" class="label">父目录：</td>
                <td>
	             <select name="productCategory.pro_product_category_id" id="productCategory.pro_product_category_id" >
	             </select>
                </td>
              </tr>
              <tr>
                <td class="label">名称：</td>
                <td><input type="text" name="productCategory.name_cn" id="productCategory.name_cn" required="required"  maxlength="50"/></td>
              </tr>
              <tr>
                <td class="label">关键字：</td>
                <td><input type="text" name="productCategory.keywords_" maxlength="50"/></td>
              </tr>
              <tr>
                <td class="label">描述：</td>
                <td><textarea name="productCategory.desc_" required="required" maxlength="250" style="height: 50px;"></textarea></td>
              </tr>
              <tr>
                <td class="label">次序：</td>
                <td><input type="integer" name="productCategory.order_" required="required" maxlength="3"/></td>
              </tr>
              <tr>
                <td class="label">是否显示：</td>
                <td>
                  <select name="productCategory.is_show" id="productCategory.is_show" required="required">
                  </select>
                </td>
              </tr>
              <tr>
                <td class="label">状态：</td>
                <td>
                  <select name="productCategory.record_status" id="productCategory.record_status" required="required">
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
