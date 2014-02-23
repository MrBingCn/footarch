<%@ page contentType="text/html; charset=UTF-8" %>

<script language="javascript" type="">

</script>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="conH">
  <tr>
    <td>报价参考上传</td>
  </tr>
</table>

<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="conSrhBox">
  <tr>
    <td class="conSrhBoxTd">
      提示：只能上传excle格式的文件
    </td>
  </tr>
</table>
<br>

<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="conListV">
  <form action="<%=request.getContextPath() %>/biz/price_upload.action" enctype="multipart/form-data" method="post"> 
 
  <tr>
    <td align="left">
      <input type=file name="template" size="80"/>
       <input type="submit" name="upload" value="上传">
      <input name="addBtn" type="button" class="BTN1" value="返回" onclick="javascript:window.history.go(-1)">
    </td>
  </tr>

  <form>
</table>
