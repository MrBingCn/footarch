<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
String root = request.getContextPath();
%>

<link type="text/css" rel="stylesheet" href="<%=root%>/plugin/jQuery-TE_v.1.4.0/jquery-te-1.4.0.css">
<script type="text/javascript" src="<%=root%>/plugin/jQuery-TE_v.1.4.0/jquery-te-1.4.0.min.js" charset="utf-8"></script>

<script type="text/javascript" src="<%=root%>/script/biz/product/product_view.js" charset="utf-8"></script>
<script>

var g$v<%=view_id%> = $.extend(productViewParent, {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>
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
      <input type="hidden" name="product.pro_product_id" id="product.pro_product_id"/>
      
  
      <table cellspacing="0" cellpadding="0" width="100%" class="layoutgrid">
        <tr valign="top">
          <td valign="top">
            <table cellspacing="0" cellpadding="0" width="100%" class="formgrid">
              <tr>
                <td class="label" width="8%">中文名称：</td>
                <td width="17%"><input type="text" name="product.name_cn" id="product.name_cn" required="required" maxlength="250"/></td>
                <td class="label" width="8%">英文名称：</td>
                <td width="17%"><input type="text" name="product.name_en" maxlength="250"/></td>
                
                <td class="label" width="8%">分类：</td>
                <td width="17%">
                  <select name="product.product_category_id" id="product.product_category_id" required="required">
                  </select>
                </td>
                <td class="label" width="8%">品牌：</td>
                <td width="17%">
                  <select name="product.brand_id" id="product.brand_id">
                  </select>
                </td>
              </tr>
              
              <tr>
                <td class="label">货号：</td>
                <td><input type="text" name="product.code_"  maxlength="50" required="required"/></td>
                <td class="label">关键字：</td>
                <td><input type="text" name="product.keywords_"  maxlength="50"/></td>
                
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
                

                <td class="label">状态：</td>
                <td>
                  <select name="product.record_status" id="product.record_status" required="required">
                  </select>
                </td>
                <td class="label"></td>
                <td></td>
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
              
              <tr id="colorTr">
                <td class="label">颜色：</td>
                <td colspan="7"> 
                  <style>
                   .itemDiv {
                    display: inline-block;
                    margin: 5px;
                  }
                   .itemContentDiv {
                    padding:2px;
                    margin:2px;
                    text-align: center;
                    vertical-align: middle;
                    background-color: #fff;
                    min-width:60px;
                    display: table-cell;
                    border: 1px solid #0099FF;
                  }
                  </style>
                  <textarea rows="1" cols="1" style="display: none;" id="colorListTemplate">
                    <div class="itemDiv">
                      <div style="display: inline-block;cursor: pointer;{#if $T.isSelected}border: 2px solid #0099FF{#/if}" class="itemContentDiv" onclick="viewJs.getProductByColor('{$T.color_}')">
                        {$T.color_}
                      </div>
                      <button type="button" onclick="viewJs.doColorDelete('{$T.color_}', this);" style="margin: 0 0 0 -6px;height: 24px; line-height: 20px;">-</button>
                    </div>
                  </textarea>

                  <input type="hidden" name="product.color_" id="product.color_" />
                  <!-- 
                  <a onclick="viewJs.get(V('product.id'), this);" style="cursor:pointer;color:blue;display: inline-block;">[N/A]</a>
                   -->
                  <div id="colorListDiv" style="display: inline-block;"></div>
                  <div style="display: inline-block;">
                    <input type="text" name="product.color_new" id="product.color_new" maxlength="10" style="width: 80px;"/>
                    <button type="button" onclick="viewJs.doColorAdd(this);" style="margin: 0 0 0 -5px;height: 24px; line-height: 20px;">+</button>
                  </div>
                </td>
              </tr>
              
              <tr id="photoTr">
                <td class="label" valign="top">图片：</td>
                <td colspan="7" valign="top">
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
                      <div {#if $T.document_type == 'm'}style="border: 2px solid #0099FF"{#/if} class="photoImgDiv" >
                        <img src="{$T.root}/photo/{$T.product_id%100}/{$T.product_id}/{$T.file_uuid}.t"/>
                      </div>
                      <div style="text-align: right;">
                        {#if $T.document_type != 'm'}
                        <a onclick="viewJs.doMakeItAsCover({$T.id}, this);" style="cursor:pointer;color:blue;">设为封面</a>
                        {#/if}
                        &nbsp;
                        <a onclick="viewJs.doPhotoDelete({$T.id}, this);" style="cursor:pointer;color:blue;">删除</a>
                      </div>
                    </div>
                  </textarea>
                  
                  <div id="photoDisplayDiv" style="display:inline-block;"></div>
                  <button type="button" onclick="viewJs.photoUpload();">上传</button>
                </td>
              </tr>
              
              <tr id="sizeTr">
                <td class="label">尺码：</td>
                <td colspan="7">
                  <textarea rows="1" cols="1" style="display: none;" id="sizeListTemplate">
                    <div class="itemDiv">
                      <div style="display: inline-block;cursor: pointer;{#if $T.isSelected}border: 2px solid #0099FF{#/if}" class="itemContentDiv" onclick="viewJs.getProductBySize('{$T.size_}')">
                        {$T.size_}
                      </div>
                      <button type="button" onclick="viewJs.doSizeDelete('{$T.size_}', this);" style="margin: 0 0 0 -6px;height: 24px; line-height: 20px;">-</button>
                    </div>
                  </textarea>

                  <input type="hidden" name="product.size_" id="product.size_" />
                  <!-- 
                  <a onclick="viewJs.get(V('product.id'), this);" style="cursor:pointer;color:blue;display: inline-block;">[N/A]</a>
                   -->
                  <div id="sizeListDiv" style="display: inline-block;"></div>
                  <div style="display: inline-block;">
                    <input type="text" name="product.size_new" id="product.size_new" maxlength="10" style="width: 80px;"/>
                    <button type="button" onclick="viewJs.doSizeAdd(this);" style="margin: 0 0 0 -5px;height: 24px; line-height: 20px;">+</button>
                  </div>
                </td>
              </tr>
              
              
              <tr>
                <td class="label" valign="top">描述：</td>
                <td colspan="7">
                  <textarea name="product.full_desc" id="product.full_desc" style="height: 60px;"></textarea>
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

