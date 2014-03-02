package com.footarch.biz.web;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.globalwave.base.web.ResponseMessage;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.system.web.annotations.Pid;
import com.footarch.biz.entity.ProductCategory;
import com.footarch.biz.entity.ProductCategorySO;
import com.footarch.biz.service.ProductCategoryBO;
import com.opensymphony.xwork2.Preparable;

@Service("biz_productCategoryAction")
@Scope("prototype")
public class ProductCategoryAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 7244882365197775441L;
    
    private ProductCategoryBO productCategoryBO ;
    private ProductCategory productCategory ;
    private ProductCategorySO productCategorySO ; 
    
    public String execute() throws Exception {        
        
        return this.list();        
        
    }
    

    @Pid(value=4001,log=false)
    public String list() throws Exception {  
    	//productCategorySO.setPro_productCategory_id_exclude(0L) ;// Just for loss, 取二级组织
        ArrayPageList<ProductCategory> pageList = productCategoryBO.query(productCategorySO) ;

        renderList(pageList) ; 
        
        return null ;  
        
    }

    @Pid(value=4001,log=false)
    public String get() throws Exception {  

    	ProductCategory org = productCategoryBO.get(this.id) ;

    	renderObject(org, null) ; 
        return null ;  
    }

    @Pid(value=4001)
    public String create()  throws Exception {        

    	//productCategory.setPro_productCategory_id(1L) ;// just for loss
        
        Object newProductCategory = productCategoryBO.create(productCategory) ;

        reloadCache();
        
        renderObject(newProductCategory, ResponseMessage.KEY_CREATE_OK) ;
        return null;    
        
    }

    @Pid(value=4001)
    public String update()  throws Exception {     

        
    	//productCategory.setPro_productCategory_id(1L) ;// just for loss
    	
        productCategoryBO.update(productCategory) ;

        reloadCache();


        renderObject(productCategory, ResponseMessage.KEY_UPDATE_OK) ;
        
        return null;    
        
    }

    @Pid(value=4001)
    public String delete()  throws Exception {

        if (this.ids == null) { 
            productCategoryBO.delete(productCategory) ;
        } else {
            productCategoryBO.deleteAll(ids) ;
        }

        reloadCache();
        
        renderObject(productCategory, ResponseMessage.KEY_DELETE_OK) ;
        
        return null;    
        
    }


	private void reloadCache() throws Exception {
		//CodeHelper.reload("ProductCategory") ;
        CodeHelper.reload("ProProductCategory") ;
        //CodeHelper.reload("ProductCategorySub") ;
	}
/*
    
    @Pid(value=101)
    public String userBelongTo()  throws Exception {
        ArrayPageList<ProductCategory> pageList = 
            productCategoryBO.userBelongTo(user_id) ;

        renderXML(pageList.asXML()) ;        
        return null;    
        
    }
 */   
    public void prepare() throws Exception {
        
    }

    public void setProductCategoryBO(ProductCategoryBO productCategoryBO) {
		this.productCategoryBO = productCategoryBO;
	}

    public ProductCategory getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(ProductCategory productCategory) {
        this.productCategory = productCategory;
    }

    public ProductCategorySO getProductCategorySO() {
        return productCategorySO;
    }

    public void setProductCategorySO(ProductCategorySO productCategorySO) {
        this.productCategorySO = productCategorySO;
    }

}
