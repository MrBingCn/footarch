package com.footarch.biz.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;

@Service("addressBO")
@Scope("prototype")
@Transactional
public class AddressBO extends BaseServiceImpl {

}
