package com.footarch.biz.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;
import com.footarch.biz.entity.Product;
import com.footarch.biz.entity.ProductSO;

@Service("productBO")
@Scope("prototype")
@Transactional
public class ProductBO extends BaseServiceImpl {
    public Product create(Product product) {  
    	Product newObj = (Product) jdbcDao.insert(product) ;
        return newObj;
    }
    
    public void update(Product product) {  
    	product.addExclusions("record_status") ;
        jdbcDao.update(product) ;  
    }
    
    public void delete(Product product) {
    	/*
    	product.addInclusions("record_status") ;
    	product.setRecord_status(C.RECORD_STATUS_CANCEL) ;
        jdbcDao.update(product) ;
        */
        jdbcDao.delete(product) ;
        getProductPhotoBO().deleteByProductId(product.getId()) ;
    }
    
    public void delete(Long[] ids){
    	ProductSO so = new ProductSO() ;
    	so.setIds(ids) ;
    	//country.addInclusions("record_status") ;
    	//country.setRecord_status(C.RECORD_STATUS_CANCEL) ;
        jdbcDao.delete(Product.class, so) ;

        ProductPhotoBO bo = getProductPhotoBO() ;
        for (Long id:ids){	
        	bo.deleteByProductId(id);
        }
    }
    
    public ArrayPageList<Product> query(ProductSO productSO) {
    	if (productSO == null) {
    		productSO = new ProductSO();
    	}
    	//productSO.setRecord_status(C.RECORD_STATUS_ACTIVE);
    	productSO.addDesc("name_cn") ;
    	//productSO.addAsc("id") ;
    	//productSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE);
        return (ArrayPageList<Product>)jdbcDao.query(productSO, Product.class);
    }
    
    public Product get(Long id) { 
    	if (id == null) {// id is require
    		throw new BusinessException("product id is required") ;
    	}
    	Product product = new Product() ;
    	product.setId(id) ;
        product = (Product) jdbcDao.get(product) ;
                
        return product;
    }
    
    private ProductPhotoBO getProductPhotoBO() {
    	return (ProductPhotoBO)CodeHelper.getAppContext().getBean("productPhotoBO") ;
    }
}
