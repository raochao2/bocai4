<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="bootstrap/js/jquery-1.12.4.js"></script>
    <script>
        $("#yanzheng").click(function () {
            alert("点哦！");
        })
    </script>
</head>
<body>
<div style="margin-left: 100px;border: #2D7CE7;width: 450px;background-color: #28a4c9">
    <h2 style="text-align: center">登录</h2>
<form action="login" method="post">
    &nbsp;&nbsp;&nbsp;&nbsp;手机号码：　<input type="text" name="id"><br>
     <button type="button"  id="yanzheng">获取验证码</button>
    &nbsp;&nbsp;   验证码： <input type="text"><br><br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button>点击登录</button><br><br>
</form>
</div>
</body>
</html>
