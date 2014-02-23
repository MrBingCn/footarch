<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String pagination_id = (String)request.getAttribute("pagination_id") ;
%>
<div style="width:auto;clear:both;">
    <div class="admin_act" id='<%=(pagination_id==null)?"pagination":pagination_id %>'>
        <div class="admin_btns">
            
        </div>
        <div class="admin_pages">
            <label id="paginationInfo"><%=i18n.text("Page 1 of 0, Records 0&nbsp;&nbsp;&nbsp;&nbsp;", "总记录数为0条，当前为第1页，共0页") %>&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <a href="javascript:viewJs.first();"><%=i18n.text("First", "首页") %></a>
            <a href="javascript:viewJs.preview();"><%=i18n.text("Previous", "上页") %></a>
            <a href="javascript:viewJs.next();"><%=i18n.text("Next", "下页") %></a>
            <a href="javascript:viewJs.last();"><%=i18n.text("Last", "末页") %></a>
        </div>
    </div>
</div>