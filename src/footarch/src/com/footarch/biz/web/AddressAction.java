package com.footarch.biz.web;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.opensymphony.xwork2.Preparable;

@Service("biz_addressAction")
@Scope("prototype")
public class AddressAction extends BaseAction implements Preparable {

}
