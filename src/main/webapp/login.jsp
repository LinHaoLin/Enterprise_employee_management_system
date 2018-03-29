<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
	不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
	以/开始的相对路径，找资源，以服务器的路径为基准（http://localhost:3306）；需要加上项目名，例如
	http://localhost:3306/crud
 -->
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<!-- 引入bootstrap样式 -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<!-- 引入sweetAlert2弹框样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/sweetalert.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/sweetalert.min.js"></script>
<style>
.vertical-center {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>
</head>
<body>
	<div class="container vertical-center">
		<div class="form row">
			<form class="form-horizontal col-md-offset-3">
				<div class="form-group">
					<label for="empName_Update_input" class="col-sm-2 control-label">empName</label>
					<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">
							<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						</span>
						<input type="text" class="form-control" name="empName"
							id="empName_update_input" placeholder="empName"> 
					</div>
							<span class="help-block"></span>
					</div>
				</div>

				<div class="form-group">
					<label for="email_Update_input" class="col-sm-2 control-label">password</label>
					<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">
							<span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
						</span>
						<input type="password" class="form-control" name="password"
							id="password_update_input" placeholder="password"> 
					</div>
							<span class="help-block"></span>
					</div>
				</div>

				<div class="col-sm-offset-5">
					<button type="button" class="btn btn-primary">登录</button>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>