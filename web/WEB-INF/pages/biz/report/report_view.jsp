<%@page import="com.globalwave.system.entity.SessionUser"%>
<%@page import="com.globalwave.common.U"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
java.util.Date now = U.currentDate() ;
String dateForm = U.yyyyMMdd_(U.firstDayOfMonth(now)) ;
String dateTo = U.yyyyMMdd_(U.lastDayOfMonth(now)) ;
SessionUser sUser = (SessionUser)session.getAttribute(SessionUser.SESSION_PK) ;
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    list_url:root+"/biz/report_queryOrder.action" ,
    create_url:root + "/biz/report_create.action" ,
    update_url:root + "/biz/report_update.action" ,
    get_url:root + "/biz/report_get.action" ,
    delete_url:root + "/biz/report_delete.action" ,
    entityName:"report",

    initFlags:[],
    listData:[],


    operatorJson : <%=request.getAttribute("operatorJson")%>,
    salesJson : <%=request.getAttribute("salesJson")%>,
    reportTypeJson : <%=request.getAttribute("reportTypeJson")%>,
    
    states:{
        blocks:['listDiv','pagination','previewDiv'],
        s:{
            blocks:['listDiv','pagination'],
            to:{},// 转移限制
            onShow:function(_view, _state) {
            
            },
            onHide:function(_view, _state) {
                _view.resetSearchForm();
            }
        },
        
        pv:{
            blocks:['previewDiv'],
            to:{
            },// 转移限制
            onShow:function(_view, _state) {
            },
            onHide:function(_view, _state) {
            }
        },
        
        ex:{
            blocks:false,
            to:{
            },// 转移限制
            onShow:function(_view, _state) {
                //_view.get(-1) ;
            },
            onHide:function(_view, _state) {
                //_view.resetEditForm();
            }
        }
    },
    
    init:function (){
        //this.initSelect() ;
        this.pageIndex = E("reportSO.pageIndex") ;

        fillOptions({
        	id:"reportSO.report_type", 
        	//dictName:"BIZ.Report.report_type", 
            data:this.reportTypeJson,
        	firstLabel:"--请选择--", 
            valueProperty:"id",
        	textProperty:"desc_"}) ;//  改为字典取值
                
        this.initDataGrid("reportTB", {height:"280px"}) ;
        this.initPreviewTable() ;
        
        E$("reportSO.start_on").datepicker({dateFormat: "yy-mm-dd" });
        E$("reportSO.end_on").datepicker({dateFormat: "yy-mm-dd" });
        


        E$("reportSO.agent_id_1").combobox2({
            data:filter(g$dict.Organization, {level_:1,record_status:'A'}),
            firstLabel:"Choose",
            valueProperty:"PK_ID", 
            idProperty:"PK_ID", 
            textProperty:["name_"],
            remoteFilter:{url:root + "/biz/report_distinctOrder.action", distinctColumn:"agent_id_1", form:E$("sForm")}
        }) ;
        

        E$("reportSO.agent_id_2").combobox2({
            data:filter(g$dict.Organization, {level_:2,record_status:'A'}),
            firstLabel:"Choose",
            valueProperty:"PK_ID", 
            idProperty:"PK_ID", 
            textProperty:["name_"],
            remoteFilter:{url:root + "/biz/report_distinctOrder.action", distinctColumn:"agent_id_2", form:E$("sForm")}
        }) ;
        

        E$("reportSO.agent_id_3").combobox2({
            data:filter(g$dict.Organization, {level_:3,record_status:'A'}),
            firstLabel:"Choose",
            valueProperty:"PK_ID", 
            idProperty:"PK_ID", 
            textProperty:["name_"],
            remoteFilter:{url:root + "/biz/report_distinctOrder.action", distinctColumn:"agent_id_3", form:E$("sForm")}
        }) ;
        

        E$("reportSO.agent_id_4").combobox2({
            data:filter(g$dict.Organization, {level_:4,record_status:'A'}),
            firstLabel:"Choose",
            valueProperty:"PK_ID", 
            idProperty:"PK_ID", 
            textProperty:["name_"],
            remoteFilter:{url:root + "/biz/report_distinctOrder.action", distinctColumn:"agent_id_4", form:E$("sForm")}
        }) ;

        E$("sForm").validator();
        E("sForm").setFirstFocus();
        
        this.reportTypeOnChange(-1);

    },
    
    
    initPreviewTable:function () {
       // this.initDataGrid("previewTB_56", {height:"400px"}) ;
    },

    toPreview:function() {
        if (V("reportSO.report_type") == "") {
            alert("请选择[报表分类]!") ;
            E("reportSO.report_type").focus();
            return ;
        }
        
        var type = V("reportSO.report_type") ;
        
        if (type != 56 && type != 57 && type != 60) {
            alert("本报表预览未实现！") ;
            return ;
        }
        
        
        //E('sForm').action=root+"/biz/report_preview.action" ;
        //E('sForm').submit(); 

        E$("previewDiv").children().each(function(i, elem) {
        	$(elem).hide() ;
        }) ;
        E$("previewPageContainerDiv_" + type).show() ;

        load(
            "previewPageContainerDiv_" + type, 
            root + "/biz/report_previewPage.action", 
            {type:type}, 
            function () {
		        ajax(
		        	root+"/biz/report_preview.action", 
		            E$("sForm").serialize(),
		            function(data, textStatus){
		        		var isUseRender = false ;// 使用Render方法展现数据
		                eval("if (viewJs.preview_" + type + "_render) {viewJs.preview_" + type + "_render(data);isUseRender = true ;}") ;
		                if (isUseRender) {
		                	return ;
		                }
		                
		                eval("if (viewJs.preview_" + type + "_fun) {viewJs.preview_" + type + "_fun(data.items);}") ;
		                
		        		if (data.total) {
		        		    data.items[data.items.length] = {name_cn:"",order_count:"",container_20:"",container_40:"",container_45:"",container_total:"",teu:"",usd_balance:"",cny_balance:"",balance:"" } ;
		        		    var total = $.extend({},data.total) ;
		        		    total.items = null ;
		        		    total.name_cn = "总计";
		        			data.items[data.items.length] = total ;
		        		}
		        		//alert( type);
		                viewJs.addRows("previewTB_" + type, data.items, {deep:0}) ;
		                //lastIndex = Math.ceil(data.total/parseInt(E(viewJs.entityName+"SO.pageSize").value));
		                //viewJs.setPaginationInfo(data.total, data.pageIndex, lastIndex) ;
		            }
		        );
            },
            "previewDiv",
            false
        ) ;
    
    	this.toPage("pv") ;
    },


    toExport:function() {
        this.toPage("ex") ;
        if (V("reportSO.report_type") == "") {
            alert("请选择[报表分类]!") ;
            E("reportSO.report_type").focus();
            this.toPage(this.preState) ;
            return ;
        }
        
        var type = V("reportSO.report_type") ;
        
        E('sForm').action=root + "/biz/report_export.action" ;
        E('sForm').submit(); 
        setTimeout(this.onExported,500) ;
    },
    
    onExported:function () {
    	if (viewJs.preState != null) {// when init, not to any page    		
    		viewJs.toPage(viewJs.preState) ;
    	}
    },

    reportTypeOnChange:function(_type) {
    	$("div", $("#reportOptionsTr")).each(function (i, elem) {
    		var $div = $(elem) ;
    		
    		if ($div.attr("reportType") == null) {
    			return ;
    		}
    		
    		var $input = $("input", $div) ;
    		
    		var isRightType = ($.inArray(_type, $div.attr("reportType").split(",")) >= 0) ;
    		
    		if (isRightType) {
    			$div.show() ;
    		} else {
    			$div.hide() ;
    		}
    		
            $input.each(function (j, input) {
                $(input).attr("disabled", !isRightType) ;
            });
    	});
    	
    	
    },


    resetDate: function (value_) {
        
        var now = new Date() ;

        if (value_ != -1) {
            V("reportSO.end_on", now.format('yyyy-MM-dd')) ;
        }
        
        if (value_ == 30) {
            now.setDate(1) ;
            V("reportSO.start_on", now.format('yyyy-MM-dd')) ;
        } else if (value_ == 60) {
            now.setMonth(now.getMonth() - 2) ;
            V("reportSO.start_on", now.format('yyyy-MM-dd')) ;
        } else if (value_ == 365) {
            now.setMonth(0) ;
            now.setDate(1) ;
            V("reportSO.start_on", now.format('yyyy-MM-dd')) ;
        }
        
    },
    
    reset:function () {
    	E("sForm").reset() ;
    	this.reportTypeOnChange(-1);
    },
    
    viewDetail:function (id) {
        window.open('biz/order_list.action?tid=' + id, '');

    	return true;
    }

}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <ul class="hor_nav" id="horNav">
    <li class="active"><span onclick="viewJs.toSearch();" tag="s">查询</span></li>
    <!-- 
    <li><span onclick="viewJs.toPreview();" tag="pv">预览</span></li>
     -->
    <li><span onclick="viewJs.toExport();" tag="ex">导出</span></li>
    
    <span class="admin_act" id="pagination">
        <div class="admin_btns">
            
        </div>
        <div class="admin_pages">
            <label id="paginationInfo">总记录数为0条，当前为第1页，共0页&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <a href="javascript:viewJs.first();">首页</a>
            <a href="javascript:viewJs.preview();">上页</a>
            <a href="javascript:viewJs.next();">下页</a>
            <a href="javascript:viewJs.last();">末页</a>
        </div>
    </span>
  </ul>
      
  <div id="listDiv">
  
      <form method="post" id="sForm" name="sForm" onsubmit="return false;" style="margin: 0" target="_blank">
        <input name="reportSO.pageIndex" id="reportSO.pageIndex" value="1" type="hidden" />
        <input name="reportSO.pageSize" id="reportSO.pageSize" value="100" type="hidden" />
        <input type="hidden" name="reportSO.record_status" value="A" />
        <table style="border: 0; padding: 0; border-collapse: 0;width: 100%;" cellspacing="0" cellpadding="0" class="formgrid">
          
          <tr>
            <td class="label">下单日期：</td>
            <td colspan="3">
              <input name="reportSO.start_on" id="reportSO.start_on" value="<%=dateForm %>" type="text" style="width: 65px;" />
              -
              <input name="reportSO.end_on" id="reportSO.end_on" value="<%=dateTo %>" type="text"  style="width: 65px;"/>
            </td>
            <td class="label">订单号：</td>
            <td><input type="input" name="reportSO.order_no"/></td>
            <td class="label">订单状态：</td>
            <td> 
              <select name="orderSO.temp_ship_stauts" id="orderSO.temp_ship_stauts">
                <option value="">Choose</option>
                <option value="1">已装船</option>
                <option value="2">未装船</option>
              </select>
            </td>
            <td class="label">结算状态：</td>
            <td>
              <select name="orderSO.temp_search_status" id="orderSO.temp_search_status">
                <option value="">Choose</option>
                <option value="1">已开船未转交</option>
                <option value="5">已结算</option>
                <option value="2">已结算盈利</option>
                <option value="3">已结算无盈利</option>
                <option value="4">未开船有收付</option>
              </select>
            </td>
            <td class="label"></td>
            <td></td>
          </tr>


          <tr>
            <td class="label">省级代理：</td>
            <td><input type="input" name="reportSO.agent_id_1" id="reportSO.agent_id_1"/></td>
            <td class="label">市级代理：</td>
            <td><input type="input" name="reportSO.agent_id_2" id="reportSO.agent_id_2"/></td>
            <td class="label">区级代理：</td>
            <td><input type="input" name="reportSO.agent_id_3" id="reportSO.agent_id_3"/></td>
            <td class="label">终端代理：</td>
            <td><input type="input" name="reportSO.agent_id_4" id="reportSO.agent_id_4"/></td>
            <td class="label"></td>
            <td></td>
            <td class="label"></td>
            <td></td>
          </tr>


                
          <tr id="reportOptionsTr">
           
            <td class="label">报表分类：</td>
            <td colspan="3">
              <select name="reportSO.report_type" id="reportSO.report_type" onchange="viewJs.reportTypeOnChange(this.value)"></select>
            </td>
           
            <td class="label">
              <div reportType="51">到帐时间：</div>
              <!-- 车队仓库 报关行   内部代理  船东代理  海外代理  杂项 -->
              <div reportType="106xxx">车队仓库：</div>
              <div reportType="104xx">报关行：</div>
              <div reportType="101xx">船东代理：</div>
              <div reportType="54xxx">海外代理：</div>
              <div reportType="53xx">内部代理：</div>
              <div reportType="107xx">杂项：</div>
            </td>
            <td colspan="2">
              <div reportType="51">
                <input name="reportSO.entry_date_from" id="reportSO.entry_date_from" type="text" style="width: 65px;" title="到账开始时间" />
                -
                <input name="reportSO.entry_date_to" id="reportSO.entry_date_to" type="text" style="width: 65px;" title="到账结束时间" />
              </div>
              <div reportType="53xx,54xxx,101xx,104xx,106xxx">
                <input name="reportSO.ar_ap_company_id"  id="ar_ap_inner_company_id"/>
              </div>
              <div reportType="107xx">
              </div>
              <!-- 
              <input name="reportSO.invoice_date_from" id="reportSO.invoice_date_from" value="<%=dateTo %>" type="text" style="width: 65px;" title="开票开始时间"/>
              <input name="reportSO.invoice_date_to" id="reportSO.invoice_date_to" value="<%=dateTo %>" type="text" style="width: 65px;" title="开票结束时间"/>
               -->
            </td>
            <td class="label"><!-- 金额差欠 -->
              <div reportType="53xx,54xxx,101xx,104xx,106xx">(往来单位)</div>
            </td>
            <td></td>
            <td class="label"></td>
            <td></td>
          </tr>
           
          
          <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td colspan="4">
              <button onclick="viewJs.list();" type="button" accesskey="Q" >查 找(Q)</button>
              <!-- 
              <button onclick="viewJs.toPreview()" accesskey="P" >预览(P)</button>
               -->
              <button onclick="viewJs.toExport();" type="button" accesskey="E" >导 出(E)</button>
              <button onclick="viewJs.reset();" type="button" accesskey="R" >重置(R)</button>
            </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr style="height: 0px;padding: 0px;margin: 0px;">
            <td style="width:70px" ></td>
            <td style="width:105px"></td>
            <td style="width:50px"></td>
            <td style="width:105px"></td>
            <td style="width:85px"></td>
            <td style="width:105px"></td>
            <td style="width:70px"></td>
            <td style="width:95px"></td>
            <td style="width:65px"></td>
            <td style="width:115px"></td>
            <td style="width:80px"></td>
            <td style="width:120px"></td>
          </tr>
        </table>
      
      
	    <table id="reportTB" title="订单列表" class="datagrid">
	        <thead>
	          <tr>
	            <th width="8%">订单号</th>
	            <th width="10%">省级代理</th>
	            <th width="10%">市级代理</th>
	            <th width="10%">区级代理</th>
	            <th width="10%">终端代理</th>
	            <th width="10%">下单日期</th>
	            <th width="8%">状态</th>
	          </tr>
	        </thead>
	        
	        <tbody id="listBody" >
	        </tbody>
	         
	        <tbody style="display:none;" >
	          <tr>
	            <td>
	              <textarea rows="1" cols="1" id="templateBody" jTemplate="true">
		              <tr id="{$T.id}" ondblclick="viewJs.viewDetail({$T.id})">
                        <td><a href="javascript:" onclick="viewJs.viewDetail({$T.id})" >{$T.order_no}</a></td>
		                <td>{dVal("Organization", "name_", {PK_ID:$T.agent_id_1})}</td>
		                <td>{dVal("Organization", "name_", {PK_ID:$T.agent_id_2})}</td>
		                <td>{dVal("Organization", "name_", {PK_ID:$T.agent_id_3})}</td>
		                <td>{dVal("Organization", "name_", {PK_ID:$T.agent_id_4})}</td>
                        <td>{$T.time_place}</td>
		                <td>{$T.status}</td>
		              </tr>
	              </textarea>
	            </td>
	          </tr>
	        </tbody>
	    </table>
      </form>

  </div>
    
  <div id="previewDiv" style="display:none;">

    
  </div>
  

</div>
