<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@include file="/WEB-INF/pages/common/head_easy_ui.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
<script type="text/javascript">

function load() {
	 $.ajax({
	        type: "post",
	        url: "<%=request.getContextPath()%>/system/user_grid.action",
	        dataType:"html",
	        success: function(data, textStatus, jqXHR){
	            $("#content").html(jqXHR.responseText);
	            var reponse = jQuery(jqXHR.responseText);
	            var reponseScript = reponse.filter("script");
	            $.each(reponseScript, function(idx, val) { try{eval(val.text);}catch(e){} } );
	            setTimeout(list, 1000);
	            //list();
	        }
	    });
}
</script>
</head>
<body>
<button onclick="load()">load</button>
<div id="content">

</div>
</body>
</html>