<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>网页</title>
    <%--<script src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.js"></script>--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css ">
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-paginator.js"></script>
</head>
<body>
    <div class="container">
        <h1 style="text-align: center">用户评论列表</h1>
        <br><br>
        <div style="margin-left: 100px">
            <input type="button" value="添加回复" class="btn btn-info" data-toggle="modal" data-target="#mymodal">
            <input type="button" value="返回帖子列表" onclick="gotoMain()" class="btn btn-success">
        </div>
        <br>
        <form action="${pageContext.request.contextPath}/init/findplay" method="post" id="myform">
            <input type="hidden" name="pageNum" id="pageNum">
            <input type="hidden" name="invid" value="${id}">
        </form>
        <table class="table table-striped table-condensed  table-hover  table-bordered">
            <tr>
                <th>回复内容</th>
                <th>回复昵称</th>
                <th>发布时间</th>
                <th>操作</th>
            </tr>
            <%--动态--%>
                <c:forEach items="${pageInfo.list}" var="replay" varStatus="stu">
                <tr <c:if test="${stu.index%2==0}">bgcolor="#ff8c00" </c:if> >
                    <td>${replay.content}</td>
                    <td>${replay.author}</td>
                    <td><fmt:formatDate value="${replay.createdate}" pattern="yyyy-MM-dd"></fmt:formatDate> </td>
                <td>
                    <button class="btn btn-primary" data-toggle="modal" data-target="#mymodal2" onclick="togiveValue('${replay.author}','${replay.content}','${replay.id}')"> 修改</button>
                    <button class="btn btn-danger" onclick="toDel(${replay.id})" data-toggle="modal" data-target="#delModal">删除评论</button>
                </td>
                </tr>
                </c:forEach>
                <%--如果没有数据 显示 没有找到数据！！！--%>
             <c:if test="${pageInfo.total==0}">
               <tr style="text-align: center"> <td colspan="4"> <h3 style="font-weight: bolder;color: #c12e2a"> 没有数据 </h3>  </td> </tr>
             </c:if>
          </table>
        <%--分页--%>
         <div class="row">
            <div class="col-md-10 col-md-offset-3">
                <%--必须要写ul标签: 分页的数据都放在ul标签中--%>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>
   <%--增加用户评论的模态框--%>
    <div class="modal" id="mymodal" tabindex="-1" data-backdrop="static">
        <div class="modal-dialog">
        <!--第三层：声明窗口里的内容-->
        <div class="modal-content">
            <!--第一层:头部分-->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <!--class="modal-title":表示内容的标题-->
                <h4 class="modal-title">增加一条用户评论</h4>
            </div>
            <!--第二层：主体部分-->
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/init/addContent" method="post" id="addForm" class="form-horizontal" onsubmit="return check()">
                    <input type="hidden" value="${id}" name="invid">
                    <div class="form-group has-feedback">
                        <label class="col-md-3 control-label">回复内容：</label>
                           <div class="col-md-7">
                                <input type="text" name="content" id="content" class="form-control"/>
                                <span class="glyphicon glyphicon-film form-control-feedback"></span>
                           </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label class="col-md-3 control-label">回复人姓名：</label>
                        <div class="col-md-7">
                            <input type="text" name="author" id="author"  class="form-control"/>
                            <span class="glyphicon glyphicon-phone form-control-feedback"></span>
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label class="col-md-3 control-label">评论时间：</label>
                        <div class="col-md-7">
                            <input type="date" name="createdate" id="createdate" class="form-control"/>
                            <span class="glyphicon glyphicon-cloud form-control-feedback"></span>
                        </div>

                    </div>
                </form>
            </div>
            <!--第三层：注脚部分-->
            <%--form="addForm":表示按钮提交时，提交到那个表单去！--%>
            <div class="modal-footer">
                <button class="btn btn-primary" form="addForm">添加</button>
                <button class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
    </div>
<%--修改用户评论的模态框--%>
   <div class="modal" id="mymodal2" tabindex="-1" data-backdrop="static">
    <!--第二层：声明窗口-->
    <div class="modal-dialog">
        <!--第三层：声明窗口里的内容-->
        <div class="modal-content">
            <!--第一层:头部分-->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <!--class="modal-title":表示内容的标题-->
                <h4 class="modal-title">修改论坛的评论</h4>
            </div>
            <!--第二层：主体部分-->
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/init/updateContent" class="form-horizontal" method="post" id="updateForm" >
                    <input type="hidden"  name="id" id="playid">
                    <div class="form-group has-feedback">
                        <label class="col-md-3 control-label">评论人的昵称：</label>
                        <div class="col-md-7">
                           <input type="text" name="author"  id="yourname" class="form-control"/>
                           <span class="glyphicon  glyphicon-user  form-control-feedback"></span>
                           <span class="glyphicon glyphicon-heart"></span>
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label class="col-md-3 control-label">回复内容：</label>
                       <div class="col-md-7">
                        <input type="text" name="content" id="content2" class="form-control"/>
                        <span class="glyphicon glyphicon-star  form-control-feedback"></span>
                       </div>
                    </div>
                </form>
            </div>
            <!--第三层：注脚部分-->
            <%--form="addForm":表示按钮提交时，提交到那个表单去！--%>
            <div class="modal-footer">
                <button class="btn btn-primary" form="updateForm">修改</button>
                <button class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>


       <%--删除功能的对话提示模态框--%>
       <%--删除提示功能--%>
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
                <form action="${pageContext.request.contextPath}/init/deleted" method="post" id="delForm">
                    <input type="hidden" name="id" id="delEid">
                    <p>您确认要删除该条评论信息吗？</p>
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
    //分页的函数
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
                $("#pageNum").val(page);
                //提交表单
                $("#myform").submit();
            }
        };
        element.bootstrapPaginator(options);
    })
</script>
<script>
    function gotoMain() {
        location.href = "${pageContext.request.contextPath}/init/list";
    }
    function check() {
       if($("#content").val().trim()==''){
           alert("评论内容不能是空的");
           return false;
       }
       if($("#author").val().trim()==''){
            alert("作者的名字不能不写！");
            return false;
       }
       if($("#createdate").val()==''){
          alert("时间是一定要写的！");
          return false;
       }
         return true;
    }
   function toDel(id){
       $("#delEid").val(id);
   }
   function togiveValue(author,content,id) {
     $("#yourname").val(author);
     $("#content2").val(content);
     $("#playid").val(id);
   }
</script>
</html>
