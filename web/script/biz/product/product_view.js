
var productViewParent = $.extend(newView(), {
    list_url:root+"/biz/product_list.action" ,
    create_url:root + "/biz/product_create.action" ,
    update_url:root + "/biz/product_update.action" ,
    get_url:root + "/biz/product_get4Edit.action" ,
    delete_url:root + "/biz/product_delete.action" ,
    entityName:"product",
    
    init:function (){
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
        //E("sForm").resetForm();
        //E$("sForm").validator();

        this.states.a.onBeforeShow=function(_view, _state) {
            $("#viewContactBtn, #viewPartyBtn", viewJs.view).hide() ;
        } ;
        this.states.e.onBeforeShow=function(_view, _state) {
            $("#viewContactBtn, #viewPartyBtn", viewJs.view).show() ;
        } ;
        
        E$('product.full_desc').jqte();

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
             $("#colorTr, #photoTr, #sizeTr", viewJs.view).hide() ;
             E$("product.full_desc").jqteVal("");
             return ;
        }
        $("#colorTr, #photoTr, #sizeTr", viewJs.view).show() ;
        
        var _this = this;
        
        var idProperty = (this.idName==null?"id":this.idName) ;
        var params = {} ;
        params[idProperty] = id ;
        ajax(
            this.get_url, 
            params,
            function(data, textStatus){
            	_this.refreshEditForm(data);
            }
        );
    },
    
    refreshEditForm:function(data) {
    	this.entity = data;
        formDeserialize("eForm", data, {}) ;
        //viewJs.refreshCustomerServiceRep() ;
        //this.showPhotos(data.id, data.main_photo_uuid);
        this.showPhotos(data.productPhotoes);
        this.showColors(data.colors);
        this.showSizes(data.sizes);
        E$("product.full_desc").jqteVal(data["full_desc"]);
        E("eForm").resetForm();
    },
    
    saveNotList:function () {
    	var _this = this ;
    	this.save(function (_data) {
    		//_this.toPage("e");
    		if (V("product.id") == "") {
                _this.showBlock("e") ;	
                V("product.id", _data.id);
                $("#colorTr, #photoTr, #sizeTr", viewJs.view).show() ;
                _this.showPhotos([]);
                _this.showColors([]);
                _this.showSizes([]);
                //_this.typeOnChange();
                V("product.version_id", _data.version_id);
    		} else {
                viewJs.toPage('s') ;
                viewJs.list() ;
    		}
    	});
    } ,
    
    photoUpload:function(){
    	if (E$("colorListDiv").html() != "" && V("product.pro_product_id") == "") {
    		alert("请先选择颜色，再上传图片！");
    		return false ;
    	}
    	load("uploadFormWinDiv", root + "/biz/document/document_uploadForm.action", null, function(responseText, textStatus, XMLHttpRequest) {
            uploader.url = "/biz/productPhoto" ;
            uploader.getHtml=function(data) {
            	data.root = root;
            	data.isCover = (E$("photoDisplayDiv").html() == "") ;
                return parse(E$("photoItemTemplate").val(), data);
            }
            uploader.show(V("product.id"), 'p', 'photoDisplayDiv'); 
    	});
    },
    
    showPhotos:function(photoes) {
        
        var $photoDisplayDiv = E$("photoDisplayDiv") ;
        $photoDisplayDiv.html("");
        
        if (photoes == null){
            return ;
        }
        
        //uploader.url = "/biz/productPhoto" ;
        for (var i = 0 ; i < photoes.length ; i ++)
        {
            var photo = photoes[i];
            photo["root"] = root;
            //var data = {root:root, product_id:productId, id:ids[0], file_uuid:ids[1], isCover:(i == 0)};
            $photoDisplayDiv.append(parse(E$("photoItemTemplate").val(), photo));
        }
    },
    
    showPhotos2:function(productId, ids) {
        
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
                if (data.code == "0") {
                    //list() ;
                    $(linkObj).parent().parent().remove() ;
                	//_this.showPhotos(data.product_id, data.file_uuid) ;
                    _this.getProductBySize(V("product.size_"));
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
                    //var pPhoto = data.data ;
                    //_this.showPhotos(pPhoto.product_id, pPhoto.product_uuids) ;
                	if (V("product.pro_product_id") == "") {
                        _this.get(V("product.id"));
                	} else {
                        _this.getProductBySize(V("product.size_"));                		
                	}
                } else {
                    alert(data.message) ;
                }
            }, 
            false
        );
    },
    
    getProductByColor:function(color_) {

    	var params = {
    		"product.pro_product_id":this.getProProductId(),
    		"product.color_":color_,
    		"product.size_":V("product.size_")
    	} ;
        var _this = this ;

        ajax(
            root + "/biz/product_getProductByColorSize.action", 
            params,
            function(data, textStatus){
            	_this.refreshEditForm(data);
            }
        );
    },
    
    getProductBySize:function(size_) {

    	var params = {
    		"product.pro_product_id":this.getProProductId(),
    		"product.color_":V("product.color_"),
    		"product.size_":size_
    	} ;
        var _this = this ;

        ajax(
            root + "/biz/product_getProductByColorSize.action", 
            params,
            function(data, textStatus){
            	_this.refreshEditForm(data);
            }
        );
    },
    
    showColors:function(colors) {
        var pColor = V("product.color_");
        var $div = E$("colorListDiv") ;
        $div.html("");
        
        if (colors == null || colors == ""){
            return ;
        }
        
        for (var i = 0 ; i < colors.length ; i ++)
        {
            var data = colors[i];
            data.isSelected = (pColor == data.color_);
            $div.append(parse(E$("colorListTemplate").val(), data));
        }
    },

    
    showSizes:function(sizes) {
        var pSize = V("product.size_");
        var $div = E$("sizeListDiv") ;
        $div.html("");
        
        if (sizes == null || sizes == ""){
            return ;
        }
        
        for (var i = 0 ; i < sizes.length ; i ++)
        {
            var data = sizes[i];
            data.isSelected = (pSize == data.size_);
            $div.append(parse(E$("sizeListTemplate").val(), data));
        }
    },
    
    doColorAdd:function() {
    	
    	var colorNew = V("product.color_new");
    	
    	if (colorNew == '') {
    		alert("请输入要新加的颜色！");
    		E$("product.color_new").focus();
    		return false ;
    	}
    	
    	var params = {
    		"product.pro_product_id":this.getProProductId(),
    		"product.color_":colorNew
    	} ;

        var _this = this ;
    	
        ajax(
        	root + "/biz/product_addColor.action", 
            params,
            function(data, textStatus){
            	//alert(data.code);
            	if (data.code == 0) {
            		_this.refreshEditForm(data.data);            		
            	}
            }
        );
    },

    
    doColorDelete:function (color_) {
        
        if (!window.confirm("是否确定要删除？")) {
            return ;
        }
    
        var _this = this ;
        
    	var params = {
    		"product.pro_product_id":this.getProProductId(),
    		"product.color_":color_
    	} ;
        
        ajax(
            root + "/biz/product_removeColor.action",
            params,
            function(data, textStatus){
                if (data.code == "0") {
                    _this.refreshEditForm(data.data);
                } else {
                	alert(data.message) ;
                }
            }, 
            false
        );
    },
    
    doSizeAdd:function() {

    	var sizeNew = V("product.size_new");
    	
    	if (sizeNew == '') {
    		alert("请输入要新加的尺码！");
    		E$("product.size_new").focus();
    		return false ;
    	}
    	
    	var params = {
    		"product.pro_product_id":this.getProProductId(),
    		"product.size_":V("product.size_new"),
    		"product.color_":V("product.color_")
    	} ;

        var _this = this ;
    	
        ajax(
        	root + "/biz/product_addSize.action", 
            params,
            function(data, textStatus){
            	//alert(data.code);
            	if (data.code == 0) {
            		_this.refreshEditForm(data.data);            		
            	} else {
                	alert(data.message) ;
                }
            }, 
            false
        );
    },

    
    doSizeDelete:function (size_) {
        
        if (!window.confirm("是否确定要删除？")) {
            return ;
        }
    
        var _this = this ;
        
    	var params = {
    		"product.pro_product_id":this.getProProductId(),
    		"product.size_":size_,
    		"product.color_":V("product.color_")
    	} ;
        
        ajax(
            root + "/biz/product_removeSize.action",
            params,
            function(data, textStatus){
                if (data.code == "0") {
                    _this.refreshEditForm(data.data);
                } else {
                	alert(data.message) ;
                }
            }, 
            false
        );
    },
    
    getProProductId:function() {
    	return (V("product.pro_product_id") == ""?V("product.id"):V("product.pro_product_id"));
    }
}) ;
