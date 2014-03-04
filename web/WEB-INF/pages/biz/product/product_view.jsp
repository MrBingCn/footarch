<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/biz/product_list.action" ,
    create_url:root + "/biz/product_create.action" ,
    update_url:root + "/biz/product_update.action" ,
    get_url:root + "/biz/product_get.action" ,
    delete_url:root + "/biz/product_delete.action" ,
    entityName:"product",
    
    init:function (){
        //this.initSelect() ;
        this.pageIndex = E("productSO.pageIndex") ;
        
        //E$("product.product_type").on("change", this.typeOnChange) ;
        
        //fillOptions({id:"productSO.type_", dictName:"CRM.product.type_", firstLabel:"全部产品"}) ;
        fillOptions({id:"productSO.record_status", dictName:"CM.status", firstLabel:"全部"}) ;
        fillOptions({id:"product.record_status", dictName:"CM.status", firstLabel:"请选择..."}) ;// 改为字典取值
        fillOptions({id:"product.product_category_id", dictName:"pos.productCategory", firstLabel:"请选择..."}) ;
        fillOptions({id:"product.brand_id", dictName:"CM.brand", firstLabel:"请选择..."}) ;
        //fillOptions({id:"product.invoice_type", dictName:"BIZ.invoice.type", firstLabel:"请选择..."}) ;

        this.initDataGrid("productTB", {height:"400px"}) ;

        E$("product.promote_start_on").datepicker();
        E$("product.promote_end_on").datepicker();
        
        E$("eForm").validator();
        E$("sForm").validator();
        E("sForm").setFirstFocus();

        this.states.a.onBeforeShow=function(_view, _state) {
            $("#viewContactBtn, #viewPartyBtn", viewJs.view).hide() ;
        } ;
        this.states.e.onBeforeShow=function(_view, _state) {
            $("#viewContactBtn, #viewPartyBtn", viewJs.view).show() ;
        } ;
        
        //this.typeOnChange() ;

        E$("editScollDiv").height((__clientHeight - 200) + "px") ;
    },
    
    checkEditForm:function () {
    	/*
        var type = V("product.product_type") ; 
        if (type == "1") {
            if (V("product.customer_service_reps") == "") {
            	alert("请选择客服代表！") ;
            	return false;
            } 
        }
        */
        return true ;
    },
    
    get:function(id) {
        if (id == -1) {
             viewJs.entity = this.eFormInitData;
             formDeserialize("eForm", this.eFormInitData, {}) ;// reset form;
             //this.refreshCustomerServiceRep() ;
             return ;
        }
        var idProperty = (this.idName==null?"id":this.idName) ;
        var params = {} ;
        params[idProperty] = id ;
        ajax(
            this.get_url, 
            params,
            function(data, textStatus){
                viewJs.entity = data;
                formDeserialize("eForm", data, {}) ;
                //viewJs.refreshCustomerServiceRep() ;
            }
        );
    },
    
    saveNotList:function () {
    	var _this = this ;
    	this.save(function (_data) {
    		//_this.toPage("e");
    		if (V("product.id") == "") {
                _this.showBlock("e") ;	
                V("product.id", _data.id);
                //$("#viewContactBtn, #viewPartyBtn", viewJs.view).show() ;
                //_this.typeOnChange();
    		} 
    		V("product.version_id", _data.version_id);
    	});
    } ,
    
    photoUpload:function(){
    	uploader.url = "/biz/productPhoto" ;
    	uploader.show(V("product.id"), 'P', 'photoDisplayDiv');	
    }
}) ;

</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <%@include file="/WEB-INF/pages/frame/navigation.jsp" %>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0">
        <input name="productSO.pageIndex" id="productSO.pageIndex" value="1" type="hidden" />
        <input name="productSO.pageSize" id="productSO.pageSize" value="10" type="hidden" />
        <table width="100%"  style="border: 0; padding: 0;" cellspacing="0" cellpadding="0" class="formgrid">
          <tr>
           <td style="width:70px;" class="label">中文名称：</td>
           <td style="width:100px;">
             <input name="productSO.name_cn" value="" type="text" />
           </td>
           <td style="width:70px;" class="label">英文名称：</td>
           <td style="width:100px;">
             <input name="productSO.name_en" value="" type="text" />
           </td>
           <td style="width:60px;" class="label">货号：</td>
           <td style="width:100px;">
             <input name="productSO.code_" value="" type="text" />
           </td>
           <td style="width:50px;" class="label">状态：</td>
           <td style="width:100px;">
             <select name="productSO.record_status" id="productSO.record_status">
             </select>
           </td>
           <td style="width:110px;">
             <button onclick="viewJs.first();" accesskey="Q" >查找(Q)</button>
           </td>
           <td>
           </td>
          </tr>
        </table>
      </form>
      
      
    <table id="productTB" title="产品列表" class="datagrid">
        <thead>
          <tr>
            <th width="4%"></th>
            <th width="30%">中文名称</th>
            <th width="30%">英文名称</th>
            <th width="10%">货号</th>
            <th width="12%">所属品牌</th>
            <th width="12%">状态</th>
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
		            <td>{$T.name_en}</td>
		            <td>{$T.code_}</td>
		            <td>{$T.brand_id}</td>
		            <td>{$T.record_status}</td>
	            </tr>
              </textarea>
            </td>
          </tr>
        </tbody>
    </table>
    
  </div>
    
  <div id="editDiv" style="display:none;">
    <div id="editScollDiv" style="overflow: auto;" >
    <form method="post" id="eForm" name="eForm" onsubmit="return false;" style="margin: 0">
      <input type="hidden" name="product.id" id="product.id"/>
      <input type="hidden" name="product.version_id" id="product.version_id"/>
      <input type="hidden" name="product.pro_product_id"/>
      
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td valign="top">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td class="label" width="15%">中文名称：</td>
                <td width="30%"><input type="text" name="product.name_cn" id="product.name_cn" required="required" maxlength="250"/></td>
                <td class="label" width="15%">英文名称：</td>
                <td width="30%"><input type="text" name="product.name_en" maxlength="250"/></td>
              </tr>
              <tr>
                <td class="label">货号：</td>
                <td><input type="text" name="product.name_short"  maxlength="50"/></td>
                <td class="label">关键字：</td>
                <td><input type="text" name="product.keywords_"  maxlength="50"/></td>
              </tr>
              <tr>
                <td class="label">净重：</td>
                <td><input type="number" name="product.weight_ " id="product.weight_" maxlength="25"/></td>
                <td class="label">单位：</td>
                <td><input type="text" name="product.unit_ " id="product.unit_" maxlength="25"/></td>
              </tr>
              <tr>
                <td class="label">市场售价：</td>
                <td><input type="number" name="product.market_price" maxlength="10" required="required"/></td>
                <td class="label">本店售价：</td>
                <td><input type="number" name="product.selling_price" maxlength="10"/></td>
              </tr>
              <tr>
                <td class="label">促销价格：</td>
                <td><input type="number" name="product.promote_price" maxlength="10"/></td>
                <td class="label">促销日期：</td>
                <td>
                  <input type="text" name="product.promote_start_on" id="product.promote_start_on" maxlength="10" style="width: 80px;"/>
                  -
                  <input type="text" name="product.promote_end_on" id="product.promote_end_on" maxlength="10" style="width: 80px;"/>
                </td>
              </tr>
              <tr>
                <td class="label">状态：</td>
                <td>
                  <select name="product.record_status" id="product.record_status" required="required">
                  </select>
                </td>
                <td class="label"></td>
                <td>
                </td>
              </tr>
              <tr>
                <td class="label">图片：</td>
                <td>
                  <button type="button" onclick="viewJs.photoUpload();">上传</button>
                </td>
                <td class="label"></td>
                <td>
                </td>
              </tr>
              <tr>
                <td colspan="4">
                  <div id="photoDisplayDiv"></div>
                </td>
              </tr>
              
            </table> 
          </td>
          <td width="5%"></td>
        </tr>
        <tr height="20"><td colspan="2"></td></tr>
        <!-- 
        <tr><td><h3>角色列表</h3></td></tr>
        <tr>
          <td></td>
        </tr>
         -->
      </table>
    </form>
    </div>       

    <table cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td colspan="2" align="center" class="tx_center">
            <button onclick="viewJs.saveNotList()" accesskey="S" tabindex="-1">保存(S)</button>
          </td>
        </tr>
    </table>
    
    
  </div>
  
  <!-- 
  <div id="editContactDiv" style="display:none;">
  editContactDiv
  </div>
   -->
</div>

    <%@include file="/WEB-INF/pages/biz/document/upload_form.jsp" %>