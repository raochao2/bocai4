<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>网页</title>
    <style>
        .toast-center-center{
            top: 50%;
            left: 50%;
            margin-top: -50px;
            margin-left: -150px;
        }
    </style>
    <%--<script src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.js"></script>--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css ">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/toastr.css">
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/toastr.min.js"></script>
    <script>
        toastr.options.positionClass = 'toast-center-center';
    </script>
</head>
<body>
    <div class="container">
        <h1 style="text-align: center">新闻信息列表</h1>

        <form action="${pageContext.request.contextPath}/init/list" method="post" id="myform" class="form-inline">
            <%--隐藏域--%>
                <div class="col-md-5 col-md-offset-2">
                <input type="hidden" name="pageNum" id="pageNum">
                   <div  class="form-group has-feedback">
                   <input type="text" name="title" value="${condition}" class="form-control input-sm" placeholder="输入标题搜索关键词">
                   <span class="glyphicon glyphicon-search form-control-feedback "></span>
                   </div>
                 <input type="submit" value="搜索" class="btn btn-success">
                </div>
        </form>
        <table class="table table-striped  table-hover table-bordered">
            <tr>
                <th>标题</th>
                <th>内容摘要</th>
                <th>作者</th>
                <th>发布时间</th>
                <th>操作</th>
            </tr>
            <%--动态--%>
            <c:forEach items="${pageInfo.list}" var="invitation" varStatus="stus">
                <tr <c:if test="${stus.index%2==0}"> bgcolor="lime" </c:if>>
                    <td>${invitation.title}</td>
                    <td>${invitation.summary}</td>
                    <td>${invitation.author}</td>
                    <td><fmt:formatDate value="${invitation.createdate}" pattern="yyyy-MM-dd"></fmt:formatDate> </td>
                    <td>
                        <button class="btn btn-info btn-sm"  onclick="findplay(${invitation.id})">查看回复</button>
                        <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#delModal" onclick="toDel(${invitation.id})">删除</button>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${pageInfo.total==0}">
                <tr style="text-align: center"><td colspan="5"> <h4 style="font-weight: bolder">没有找到数据！请尝试更换关键词 </h4></td></tr>
            </c:if>
        </table>
        <%--分页组件--%>

        <div class="row">
            <div class="col-md-10 col-md-offset-3">
                <%--必须要写ul标签: 分页的数据都放在ul标签中--%>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>
    <!-- 模态框   信息删除确认 -->
    <div class="modal" id="delModal" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content message_align">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">提示</h4>
                </div>
                <div class="modal-body">
                    <%--删除功能的表单--%>
                    <form action="${pageContext.request.contextPath}/init/delete" method="post" id="delForm">
                        <input type="hidden" name="id" id="delEid">
                        <p>您确认要删除这条帖子吗？</p>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消</button>
                    <input type="submit" class="btn btn-primary" form="delForm" value="确认删除" />
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    /*分页函数组件*/
    $(function () {
        var element = $('#pagination');
        options = {
            bootstrapMajorVersion:3, //对应的bootstrap版本
            currentPage: ${pageInfo.pageNum}, //当前页数，这里是用的EL表达式，获取从后台传过来的值
            totalPages:${pageInfo.pages}, //总页数，这里是用的EL表达式，获取从后台传过来的值
            itemTexts: function (type, page, current) {//设置显示的样式，默认是箭头
                switch (type) {
                    case "first":
                        return "首页";
                    case "prev":
                        return "上一页";
                    case "next":
                        return "下一页";
                    case "last":
                        return "末页";
                    case "page":
                        return page;
                }
            },
            //点击事件  page:当前的页码
            onPageClicked: function (event, originalEvent, type, page) {
                //处理具体的业务
                //把当前页码发送到后台的controller做分页查询
                //给隐藏域赋值
                $("#pageNum").val(page);
                //提交表单
                $("#myform").submit();
            }
        };
        element.bootstrapPaginator(options);
    })
    function findplay(id){
      location.href = "${pageContext.request.contextPath}/init/findplay?invid="+id;
    }
    function toDel(id) {
       $("#delEid").val(id);
    }
</script>
<script>
    <c:if test="${insert=='success'}">
        toastr.success("添加评论成功！");
    </c:if>
    <c:if test="${insert=='fail'}">
        alert("添加失败！");
    </c:if>

    <c:if test="${update=='success'}">
      toastr.success("修改评论成功！");
    </c:if>
    <c:if test="${update=='fail'}">
        alert("修改失败！");
    </c:if>
    <c:if test="${delete=='success'}">
        toastr.success("删除成功！");
    </c:if>
    <c:if test="${delete=='fail'}">
        alert("删除失败！");
    </c:if>
</script>
</html>
