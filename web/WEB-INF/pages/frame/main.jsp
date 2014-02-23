<%@page import="com.globalwave.util.GsonUtil"%>
<%@page import="com.globalwave.system.entity.SessionUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
SessionUser sUser = (SessionUser)session.getAttribute(SessionUser.SESSION_PK) ;
String type = (String)request.getAttribute("type") ;
boolean isAdminView = (type == null||"".equals(type)) ;
boolean isReportView = "report".equals(type) ;
boolean isDocumentView = "document".equals(type) ;

%>
<html>
<head>
    <meta charset="utf-8" />
  
    <%@include file="/WEB-INF/pages/common/head_admin.jsp" %>
    <!--[if IE 6]>
    <script type="text/javascript">
        DD_belatedPNG.fix('.png_tra');
    </script>   
    <![endif]--> 

    <title><%=company_name %></title>
    <meta name="description" content="<%=company_name %>" />
    <meta name="keywords" content="<%=company_name %>" />
    <meta name="viewport" content="width=960" />
    <meta name="robots" content="all" />
    <!-- 
    <link href="css/style.css" rel="stylesheet" type="text/css" />  
     -->
    
    <script>
    var user = null ;
    <%if (sUser != null) {%>
        user = <%=GsonUtil.getGson().toJson(sUser.getUser())%> ;
    <%} else {
        response.sendRedirect(request.getContextPath()+"/logon.jsp");
        return;
    }%>
    var isReportView = <%=isReportView%> ;
    var isDocumentView = <%=isDocumentView%> ;
    </script>
    
    <script src="<%=root%>/script/system.js"></script>    
</head>
<body>

    <%@include file="/WEB-INF/pages/share_header.jsp" %>
    <%--
    <div class="header" id="header_area">
        <h1><%=company_name %></h1>
        <div id="userInfo_area">
            <label>请登录系统</label>
            <!-- 
            <span id="userName">x</span>，欢迎登录<a href="#" id="btnLogout">退出</a>
             -->
        </div>
        <div>&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;</div>
        <div id="menu_area">
	        <div style="background-color: #C9E1F8;padding-left: 20px;padding-right: 30px" onclick="alert('ss');" >
	            <img src="<%=root %>/model/css/i_my.png" style="display:none"/>
	            <span>我的订单</span>
	        </div>
	        <div style="background-color: #C911F8;padding-left: 20px;padding-right: 30px" onclick="alert('ss1');">
                <img src="<%=root %>/model/css/i_report.png" style="display:none"/>
	            <span>报表</span>
	        </div>
	        <div style="background-color: #C9E111;padding-left: 20px;padding-right: 30px" onclick="alert('ss');">
                <img src="<%=root %>/model/css/i_order.png" style="display:none"/>
	            <span>下订单</span>
	        </div>
        </div>
    </div>
     --%>
        
    <%-- login form --%>
    <div class="login_form" id="login_page" style="display: none;">
        <div class="login_form_cont">
            <form method="post" id="loginForm" name="loginForm">
                <p><label for="user.login_id">用户</label><input type="text" name="user.login_id" id="user.login_id"  value="admin"/><span>缺少用户名</span></p>
                <p><label for="user.password_">密码</label><input type="password" name="user.password_" id="user.password_"  value="admin"/><span>缺少密码</span></p>
                <p style="padding-left: 70px;"><button type="button" class="btn_login" id="btnLogin" onclick="login();">登录</button></p>
            </form>
        </div>
        <div class="login_form_bg png_tra">-</div>
    </div>
    
    
    <div class="admin_main" id="admin_page">
        <div class="admin_nav" id="admin_nav_area">
            <ul id="adminNav">
                <li><a href="<%=root %>/index.jsp" class="link_top">回首页</a></li>
                <li style="display:none">
                    <span>我在处理</span>
                    <div id="myWorkSpace">
                    </div>
                </li>
                <%if(isAdminView) {%>
                <li>
                    <span href="#">线路管理</span>
                    <div>
                        <a href="javascript:openView(12, '/biz/boatCompany_view.action', '船公司管理')" tabindex="-1">船公司管理</a>
                        <a href="javascript:openView(31, '/biz/port_view.action', '港口设置')" tabindex="-1">港口设置</a>
                        <a href="javascript:openView(32, '/biz/line_view.action', '航线设置')" tabindex="-1">航线设置</a>
                        <a href="javascript:openView(33, '/biz/country_view.action', '国家管理')" tabindex="-1">国家管理</a>
                        <a href="javascript:openView(312, '/system/config_view.action', '洲管理', {sub_id:12})" tabindex="-1">洲管理</a>
                    </div>
                </li>
                <li>
                    <span href="#">基础数据配置</span>
                    <div id="navBaseConfig">
                        <!--<a href="javascript:openView(21, '/system/dict_view.action', '常用参数管理')" tabindex="-1">常用参数管理</a>-->
                        <a href="javascript:removeAll();openView(301, '/system/config_view.action', '货物类型', {sub_id:16})" tabindex="-1">货物类型</a>
                        <a href="javascript:removeAll();openView(302, '/system/config_view.action', '货物单位', {sub_id:13})" tabindex="-1">货物单位</a>
                        <a href="javascript:removeAll();openView(303, '/system/config_view.action', '堆场', {sub_id:15})" tabindex="-1">堆场</a>
                        <a href="javascript:removeAll();openView(305, '/system/config_view.action', '码头', {sub_id:14})" tabindex="-1">码头</a>
                        <a href="javascript:removeAll();openView(304, '/system/config_view.action', '报关方式', {sub_id:4})" tabindex="-1">报关方式</a>
                        <a href="javascript:removeAll();openView(306, '/system/config_view.action', '提单类型', {sub_id:6})" tabindex="-1">提单类型</a>
                        <a href="javascript:removeAll();openView(307, '/system/config_view.action', '运输条款', {sub_id:7})" tabindex="-1">运输条款</a>
                        <a href="javascript:removeAll();openView(308, '/system/config_view.action', '运费条款', {sub_id:8})" tabindex="-1">运费条款</a>
                        <a href="javascript:removeAll();openView(14, '/biz/feeItem_view.action', '费项管理')" tabindex="-1">费项管理</a>
                        <a href="javascript:removeAll();openView(320, '/system/template_view.action', '邮件模板管理')" tabindex="-1">邮件模板管理</a>
                        <a href="javascript:removeAll();openView(321, '/system/dict_edit.action?domain_=sys.mail.config', '邮件服务配置')" tabindex="-1">邮件服务配置</a>
                        <a href="javascript:removeAll();openView(322, '/system/dict_edit.action?domain_=sys.alert.config', '订单提醒配置')" tabindex="-1">订单颜色提醒配置</a>
                    </div>
                </li>
                <li>
                    <span>客户/公司管理</span>
                    <div>
                        <a href="javascript:removeAll();openView(11, '/biz/company_view.action', '公司管理')" tabindex="-1">公司管理</a>
                        <a href="javascript:removeAll();openView(13, '/biz/contact_view.action', '联系人管理')" tabindex="-1">联系人管理</a>
                        <a href="javascript:removeAll();openView(1003, '/biz/relatedParty_view.action', '往来单位管理')" tabindex="-1">往来单位管理</a>
                        <a href="javascript:removeAll();openView(1004, '/biz/contact_messageView.action', '报价信息发送')" tabindex="-1">报价信息发送</a>
                    </div>
                </li>
                <li>
                    <span>财务管理</span>
                    <div>
                        <a href="javascript:removeAll();openView(200001, '/system/dict_edit.action?domain_=CM.currency.rate', '汇率')" tabindex="-1">汇率</a>
                    </div>
                </li>
                <li>
                    <span href="#">用户管理</span>
                    <div>
                        <a href="javascript:removeAll();openView(1, '/system/user_view.action', '用户管理')" tabindex="-1">用户管理</a>
                        <a href="javascript:removeAll();openView(2, '/system/role_view.action', '角色管理')" tabindex="-1">角色管理</a>
                        <a href="javascript:removeAll();openView(3, '/system/organization_view.action', '部门管理')" tabindex="-1">部门管理</a>
                    </div>
                </li>
                <li>
                    <span href="#">系统管理</span>
                    <div>
                        <a href="javascript:removeAll();openView(100001, '/system/eventLog_view.action', '日志查询')" tabindex="-1">日志查询</a>
                        <a href="javascript:removeAll();openView(100002, '/system/dict_reloadView.action', '缓存刷新')" tabindex="-1">缓存刷新</a>
                        <%if (CodeHelper.getString("LOGIN.FORWARD.ENABLED", "name_", sUser.getLogin_id()) != null) {%>
                        <a href="javascript:removeAll();openView(100003, '/system/user_loginForward.action', '重新登录')" tabindex="-1">维护登录</a>
                        <%} %>
                        <a href="javascript:removeAll();openView(100004, '/system/config_view.action', '快速链接1', {sub_id:361})" tabindex="-1">快速链接1</a>
                        <a href="javascript:removeAll();openView(100005, '/system/config_view.action', '快速链接2', {sub_id:362})" tabindex="-1">快速链接2</a>
                        <a href="javascript:removeAll();openView(100006, '/system/config_view.action', '快速链接3', {sub_id:363})" tabindex="-1">快速链接3</a>
                    </div>
                </li>
                <%} else if (isReportView){%>
                <li class="active">
                    <span href="#">报表管理</span>
                    <div>
                        <a href="javascript:removeAll();openView(401, '/biz/report_view.action', '综合报表查询')" tabindex="-1">综合报表查询</a>
                        <!-- 
                        <a href="javascript:removeAll();openView(402, '/biz/arApTransaction_view.action', '销帐查询')" tabindex="-1">销帐查询</a>
                         -->
                    </div>
                </li>
                <%} else if (isDocumentView){%>
                <li class="active">
                    <span href="#">文件管理</span>
                    <div>
                        <a href="javascript:removeAll();openView(501, '/fm/document_view.action', '上传下载')" tabindex="-1">上传下载</a>
                        <!-- 
                        <a href="javascript:removeAll();openView(402, '/biz/arApTransaction_view.action', '销帐查询')" tabindex="-1">销帐查询</a>
                         -->
                    </div>
                </li>
                <%} %>
            </ul>
        </div>
	    
        <%-- main operation area --%>
        <div class="admin_action" id="admin_action_area">
            <div class="admin_action_inner">
                <h3 style="position: relative;">
                  <button onclick="maximize()" class="ui-icon ui-icon-arrowthickstop-1-w" style="position: absolute;left: -7px;top: 7px;" id="maxBtn"></button>位置：<%if(isAdminView) {%>系统设置<%} else if(isReportView) { %>报表管理<%} else if (isDocumentView) { %>文件管理<%}%>&nbsp;
                  <label id="sub_title_label"></label>
                  <button onclick="removeView()" title="关闭当前页" class="ui-icon ui-icon-closethick"  style="position: absolute;right: 3px;top: 7px;background-position: -96px -129px;"></button>
                </h3>
                <div class="admin_area">
                    <div class="admin_system" id="adminSystem">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer" id="footerDiv">
        <div class="footer_line png_tra">-</div>
        <p><%=company_name %></p>
    </div>

</body>

</html>
