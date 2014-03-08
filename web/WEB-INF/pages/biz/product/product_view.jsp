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

        var proCategory = filter(g$dict.ProProductCategory, {record_status:'A'});
        var category = filter(g$dict.ProductCategory, {record_status:'A'});
        var categoryOptions = [] ;
        
        for (var i = 0 ; i < proCategory.length ; i ++) {
        	categoryOptions[categoryOptions.length] = proCategory[i] ;
        	for (var j = 0 ; j < category.length ; j ++) {
        		if (category[j].pro_product_category_id == proCategory[i].PK_ID) {
                     categoryOptions[categoryOptions.length] = {PK_ID:category[j].PK_ID, name_cn:"　　" + category[j].name_cn} ;
        		}
        	}
        }
        
        //E$("product.product_type").on("change", this.typeOnChange) ;
        
        //fillOptions({id:"productSO.type_", dictName:"CRM.product.type_", firstLabel:"全部产品"}) ;
        fillOptions({id:"productSO.record_status", dictName:"CM.status", firstLabel:"全部"}) ;
        fillOptions({id:"product.record_status", dictName:"CM.status", firstLabel:"请选择..."}) ;// 改为字典取值
        fillOptions({id:"product.product_category_id", data:categoryOptions, textProperty:"name_cn", firstLabel:"请选择..."}) ;
        fillOptions({id:"product.brand_id", dictName:"Brand", firstLabel:"请选择..."}) ;
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
             $("#phototr", viewJs.view).hide() ;
             return ;
        }
        $("#phototr", viewJs.view).show() ;
        
        var _this = this;
        
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
                _this.showPhotos(data.id, data.main_photo_uuid);
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
                $("#phototr", viewJs.view).show() ;
                E$("photoDisplayDiv").html("");
                //_this.typeOnChange();
    		} 
    		V("product.version_id", _data.version_id);
    	});
    } ,
    
    photoUpload:function(){
    	load("uploadFormWinDiv", root + "/biz/document/document_uploadForm.action", null, function(responseText, textStatus, XMLHttpRequest) {
            uploader.url = "/biz/productPhoto" ;
            uploader.getHtml=function(data) {
            	data.root = root;
            	data.isCover = false ;
                return parse(E$("photoItemTemplate").val(), data);
            }
            uploader.show(V("product.id"), 'p', 'photoDisplayDiv'); 
    	});
    },
    
    showPhotos:function(productId, ids) {
        
        var $photoDisplayDiv = E$("photoDisplayDiv") ;
        $photoDisplayDiv.html("");
        
        if (ids == null || ids == ""){
            return ;
        }
        
        //uploader.url = "/biz/productPhoto" ;
        var idArr = ids.split(",");
        for (var i = 0 ; i < idArr.length ; i ++)
        {
            var ids = idArr[i].split(":");
            //$photoDisplayDiv.append('<div><img src="' + root + '/photo/' + (productId%100) + '/' + productId + '/' +ids[1] +'.t"/>&nbsp;&nbsp;<a onclick="uploader.doDelete('+ids[0]+', this);" style="cursor:pointer;color:blue;">删除</a></div>');
            var data = {root:root, product_id:productId, id:ids[0], file_uuid:ids[1], isCover:(i == 0)};
            $photoDisplayDiv.append(parse(E$("photoItemTemplate").val(), data));
        }
    },

    
    doPhotoDelete:function (id, linkObj) {
        
        if (!window.confirm("是否确定要删除？")) {
            return ;
        }
    
        var _this = this ;
        
        ajax(
            root + "/biz/productPhoto_delete.action", 
            "document.id="+id,//$("#documentTB input:checked")[0].value,
            function(data, textStatus){
                //alert(data.message) ;
                if (data.code == "0") {
                    //list() ;
                    $(linkObj).parent().parent().remove() ;
                	//_this.showPhotos(data.product_id, data.file_uuid) ;
                } else {
                	alert(data.message) ;
                }
            }, 
            false
        );
    },
    
    doMakeItAsCover:function (id, linkObj) {
        
        if (!window.confirm("是否确定设置为封面？")) {
            return ;
        }
    
        var _this = this ;
   
        ajax(
            root + "/biz/productPhoto_makeItAsCover.action", 
            "id="+id,//$("#documentTB input:checked")[0].value,
            function(data, textStatus){
                //alert(data.message) ;
                if (data.code == "0") {
                    //list() ;
                    //alert(data.product_uuids);
                    var pPhoto = data.data ;
                    _this.showPhotos(pPhoto.product_id, pPhoto.product_uuids) ;
                } else {
                    alert(data.message) ;
                }
            }, 
            false
        );
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
            <th width="27%">中文名称</th>
            <th width="27%">英文名称</th>
            <th width="12%">货号</th>
            <th width="10%">分类</th>
            <th width="10%">所属品牌</th>
            <th width="10%">状态</th>
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
                    <td>{dVal("ProductCategory", "name_cn", {PK_ID:$T.product_category_id})}</td>
                    <td>{dVal("Brand", "name_", {PK_ID:$T.brand_id})}</td>
		            <td>{dVal("CM.status", "name_", {PK_ID:$T.record_status})}</td>
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
                <td class="label">分类：</td>
                <td>
                  <select name="product.product_category_id" id="product.product_category_id" required="required">
                  </select>
                </td>
                <td class="label">品牌：</td>
                <td>
                  <select name="product.brand_id" id="product.brand_id">
                  </select>
                </td>
              </tr>
              <tr>
                <td class="label">货号：</td>
                <td><input type="text" name="product.code_"  maxlength="50" required="required"/></td>
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
              <tr style="display: none;">
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
                <td class="label">描述：</td>
                <td>
                  <textarea style="height: 60px;"></textarea>
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
              <tr id="phototr">
                <td class="label">图片：</td>
                <td colspan="3">
                  <style>
                  #photoDisplayDiv .documentItemDiv {
                    display: inline-block;
                    margin: 5px;
                  }
                  #photoDisplayDiv .photoImgDiv {
                    height: 100px;
                    width: 100px;
                    padding:2px;
                    margin:2px;
                    text-align: center;
                    vertical-align: middle;
                    background-color: #fff;
                    display: table-cell;
                    border: 1px solid #0099FF;
                  }
                  #photoDisplayDiv img {
                    max-height: 100px;
                    max-width: 100px;
                  }
				  </style>
				  
				  <textarea rows="1" cols="1" style="display: none;" id="photoItemTemplate">
				    <div class="documentItemDiv">
				      <div {#if $T.isCover}style="border: 2px solid #0099FF"{#/if} class="photoImgDiv" >
                        <img src="{$T.root}/photo/{$T.product_id%100}/{$T.product_id}/{$T.file_uuid}.t"/>
				      </div>
				      <div style="text-align: right;">
				        {#if !$T.isCover}
				        <a onclick="viewJs.doMakeItAsCover({$T.id}, this);" style="cursor:pointer;color:blue;">设为封面</a>
				        {#/if}
				        &nbsp;
                        <a onclick="viewJs.doPhotoDelete({$T.id}, this);" style="cursor:pointer;color:blue;">删除</a>
				      </div>
				    </div>
				  </textarea>
                  <button type="button" onclick="viewJs.photoUpload();">上传</button>
                  <br/>
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

