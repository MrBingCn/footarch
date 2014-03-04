package com.footarch.biz.service;

import java.io.File;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.U;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;
import com.footarch.biz.entity.ProductPhoto;
import com.footarch.biz.entity.ProductSO;


@Service("productPhotoBO")
@Scope("prototype")
@Transactional
public class ProductPhotoBO extends BaseServiceImpl {

	private Log log = LogFactory.getLog(this.getClass()) ;
	
    public ProductPhoto create(ProductPhoto productPhoto) {  

    	productPhoto.setFile_uuid(UUID.randomUUID().toString()) ;
    	productPhoto.setFolder_name(U.yyyyMMdd(U.currentDate()).substring(0, 6)) ;
    	
        ProductPhoto newItem = (ProductPhoto) jdbcDao.insert(productPhoto) ;
        
    	String destBase = CodeHelper.getWebConfig("realPath") + "/upload/" + productPhoto.getFolder_name() + "/" ;
    	
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
    	
    	if(!productPhoto.getDocument_file().renameTo(new File(dest))) {
    		log.error("file can't write to '" + dest + "'") ;
    		throw new BusinessException(20009L) ;//文件不能写入，请重新上传！
    	}
        
        return newItem;
    }
    
    public ProductPhoto getDownloadProductPhoto(Long id) {
    	ProductPhoto productPhoto = this.get(id) ;
    	String destBase = CodeHelper.getWebConfig("realPath") + "/upload/" + productPhoto.getFolder_name() + "/" ;
    	productPhoto.setFolder_name(destBase) ;
    	return  productPhoto;
    }
    
    public void update(ProductPhoto productPhoto) {

    	productPhoto.addExclusions("folder_name") ;
    	productPhoto.addExclusions("file_uuid") ;
    	
        jdbcDao.update(productPhoto) ;
    }

    public void delete(ProductPhoto productPhoto) {

    	productPhoto = (ProductPhoto)jdbcDao.get(productPhoto) ;
    	jdbcDao.delete(productPhoto) ;
    	
    	String destBase = CodeHelper.getWebConfig("realPath") + "/upload/" + productPhoto.getFolder_name() + "/" ;

    	new File(destBase + productPhoto.getFile_uuid()).delete() ;        
    }

    
    public ArrayPageList<ProductPhoto> query(ProductSO productPhotoSO) {

        if (productPhotoSO == null) {
        	productPhotoSO = new ProductSO() ;
        }
        productPhotoSO.addAsc("order_") ;
        productPhotoSO.addAsc("company_id") ;
        productPhotoSO.addAsc("productPhoto_type") ;
        productPhotoSO.addAsc("productPhoto_name") ;
        
        
        return (ArrayPageList<ProductPhoto>)jdbcDao.query(productPhotoSO, ProductPhoto.class);
    }



    public ProductPhoto get(Long id) {  
    	ProductPhoto org = new ProductPhoto() ;
    	org.setId(id) ;
        org = (ProductPhoto) jdbcDao.get(org) ;
        
        
        return org;
    }
    
}
