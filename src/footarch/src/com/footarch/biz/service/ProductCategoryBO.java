package com.footarch.biz.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footarch.biz.entity.ProductCategory;
import com.footarch.biz.entity.ProductCategorySO;
import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.exception.BusinessException;



@Service("productCategoryBO")
@Scope("prototype")
@Transactional
public class ProductCategoryBO extends BaseServiceImpl {

    public ProductCategory create(ProductCategory productCategory) {  

    	//checkUnified(productCategory) ;
    	
    	Long pid = productCategory.getPro_product_category_id();
    	if (pid != null && lock(pid) == 0) {
    		throw new BusinessException(40101L) ;//40101', '父目录不存在，本操作无效！
    	}
        ProductCategory newItem = (ProductCategory) jdbcDao.insert(productCategory) ;
        
        return newItem;
    }
    public void update(ProductCategory productCategory) {

    	//checkUnified(productCategory) ;
    	
    	lock(productCategory.getPro_product_category_id()) ;
    	
        jdbcDao.update(productCategory) ;
    }
    
    /*
    private void checkUnified(ProductCategory productCategory)  {
    	ProductCategory old = new ProductCategory() ;
        //old.setCode_(productCategory.getCode_()) ;
        
        old = (ProductCategory)jdbcDao.find(old) ;
        
        if (old != null && !old.getId().equals(productCategory.getId())) {
        	throw new BusinessException(10105L) ;//'10105, '费用编码已经使用，请重新输入！'
        }
    }
    */

    public void delete(ProductCategory productCategory) {

    	lock(productCategory.getPro_product_category_id()) ;
    	
    	if (hasChildren(productCategory.getId())) {
    		throw new BusinessException("40102") ;// 40102', '子目录存在，本操作无效！
    	}
    	
        jdbcDao.delete(productCategory) ;
        
    }

    public void deleteAll(Long[] productCategoryIds) {
    	
    	for (Long oId:productCategoryIds) {
        	if (hasChildren(oId)) {
        		throw new BusinessException("40102") ;// 40102', '子目录存在，本操作无效！
        	}
    	}
    	
        ProductCategorySO criterion = new ProductCategorySO() ;
        criterion.setIds(productCategoryIds) ;
        jdbcDao.delete(ProductCategory.class, criterion) ;
        
    }
    
    private boolean hasChildren(Long productCategoryId) {
    	ProductCategory so = new ProductCategory() ;
    	so.setPro_product_category_id(productCategoryId) ;
    	return jdbcDao.find(so) != null ;
    }

    private int lock(Long productCategoryId) {
    	if (productCategoryId == null) {
    		return 0;
    	}
    	
    	ProductCategory o = new ProductCategory() ;
    	o.setOperate(ProductCategory.OPERATE_UPDATE_UNVERSION) ;
    	o.setId(productCategoryId) ;
    	o.addInclusions("id") ;
    	
    	return jdbcDao.update(o) ;
    }
    
    public ArrayPageList<ProductCategory> query(ProductCategorySO productCategorySO) {

        if (productCategorySO == null) {
        	productCategorySO = new ProductCategorySO() ;
        }
        productCategorySO.addAsc("pro_product_category_id") ;
        productCategorySO.addAsc("order_") ;
        productCategorySO.addAsc("name_cn") ;
        
        return (ArrayPageList<ProductCategory>)jdbcDao.query(productCategorySO, ProductCategory.class);
    }



    public ProductCategory get(Long id) {  
    	ProductCategory org = new ProductCategory() ;
    	org.setId(id) ;
        org = (ProductCategory) jdbcDao.get(org) ;
        
        
        return org;
    }
    
}
