package com.footarch.biz.service;

import java.awt.Image;
import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;
import com.globalwave.fm.thumbnail.ImageThumbnailBuilder;
import com.footarch.biz.entity.Product;
import com.footarch.biz.entity.ProductPhoto;
import com.footarch.biz.entity.ProductPhotoSO;


@Service("productPhotoBO")
@Scope("prototype")
@Transactional
public class ProductPhotoBO extends BaseServiceImpl {

	private Log log = LogFactory.getLog(this.getClass()) ;
	
    public ProductPhoto create(ProductPhoto productPhoto) {  

    	Long product_id = productPhoto.getProduct_id();
    	
    	String sql = "select ifnull(max(file_uuid) + 1, 1) from biz_product_photo where product_id=?" ;
    	productPhoto.setFile_uuid(this.jdbcDao.getString(sql, new Object[]{product_id})) ;
    	
    	productPhoto.setFolder_name(getFolderName(product_id)) ;
    	productPhoto.setDocument_type("p") ;
    	
        ProductPhoto newItem = (ProductPhoto) jdbcDao.insert(productPhoto) ;
        
        newItem.setProduct_uuids(this.updateProductMainUUID(product_id));
        
    	String destBase = CodeHelper.getWebConfig("realPath") + "/photo/" + productPhoto.getFolder_name() + "/" ;
    	
        File baseFile = new File(destBase);
        if (!baseFile.exists()) {
            //baseFile.mkdir();
        	try {
                FileUtils.forceMkdir(baseFile) ;
        	} catch (Exception e) {
        		log.error(e, e) ;
        		throw new BusinessException(e) ;
        	}
        }
        
    	String dest = destBase + productPhoto.getFile_uuid() ;
    	File destFile = new File(dest) ;
    	if(!productPhoto.getDocument_file().renameTo(destFile)) {
    		log.error("file can't write to '" + dest + "'") ;
    		throw new BusinessException(20009L) ;//文件不能写入，请重新上传！
    	}
    	
    	ImageThumbnailBuilder builder = new ImageThumbnailBuilder() ;
    	//CodeHelper.getLong("", columnName, id)
    	try {
			builder.build(destFile, dest, 100, new File(dest + ".t"), Image.SCALE_SMOOTH, 0.8f);
		} catch (IOException e) {
    		log.error("ImageThumbnailBuilder", e) ;
    		throw new BusinessException(20009L) ;//文件不能写入，请重新上传！
		}
        
        return newItem;
    }
    
    
    private String getFolderName(Long product_id) {
    	return String.valueOf(product_id % 100) + "/" + product_id ;
    }
    private String updateProductMainUUID(long product_id) {
    	ProductPhotoSO productPhotoSO = new ProductPhotoSO();
    	productPhotoSO.setProduct_id(product_id);
    	productPhotoSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE) ;
        productPhotoSO.addAsc("document_type") ;
        productPhotoSO.addAsc("order_") ;
    	ArrayPageList<ProductPhoto> productPhotos = this.query(productPhotoSO) ;
    	
    	String result = "" ;
    	for (ProductPhoto p:productPhotos) {
    		if (result.length() != 0) {
    			result += ',';
    		}
    		result += p.getId() + ":" + p.getFile_uuid() ;
    	}
    	
        Product product = new Product() ;
        product.setId(product_id) ;
        product.setMain_photo_uuid(result) ;
        product.addInclusions("main_photo_uuid") ;
        product.setOperate(Product.OPERATE_UPDATE_UNVERSION);
        
        jdbcDao.update(product) ;
        
        return result;
    }
    
    public ProductPhoto getDownloadProductPhoto(Long id) {
    	ProductPhoto productPhoto = this.get(id) ;
    	String destBase = CodeHelper.getWebConfig("realPath") + "/photo/" + productPhoto.getFolder_name() + "/" ;
    	productPhoto.setFolder_name(destBase) ;
    	return  productPhoto;
    }
    
    public ProductPhoto makeItAsCover(Long id){

    	ProductPhoto productPhoto = this.get(id) ;
    	productPhoto.setDocument_type("m") ;
    	productPhoto.addInclusions("document_type") ;
    	
        jdbcDao.update(productPhoto) ;
        
        jdbcDao.execute(
        		"update biz_product_photo set document_type='p' where document_type='m' and id<>?", 
        		new Object[]{id}) ;
        
        productPhoto.setProduct_uuids(this.updateProductMainUUID(productPhoto.getProduct_id()));
        
        return productPhoto;
    }
    
    public void update(ProductPhoto productPhoto) {

    	productPhoto.addExclusions("folder_name") ;
    	productPhoto.addExclusions("file_uuid") ;
    	
        jdbcDao.update(productPhoto) ;
    }

    public void delete(ProductPhoto productPhoto) {

    	productPhoto = (ProductPhoto)jdbcDao.get(productPhoto) ;
    	jdbcDao.delete(productPhoto) ;
    	
        this.updateProductMainUUID(productPhoto.getProduct_id());
    	
    	String destBase = CodeHelper.getWebConfig("realPath") + "/photo/" + productPhoto.getFolder_name() + "/" ;

    	new File(destBase + productPhoto.getFile_uuid()).delete() ; 
    	File tFile = new File(destBase + productPhoto.getFile_uuid() + ".t") ;
    	if (tFile.exists()) {
    		tFile.delete() ;
    	}
    }
    
    public void deleteByProductId(Long product_id) {
    	/*
        jdbcDao.execute(
        		"delete from biz_product_photo where product_id<>?", 
        		new Object[]{product_id}) ;
        		*/
        ProductPhoto productPhoto = new ProductPhoto() ;
        productPhoto.setProduct_id(product_id);
    	jdbcDao.delete(ProductPhoto.class, productPhoto) ;
    	    	
    	String destBase = CodeHelper.getWebConfig("realPath") + "/photo/" + this.getFolderName(product_id) + "/" ;

    	try {
			FileUtils.deleteDirectory(new File(destBase)) ;
		} catch (IOException e) {
    		log.error("Delete Directory", e) ;
    		throw new BusinessException(20009L) ;//文件不能写入，请重新上传！
		}
    	//new File(destBase).delete() ; 
    }
    
    public ArrayPageList<ProductPhoto> query(ProductPhotoSO productPhotoSO) {

        if (productPhotoSO == null) {
        	productPhotoSO = new ProductPhotoSO() ;
            productPhotoSO.addAsc("order_") ;
        }
        
        
        return (ArrayPageList<ProductPhoto>)jdbcDao.query(productPhotoSO, ProductPhoto.class);
    }



    public ProductPhoto get(Long id) {  
    	ProductPhoto org = new ProductPhoto() ;
    	org.setId(id) ;
        org = (ProductPhoto) jdbcDao.get(org) ;
        
        
        return org;
    }
    
}
