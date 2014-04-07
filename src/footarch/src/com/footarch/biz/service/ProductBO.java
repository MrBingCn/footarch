package com.footarch.biz.service;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.base.annotations.Comparison;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.C;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;
import com.footarch.biz.entity.Product;
import com.footarch.biz.entity.ProductSO;

@Service("productBO")
@Scope("prototype")
@Transactional
public class ProductBO extends BaseServiceImpl {

    public ArrayPageList<Product> query(ProductSO productSO) {
    	if (productSO == null) {
    		productSO = new ProductSO();
    	}
    	
    	productSO.setPro_product_id_is_NULL(Comparison.IS_NOT_NULL);
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
    
    public Product get4Edit(Long id) { 
    	if (id == null) {// id is require
    		throw new BusinessException("product id is required") ;
    	}
    	Product product = new Product() ;
    	product.setId(id) ;
        product = (Product) jdbcDao.get(product) ;
                
        Product proProduct = null ;
        if (product.getPro_product_id() != null) {
        	proProduct = this.get(product.getPro_product_id()) ;
        	product.setPro_product(proProduct) ;
        	copyPropertyFromParent(product, proProduct);
        	product.setPro_product(proProduct) ;
        } else {
        	proProduct = product ;
        }

        this.getRelateInfo(product, proProduct.getId()) ;
        
        return product;
    }

    public Product getProductByColorSize(Product product) {

    	product.setRecord_status(C.RECORD_STATUS_ACTIVE) ;
    	
        Product result = (Product) jdbcDao.find(product) ;
                
        if (result == null) {
        	product.setSize_(null);
        	result = (Product) jdbcDao.find(product) ;
        }
        
        Product proProduct = null ;
        if (result.getPro_product_id() != null) {
        	proProduct = this.get(result.getPro_product_id()) ;
        	copyPropertyFromParent(result, proProduct);
        	result.setPro_product(proProduct) ;
        } else {
        	proProduct = result ;
        }
  
        this.getRelateInfo(result, proProduct.getId()) ;
        
        return result;
    }

    private void getRelateInfo(Product product, Long proId) {
    	Product subProduct = new Product() ;
    	subProduct.setPro_product_id(proId) ;

        product.setColors((ArrayPageList<Product>)jdbcDao.queryName("bizSQLs:queryProductColors", subProduct, Product.class));
        
    	String color_ = null ;
    	if (product.getColors().size() != 0) {
    		color_ = product.getColor_() ;
    	}
    	
    	product.setProductPhotoes(getProductPhotoBO().query(proId, color_)) ;
    	
        
        subProduct.setColor_(color_);
        product.setSizes((ArrayPageList<Product>)jdbcDao.queryName("bizSQLs:queryProductSizes", subProduct, Product.class));
    }
    

    public Product create(Product product) {  
    	Product newObj = (Product) jdbcDao.insert(product) ;
        return newObj;
    }
    
    
    public void update(Product product) {  
    	
    	// just update parent entity!
    	if (product.getPro_product_id() != null) {
    		product.setId(product.getPro_product_id()) ;
    		product.setPro_product_id(null) ;
    	}
    	
    	
    	product.addExclusions("main_photo_uuid") ;
        jdbcDao.update(product) ;  
    }
    
    public void delete(Product product) {
    	/*
    	product.addInclusions("record_status") ;
    	product.setRecord_status(C.RECORD_STATUS_CANCEL) ;
        jdbcDao.update(product) ;
        */
    	product = get4Edit(product.getId());

    	if (product.getSizes().size() > 0) {
    		throw new BusinessException(10000L, product.getName_cn());// 请删除{0}的码数，再删除产品
    	}
    	
    	if (product.getColors().size() > 0) {
    		throw new BusinessException(10000L, product.getName_cn());// 请删除{0}的颜色，再删除产品
    	}
    	
        jdbcDao.delete(product) ;
        getProductPhotoBO().deleteByProductId(product.getId()) ;
    }
    
    public void delete(Long[] ids){
    	/*
    	ProductSO so = new ProductSO() ;
    	so.setIds(ids) ;
    	//country.addInclusions("record_status") ;
    	//country.setRecord_status(C.RECORD_STATUS_CANCEL) ;
        jdbcDao.delete(Product.class, so) ;

        ProductPhotoBO bo = getProductPhotoBO() ;
        for (Long id:ids){	
        	bo.deleteByProductId(id);
        }
    	 */
    	
    	Product product = new Product() ;
        for (Long id:ids){	
        	product.setId(id) ;
        	this.delete(product);
        }
    }
    
    
    
    public void copyPropertyFromParent(Product sub, Product pro) {
    	Long id = sub.getId() ;
    	Long proId = sub.getPro_product_id();
    	String color = sub.getColor_();
    	String size = sub.getSize_();
    	
    	try{
    	    PropertyUtils.copyProperties(sub, pro);
    	}catch(Exception e) {
    		throw new BusinessException(e);
    	}
    	
    	sub.setId(id);
    	sub.setPro_product_id(proId);
    	sub.setColor_(color);
    	sub.setSize_(size);
    }
    

    public Product addColor(Product product) {  
    	// if 
    	Product productSO = new Product();
    	productSO.setPro_product_id(product.getPro_product_id());
    	ArrayPageList<Product> products = 
    	    (ArrayPageList<Product>)jdbcDao.queryName("bizSQLs:queryProductSizes", productSO, Product.class);
    	
    	
    	Long resultId = null ;
    	if (products.size() > 0) {
	    	for (Product p:products) {
	    		p.setColor_(product.getColor_()) ;
	    		p.setPro_product_id(product.getPro_product_id());
	    		product.setId(null);
	    		jdbcDao.insert(p) ;
	    	}
	    	resultId = products.get(0).getId();
    	} else {
    		product.setId(null);
    		jdbcDao.insert(product) ;	
    		
    		resultId = product.getId() ;
    	}
    	
    	return this.get4Edit(resultId) ;
    }


    public Product removeColor(Product product) {
    	jdbcDao.executeName("bizSQLs:removeProductColors", product) ;
    	this.getProductPhotoBO().deleteByProductColor(product.getPro_product_id(), product.getColor_());
    	
    	return this.get4Edit(product.getPro_product_id()) ;
    }

    public Product addSize(Product product) {  
    	
    	Product productWithSameColor = new Product();
    	productWithSameColor.setPro_product_id(product.getPro_product_id());
    	productWithSameColor.setColor_(product.getColor_());
    	productWithSameColor.setRecord_status(C.RECORD_STATUS_ACTIVE);
    	
    	productWithSameColor = (Product)this.jdbcDao.find(productWithSameColor) ;

    	Long resultId = null ;
    	if (productWithSameColor != null && StringUtils.isEmpty(productWithSameColor.getSize_())) {
    		productWithSameColor.setSize_(product.getSize_());
    		productWithSameColor.addInclusions("size_");

    		jdbcDao.update(productWithSameColor) ;	
    		
    		resultId = productWithSameColor.getId();
    	} else {
    		product.setRecord_status(C.RECORD_STATUS_ACTIVE);
    		jdbcDao.insert(product) ;	
    		resultId = product.getId();
    	}
		
    	return this.get4Edit(resultId) ;
    }
    
    public Product removeSize(Product product) {
    	
    	Product productToUpdate = (Product)jdbcDao.find(product) ;
    	
    	product.setSize_(null) ;
    	ArrayPageList<Product> products = 
	        (ArrayPageList<Product>)jdbcDao.queryName("bizSQLs:queryProductSizes", product, Product.class);
    	
    	if (products.size() > 1) {
    		productToUpdate.setRecord_status(C.RECORD_STATUS_CANCEL) ;
    		productToUpdate.addInclusions("record_status") ;
    	} else {
    		productToUpdate.setSize_(null) ;
    		productToUpdate.addInclusions("size_") ;
    	}
    	
    	jdbcDao.update(productToUpdate) ;
    	
    	//jdbcDao.executeName("bizSQLs:removeProductSizes", product) ;
    	return this.getProductByColorSize(product) ;
    }
    
    
    private ProductPhotoBO getProductPhotoBO() {
    	return (ProductPhotoBO)CodeHelper.getAppContext().getBean("productPhotoBO") ;
    }
}
