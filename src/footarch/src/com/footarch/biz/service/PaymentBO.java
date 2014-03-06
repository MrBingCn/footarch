package com.footarch.biz.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footarch.biz.entity.Payment;
import com.footarch.biz.entity.PaymentSO;
import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.exception.BusinessException;

@Service("paymentBO")
@Scope("prototype")
@Transactional
public class PaymentBO extends BaseServiceImpl {
	public Payment create(Payment payment) {
		return (Payment) jdbcDao.insert(payment);
	}
	
	public void update(Payment payment) {
		jdbcDao.update(payment);
	}
	
    public Payment get(Long id) { 
    	if (id == null) {
    		throw new BusinessException("address id is required") ;
    	}
    	Payment payment = new Payment() ;
    	payment.setId(id) ;
        return (Payment) jdbcDao.get(payment) ;
    }
	
    public ArrayPageList<Payment> query(
    		PaymentSO paymentSO) {
    	if (paymentSO == null) {
    		paymentSO = new PaymentSO();
    	}
        return (ArrayPageList<Payment>)jdbcDao.query(paymentSO, Payment.class);
    }
}
