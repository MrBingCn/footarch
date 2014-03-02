package com.footarch.biz.web;

import java.io.DataInputStream;
import java.io.FileInputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.globalwave.base.web.ResponseMessage;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.entity.EventLog;
import com.globalwave.common.service.EventLogBO;
import com.globalwave.system.web.annotations.Pid;
import com.footarch.biz.entity.ProductPhoto;
import com.footarch.biz.entity.ProductSO;
import com.footarch.biz.service.ProductPhotoBO;
import com.opensymphony.xwork2.Preparable;

@Service("biz_productPhotoAction")
@Scope("prototype")
public class ProductPhotoAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 7244882365197775441L;
    
    private ProductPhotoBO productPhotoBO ;
    private ProductPhoto productPhoto ;
    private ProductSO productPhotoSO ; 
    
    public String execute() throws Exception {        
        return this.list();        
    }

    @Pid(value=1071,log=false)
    public String list() throws Exception {  

        ArrayPageList<ProductPhoto> pageList = productPhotoBO.query(productPhotoSO) ;

        renderList(pageList) ; 
        
        return null ;  
        
    }

    @Pid(value=1071,log=false)
    public String get() throws Exception {  

    	ProductPhoto org = productPhotoBO.get(this.id) ;

    	renderObject(org, null) ; 
        return null ;  
    }

    //@Pid(value=132)
    @Pid(value=Pid.LOGINED)
    public String create()  throws Exception {        

    	try {
	        Object newProductPhoto = productPhotoBO.create(productPhoto) ;
	
	        //renderObject(newProductPhoto, ResponseMessage.KEY_CREATE_OK) ;
	
			ResponseMessage msg = new ResponseMessage(newProductPhoto, ResponseMessage.KEY_CREATE_OK) ;
			
			renderHtml("<script>parent.uploader.uploadOnReturn(" + msg.asJson() + ");</script>") ;
    	} catch (Exception e) {
    		String msg = e.getMessage() ;
    		if (StringUtils.isEmpty(msg)) {
    			msg = "文件上传失败，请与管理员联系！" ;
    		} else {
    			msg = msg.replaceAll("'", "\\\\'") ;
    		}
			renderHtml("<script>parent.uploader.uploadOnReturn({code:1000,message:'" + msg + "'});</script>") ;
    	}
    	
        return null;    
        
    }
    @Pid(value=Pid.LOGINED)
    public String createByAjax()  throws Exception {        

    	try {
	        Object newProductPhoto = productPhotoBO.create(productPhoto) ;
	
	        //renderObject(newProductPhoto, ResponseMessage.KEY_CREATE_OK) ;
	
			ResponseMessage msg = new ResponseMessage(newProductPhoto, ResponseMessage.KEY_CREATE_OK) ;
			renderJson(msg.asJson()) ;
			//renderHtml("<script>parent.uploader.uploadOnReturn(" + msg.asJson() + ");</script>") ;
    	} catch (Exception e) {
    		String msg = e.getMessage() ;
    		if (StringUtils.isEmpty(msg)) {
    			msg = "文件上传失败，请与管理员联系！" ;
    		} else {
    			msg = msg.replaceAll("'", "\\\\'") ;
    		}
			//renderHtml("<script>parent.uploader.uploadOnReturn({code:1000,message:'" + msg + "'});</script>") ;
			renderJson("{\"code\":1000, \"message\":\"" + msg + "\"}") ;
    	}
    	
        return null;    
        
    }

    //@Pid(value=1071)
    @Pid(value=Pid.LOGINED, log=false)
    public String download() throws Exception {  
    	
    	try {
	    	ProductPhoto doc = productPhotoBO.getDownloadProductPhoto(this.id) ;
	

	    	EventLog eventLog = new EventLog() ;
	    	eventLog.setDesc_("File Download") ;
	    	eventLog.setExt_c1(String.valueOf(this.id)) ;
	    	eventLog.setExt_c2(doc.getName_()) ;
	    	eventLog.setExt_c3(doc.getType_()) ;
	    	eventLog.setEvent_type_code("ACTION") ;
	    	getEventLogBO().create(eventLog, doc.getProduct_id()) ;
	    	
	    	String fileName = doc.getFolder_name() + doc.getFile_uuid() ;
	        java.io.File f = new java.io.File(fileName) ;
	        
	        int length;
	        HttpServletResponse resp = this.getResponse() ;
	        ServletOutputStream op = resp.getOutputStream();
	        ServletContext context  = this.getServletContext();
	        String mimetype = context.getMimeType(fileName);
	
	        //
	        //  Set the response and go!
	        // 
	        //
	        resp.setContentType( (mimetype != null) ? mimetype : "application/octet-stream" );
	        resp.setContentLength( (int)f.length() );
	        resp.setHeader( "Content-Disposition", "attachment; filename=\""+java.net.URLEncoder.encode(doc.getName_(), "UTF-8")+"\"" );
	
	        //
	        //  Stream to the requester.
	        //
	        byte[] bbuf = new byte[1024];
	        DataInputStream in = new DataInputStream(new FileInputStream(f));
	
	        while ((in != null) && ((length = in.read(bbuf)) != -1))
	        {
	            op.write(bbuf,0,length);
	        }
	
	        in.close();
	        op.flush();
	        op.close();

    	} catch (Exception e) {
    		String msg = e.getMessage() ;
    		if (StringUtils.isEmpty(msg)) {
    			msg = "文件下载失败，请与管理员联系！" ;
    		} else {
    			msg = msg.replaceAll("'", "\\\\'") ;
    		}
			renderHtml("<script>parent.uploader.uploadOnReturn({code:1000,message:'" + msg + "'});</script>") ;
    	}
    	
    	return null ;
    }
    
    @Pid(value=1071)
    public String update()  throws Exception {
    	
        productPhotoBO.update(productPhoto) ;
        
        renderObject(productPhoto, ResponseMessage.KEY_UPDATE_OK) ;
        
        return null;    
        
    }

    //@Pid(value=134)
    @Pid(value=1071)
    public String delete()  throws Exception {

        productPhotoBO.delete(productPhoto) ;
        
        renderObject(productPhoto, ResponseMessage.KEY_DELETE_OK) ;
        
        return null;    
        
    }
   
    public void setProductPhotoBO(ProductPhotoBO productPhotoBO) {
		this.productPhotoBO = productPhotoBO;
	}

    public ProductPhoto getProductPhoto() {
        return productPhoto;
    }

    public void setProductPhoto(ProductPhoto productPhoto) {
        this.productPhoto = productPhoto;
    }

    public ProductSO getProductPhotoSO() {
        return productPhotoSO;
    }

    public void setProductPhotoSO(ProductSO productPhotoSO) {
        this.productPhotoSO = productPhotoSO;
    }

    public EventLogBO getEventLogBO() {
        return (EventLogBO) CodeHelper.getAppContext().getBean("eventLogBO");
    }
}
