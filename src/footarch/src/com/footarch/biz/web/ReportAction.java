package com.footarch.biz.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.U;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;
import com.globalwave.system.entity.SessionUser;
import com.globalwave.system.web.annotations.Pid;
import com.globalwave.util.GsonUtil;
import com.google.gson.Gson;
import com.footarch.biz.entity.Report;
import com.footarch.biz.entity.ReportSO;
import com.footarch.biz.service.ReportBO;
import com.opensymphony.xwork2.Preparable;

@Service("biz_reportAction")
@Scope("prototype")
public class ReportAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 7244882365197775441L;

    public static final short VIEW_TYPE_INLINE = (short)1 ;
    public static final short VIEW_TYPE_ATTACHMENT = (short)2 ;
    
    private ReportBO reportBO ;
    private Report report ;
    private ReportSO reportSO ; 
    //private short viewType = VIEW_TYPE_ATTACHMENT;

    @Override
    @Pid(value=2040,log=false)
    public String view() throws Exception {
    	HttpServletRequest request = this.getRequest();
		Gson gson = GsonUtil.getGson();
		


		List<HashMap> reportTypes = (List<HashMap>)CodeHelper.query("BIZ.Report.report_type", HashMap.class) ;
		
		/*
		SessionUser su = SessionUser.get() ;
		
		if (!su.isHltAccount()) {// 非财务，需要过滤
			
			for (int i = reportTypes.size() - 1 ; i >= 0 ; i --) {
				
				if (!hasPrivilege((String)reportTypes.get(i).get("ext_s1"))) {
					reportTypes.remove(i) ;
				}
			}
		}
		*/
		request.setAttribute("reportTypeJson", gson.toJson(reportTypes)) ;
		
    	return super.view();
    }
    
    private boolean hasPrivilege(String roleAllows) {
		SessionUser su = SessionUser.get() ;
		
		/*
		if (su.isHltAccount()) {
			return true ;
		}
		*/
		Set<String> roles = su.getRole_codes() ;

		if (roleAllows == null || roleAllows.length() == 0) {
			return false ;
		}
		
		String[] roleAllowArr = roleAllows.split(",") ;
		
		boolean isAllow = false ;
		for (String roleAllow : roleAllowArr) {
			if (roles.contains(roleAllow)) {
				isAllow = true ;
				break ;
			}
		}
		
		return isAllow;
    }
    
    public String execute() throws Exception {        
        
        //return this.list();        
        return null ;
    }

    @Pid(value=2040)
    public String export() throws Exception {
    	
    	String reportType = reportSO.getReport_typeAsString() ;
        
        String roleAllows = CodeHelper.getString("BIZ.Report.report_type", "ext_s1", reportType) ;
        
        if (!hasPrivilege(roleAllows) && false) {
        	throw new BusinessException(1001L, CodeHelper.getString("Privilege", "name_", 2040L)) ;// 当前用户没有操作权限！
        }

        com.globalwave.report.parser.excel.Report excelReport = this.reportBO.generateExcel(reportSO) ;
        
        String downFileName = CodeHelper.getString("BIZ.Report.report_type", "desc_", reportType) ;
        downFileName = new String(downFileName.getBytes("GBK"),"ISO8859_1") ;// 中文处理
        
        downFileName = downFileName + "_" + U.yyyyMMdd(U.currentDate()) + ".xls" ;
        
        excelReport.saveTo(this.getDownloadResponse(downFileName).getOutputStream()) ;

        return null ;
    }

    @Pid(value=2040)
    public String preview() throws Exception {
    	
    	String reportType = reportSO.getReport_typeAsString() ;
        
        String roleAllows = CodeHelper.getString("BIZ.Report.report_type", "ext_s1", reportType) ;
        
        if (!hasPrivilege(roleAllows)) {
        	throw new BusinessException(1001L, CodeHelper.getString("Privilege", "name_", 2040L)) ;// 当前用户没有操作权限！
        }
        
        Report reportData = this.reportBO.preview(reportSO) ;

        //this.getRequest().setAttribute("report_data", reportData.asJson()) ;
        //return "jsp" ;


        renderJson(reportData.asJson()) ; 
        
        return null ;
    }

    @Pid(value=Pid.LOGINED)
    public String previewPage() throws Exception {
    	HttpServletRequest req = this.getRequest() ;
    	String path = "/WEB-INF/pages/biz/report/preview_" + req.getParameter("type") + ".jsp" ;
    	req.getSession().getServletContext().getRequestDispatcher(path).forward(req, this.getResponse());
    	return null ;
    }

    @Pid(value=2040)
    public String queryOrder() throws Exception {  
        
        ArrayPageList<Map<String, Object>> pageList = reportBO.queryOrder(reportSO) ;

        renderList(pageList) ; 
        
        return null ;  
        
    }


    @Pid(value=-2,log=false)
	public String distinctOrder() throws Exception {
        renderList(this.reportBO.distinctOrder(reportSO)) ; 
        return null ;  
	}
        

    public void setReportBO(ReportBO reportBO) {
		this.reportBO = reportBO;
	}

    public Report getReport() {
        return report;
    }

    public void setReport(Report report) {
        this.report = report;
    }

    public ReportSO getReportSO() {
        return reportSO;
    }

    public void setReportSO(ReportSO reportSO) {
        this.reportSO = reportSO;
    }
	public void setOrderSO(ReportSO orderSO) {
		this.reportSO = orderSO;
	}
	
	public ReportSO getOrderSO() {
		return reportSO;
	}

	public void setDistinct_column(String distinct_column) {
		if (this.reportSO == null) {
			this.reportSO = new ReportSO() ;
		}
		this.reportSO.setDistinct_column(distinct_column) ;
	}
}
