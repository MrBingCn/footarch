<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <ul class="hor_nav" id="horNav">
    <li id="searchLi" class="active"><span onclick="viewJs.toSearch();" tag="s">查询</span></li>
    <li id="addLi"><span onclick="viewJs.toAdd();" tag="a">增加</span></li>
    <li id="editLi"><span onclick="viewJs.toEdit();" tag="e">编辑</span></li>
    <li id="deleteLi"><span onclick="viewJs.toDelete();" tag="d">删除</span></li>
    

    <div  style="display: inline;" class="admin_act" id="pagination">
        <div class="admin_btns">
            
        </div>
        <div class="admin_pages">
            <label id="paginationInfo">总记录数为0条，当前为第1页，共0页&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <a href="javascript:viewJs.first();">首页</a>
            <a href="javascript:viewJs.preview();">上页</a>
            <a href="javascript:viewJs.next();">下页</a>
            <a href="javascript:viewJs.last();">末页</a>
        </div>
    </div>
  </ul>