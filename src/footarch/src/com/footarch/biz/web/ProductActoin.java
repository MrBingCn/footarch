package com.footarch.biz.web;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.globalwave.base.web.ResponseMessage;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.system.web.annotations.Pid;
import com.footarch.biz.entity.Product;
import com.footarch.biz.entity.ProductSO;
import com.footarch.biz.service.ProductBO;
import com.opensymphony.xwork2.Preparable;

@Service("biz_productAction")
@Scope("prototype")
public class ProductActoin extends BaseAction implements Preparable {
	private ProductBO productBO;
	private ProductSO productSO;
	private Product product;
	
	@Pid(value=Pid.LOGINED,log=false)
    public String list() throws Exception {  
        ArrayPageList<Product> pageList = productBO.query(productSO) ;
        /*
        List<String> l = new ArrayList<String>();
    	l.add("id");
    	l.add("name");
    	l.add("area");*/
        renderList(pageList) ; 
        return null ;  
    }

	@Pid(value=Pid.LOGINED,log=false)
    public String get() throws Exception {  
    	Product product = productBO.get(this.id) ;

    	renderObject(product, null) ; 
        return null ;  
    }

    @Pid(value=4001)
    public String create()  throws Exception {        
        Object newObj = productBO.create(product) ;
        CodeHelper.reload("Product") ;
        renderObject(newObj, ResponseMessage.KEY_CREATE_OK) ;
        return null;    
    }

    @Pid(value=4001)
    public String update()  throws Exception {     
    	/*product.addInclusions("name");
    	product.addInclusions("area");*/
        productBO.update(product) ;
        CodeHelper.reload("Product") ;
        renderObject(product, ResponseMessage.KEY_UPDATE_OK) ;
        return null;    
    }

    @Pid(value=4001)
    public String delete()  throws Exception {
        if (this.ids == null) { 
            productBO.delete(product) ;
        } else {
            productBO.delete(ids) ;
        }
        CodeHelper.reload("Product") ;
        renderObject(product, ResponseMessage.KEY_DELETE_OK) ;
        return null;    
    }
    
	public ProductBO getProductBO() {
		return productBO;
	}

	public void setProductBO(ProductBO productBO) {
		this.productBO = productBO;
	}

	public ProductSO getProductSO() {
		return productSO;
	}

	public void setProductSO(ProductSO productSO) {
		this.productSO = productSO;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

}
