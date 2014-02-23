<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String view_id=request.getParameter("view_id");
%>

<script>

var g$v<%=view_id%> = $.extend(newView(), {
    view:document.getElementById("view_<%=view_id%>"), 
    id:<%=view_id%>,
    entityName:"dict",
    
    init:function (){
    },
    
    reload:function() {
        ajax(
            root + "/system/dict_reloadOptions.action", 
            null,
            function(data, textStatus){
            }
        );
    },
    
    reloadContext:function() {
        ajax(
            root + "/system/dict_reloadContext.action", 
            null,
            function(data, textStatus){
            }
        );
    }
}) ;


</script>
    
<div id="view_<%=view_id%>" style="height: 480px;">

  <ul class="hor_nav" id="horNav">
    <li id="searchLi" class="active"><span onclick="viewJs.toSearch();" tag="s">缓存刷新</span></li>
  </ul>
  <p>请确认，是否把数据从数据库中，重新加载到缓存中？<button onclick="viewJs.reload();" style="text-align: center;">确认</button></p>
  <br/><br/><br/>
  <p>请确认，重新加载应用更新（为开发员使用，请不要随便刷新）？<button onclick="viewJs.reloadContext();" style="text-align: center;">确认</button></p>
  
</div>
