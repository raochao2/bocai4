<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="bootstrap/js/jquery-1.12.4.js"></script>
    <script>
        $(function () {
            $("#yanzheng").click(function () {
                $.post("sendCode",{"tel":$("#tel").val()},function(data){
                    if(data.result>0){
                        alert("验证码发成功");
                    }else{
                      alert("用户访问量过大，稍后再试:"+data.result);
                    }
                },"json");
            })
        })
    </script>
</head>
<body>
<div style="margin-left: 100px;border: #2D7CE7;width: 450px;background-color: #28a4c9">
    <h2 style="text-align: center">登录</h2>
<form action="login2" method="post">
    &nbsp;&nbsp;&nbsp;&nbsp;手机号码：　<input type="text" id="tel"  name="tel">
      <button type="button"  id="yanzheng">获取验证码</button>
    &nbsp;&nbsp; <br>  验证码： <input type="text" name="inputCode"><br>
        用户ID：  <input type="text" name="id" placeholder="填写你的id">
    <br>
    &nbsp;<button type="submit">点击登录</button><br><br><br>
</form>
</div>
</body>
<script>

</script>
</html>
