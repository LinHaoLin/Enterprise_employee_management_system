<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
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
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/sweetalert.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/sweetalert.min.js"></script>

</head>
<body>

	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_Update_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>

						<div class="form-group">
							<label for="email_Update_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="email"
									id="email_update_input" placeholder="email@lhl.com"> <span
									class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_Update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_Update_input" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门提交部门id即可 -->
								<select class="form-control" name="dId">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_button">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="input" class="form-control" name="empName"
									id="empName_add_input" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="email"
									id="email_add_input" placeholder="email@lhl.com"> <span
									class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门提交部门id即可 -->
								<select class="form-control" name="dId" id="dept_add_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_button">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>企业员工管理系统</h1>
			</div>
		</div>
		
		<!-- 搜索框 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-3">
				<div class="input-group">
					<!-- 搜索输入框 -->
					<input type="text" class="form-control" name="empName"
						id="empName_sreach_input" placeholder="please enter sreach contend"> 
					<span class="input-group-addon" id="search-addon">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</span>
					<!-- <span class="input-group-addon""><i class="glyphicon glyphicon-search"></i></span> -->
				</div>
				<!-- 搜索提示框 -->
				<div id="autoSearch" style="background-color:white; border: 1px solid white;width:320.67px;position:absolute; z-index:2;display:none;" >
				</div>
			</div>
		</div>
		
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-10">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>

		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>

		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord,currentPage;
		//1、页面加载完成以后，直接去发送AJAX请求，要到分页数据
		$(function() {
			//去首页
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1、解析并显示员工数据
					build_emps_table(result);
					//2、解析并显示分页数据
					build_page_info(result);
					//3、解析并显示分页条
					build_page_nav(result)
				}
			});
		}

		function build_emps_table(result) {
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-info btn-xs edit_btn").append("<span></span>")
						.addClass("glyphicon glyphicon-pencil").append("编辑");
				//为编辑按钮添加一个自定义的属性，来表示员工id
				editBtn.attr("edit-id", item.empId);
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-xs delete_btn").append("<span></span>")
						.addClass("glyphicon glyphicon-trash").append("删除");
				//为删除按钮添加一个自定义的属性来表示当前删除员工id
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#emps_table tbody");
			});
		}

		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页,总"
							+ result.extend.pageInfo.pages + "页,总"
							+ result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage=result.extend.pageInfo.pageNum;
		}

		//显示分页条
		function build_page_nav(result) {
			//page_nav_area
			$("#page_nav_area").empty();
			var searchName = $("#empName_sreach_input").val();
			var ul = $("<ul></ul>").addClass("pagination");

			//首页、前一页相关处理
			//构建元素
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//为元素添加点击翻页的事件
				firstPageLi.click(function() {
					if("" != searchName){
						to_search_name(searchName,1);
					} else {
						to_page(1);
					}
				});
				prePageLi.click(function() {
					if("" != searchName){
						to_search_name(searchName,result.extend.pageInfo.pageNum - 1);
					} else {
						to_page(result.extend.pageInfo.pageNum - 1);
					}
				});
			}

			//末页、后一页相关处理
			//构建元素
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				//为元素添加点击翻页的事件
				nextPageLi.click(function() {
					if("" != searchName){
						to_search_name(searchName,result.extend.pageInfo.pageNum + 1);
					} else {
						to_page(result.extend.pageInfo.pageNum + 1);
					}
				});
				lastPageLi.click(function() {
					if("" != searchName){
						to_search_name(searchName,result.extend.pageInfo.pages);
					} else {
						to_page(result.extend.pageInfo.pages);
					}
				});
			}

			//添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);
			//添加遍历页码
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					if("" != searchName){
						to_search_name(searchName,item);
					} else {
						to_page(item);
					}
				});
				ul.append(numLi);
			})
			//添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);

			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		//清空表单内容样式
		function reset_form(ele) {
			//由于jQuery没有dom对象不能调用reset()，所以[0]是取出dom对象让reset方法可以被调用
			//清空表单内容
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {
			//清除表单数据（表单完整重置）
			reset_form("#empAddModal form");
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			$('#empAddModal').modal({
				backdrop : "static"
			});
		})

		//查出所有的部门信息并显示在下拉列表中
		function getDepts(ele) {
			//清空下拉列表的值
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//console.log(result);
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}

		//校验表单数据
		function validate_add_form() {
			//1、拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)) {
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");				
				show_validate_msg("#empName_add_input", "error",
						"用户名可以是2-5位中文或者6-16位英文和数字的组合");

				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");
			}
			;

			//2、校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "邮箱合法");
			}
			return true;
		}

		//显示校验结果的提示信息
		function show_validate_msg(ele, status, msg) {
			//应该清空这个元素之前的样式
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		//校验用户名是否可用
		$("#empName_add_input").change(
				function() {
					//发AJAX请求校验用户名是否可用
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + this.value,
						success : function(result) {
							if (100 == result.code) {
								show_validate_msg("#empName_add_input",
										"success", "用户名可用");
								$("#emp_save_button")
										.attr("ajax-va", "success");
							} else {
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_save_button").attr("ajax-va", "error");
							}
						}
					});
				});

		//点击保存，保存员工
		$("#emp_save_button").click(function() {
			//1、模态框中填写的表单数据交给服务器进行保存
			//先对要提交的数据进行校验
			if (!validate_add_form()) {
				return false;
			}
			; 
			if ($(this).attr("ajax-va") == "error") {
				return false;
			}

			//2、发送AJAX请求保存员工
			$.ajax({
				url : "${APP_PATH}/emp",
				type : "POST",
				data : $("#empAddModal form").serialize(),
				success : function(result) {
					if (result.code == 100) {
						swal(result.msg);
						//员工保存成功：
						//1、关闭模态框
						$("#empAddModal").modal("hide");
						//2、来到最后一页，显示刚才保存的数据
						//发送AJAX请求显示最后一页数据即可
						to_page(totalRecord);
					} else {
						//显示失败信息
						//console.log(result.msg);
						//有哪个字段错误信息就先是哪个字段的
						if(undefined!=result.extend.fieldErrors.email){
							show_validate_msg("#email_add_input", 
									"error", result.extend.fieldErrors.email);
						}
						if(undefined!=result.extend.fieldErrors.empName){
							show_validate_msg("#empName_add_input",
									"error", fieldErrors.empName);
						}
					}
				}
			});
		});		
		
		//1、我们是按钮创建之前就绑定了click，所以绑定不上。
		//1）、可以在创建按钮的时候绑定。    
		//2）、绑定点击.live()
		//jquery新版没有live，使用on进行替代
		$(document).on("click", ".edit_btn", function() {
			//清空修改模态框的样式
			$("#email_update_input").parent().removeClass("has-success has-error");
			$("#email_update_input").next("span").text("");
			//1、查出部门信息，并显示部门列表
			getDepts("#empUpdateModal select");
			//2、查出员工信息，显示员工信息
			getEmp($(this).attr("edit-id"));
			
			//3、把员工的id传递给模态框的更新按钮
			$("#emp_update_button").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getEmp(id) {
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					var empData=result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					//在初始化时就已经把<option>赋值，所以只需获得传回来emp对象的id就可以
					$("#empUpdateModal select").val([empData.dId]); 
				}
			});
		}
		
		//点击更新，更新员工信息
		$("#emp_update_button").click(function() {
			//验证邮箱是否合法
			//1、校验邮箱信息(邮箱名不支持大写)
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "邮箱合法");
			}
			
			//2、发送ajax请求修改员工信息
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//1、关闭对话框
					$("#empUpdateModal").modal("hide");
					swal("","更新成功","success");
					//2、回到本页面
					to_page(currentPage);
				}
			})
		});
		
		//单个删除
		$(document).on("click", ".delete_btn", function() {
			//1、弹出是否确认删除的对话框
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			var del_Id=$(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			swal({
				  title: "Are you sure?",
				  text: "确认删除 "+empName+" 吗？",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonClass: "btn-danger",
				  confirmButtonText: "确认删除！",
				  cancelButtonText: "取消",
				  closeOnConfirm: false,
				  closeOnCancel: false
				},
				function(isConfirm) {
				  if (isConfirm) {
					 $.ajax({
						url:"${APP_PATH}/emp/"+del_Id,
						type:"DELETE",
						success:function(result){
							//alert(result.msg);
						    swal("Deleted!", result.msg, "success");
							//回到本页
							to_page(currentPage);
							}
						})
				  } else {
				    swal("Cancelled", "已取消删除！", "error");
				  }
				});
			
			/* if(confirm("确认删除【"+empName+"】吗？")){
				//确认，发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("del-id"),
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				})
			} */
		});
		
		//完成全选/全不选
		$("#check_all").click(function() {
			//attr获取checked是undefined;
			//我们这些是dom原生的属性；attr获取自定义属性的值；
			//prop修改和读取dom原生属性的值
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		
		//check_item
		$(document).on("click", ".check_item",function() {
			//判断当前选择中的元素是否10个
			var flag=$(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked", flag);
		});
		
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function() {
			var empName="";
			var del_idstr="";
			//统计已选的待删除员工，赋值给empName、del_idstr
			$.each($(".check_item:checked"),function(){
				//this
				empName += $(this).parents("tr").find("td:eq(2)").text() + ",";
				//组装员工id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			if(0 == empName.length){
				/* swal({
					  title: "删除失败！",
					  text: "没有选中任何员工",
					}); */
				swal("删除失败！", "没有选中任何员工", "warning")
				return false;
			}
			//去除empName多余的","
			empName = empName.substring(0, empName.length-1);
			//去除删除的id多余的-
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			
			swal({
				  title: "Are you sure?",
				  text: "确认删除 "+empName+" 吗？",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonClass: "btn-danger",
				  confirmButtonText: "确认删除！",
				  cancelButtonText: "取消",
				  closeOnConfirm: false,
				  closeOnCancel: false
				},
				function(isConfirm) {
				  if (isConfirm) {
					//发送ajax请求删除
					 $.ajax({
						url:"${APP_PATH}/emp/"+del_idstr,
						type:"DELETE",
						success:function(result){
							//alert(result.msg);
						    swal("Deleted!", result.msg, "success");
							//回到当前页
							to_page(currentPage);
							}
						})
				  } else {
				    swal("Cancelled", "已取消删除！", "error");
				  }
				});
			/* if(confirm("确认删除【"+empName+"】吗？")){
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//swsweetAlertTest(result);
						//回到主页
						to_page(currentPage);
					}
				});
			} */
		});
		
		//员工搜索
		$("#search-addon").click(
				function() {
					//swal($("#empName_sreach_input").val());
					var empName = $("#empName_sreach_input").val();
					if("" == empName){
						swal("","搜索内容为空！","error");
						//若搜索框为空，恢复全员工列表
						to_page(1);
						return false;
					}
					to_search_name(empName,1);
				}		
		);
		
		//发送搜索请求
		function to_search_name(empName,pn) {
			$.ajax({
				url:"${APP_PATH}/search",
				data: "empName=" + empName + "&" + "pn=" + pn,
				type: "GET",
				success:function(result){
					if(result.code == 100){
						//1、解析并显示员工数据
						build_emps_table(result);
						//2、解析并显示分页数据
						build_page_info(result);
						//3、解析并显示分页条
						build_page_nav(result)
					} else {
						swal("",result.msg,"error");
					}
				}
			});
		}
		
		//搜索自动提示框
		$("#empName_sreach_input").keyup(function() {
			var empName = $("#empName_sreach_input").val();
			if("" == empName){
				$("#autoSearch").css("display", "node");
				return false;
			}
			
			$.ajax({
				url:"${APP_PATH}/search",
				data:"empName=" + empName + "&" + "pn=" + 1, 
				type:"GET",
				success:function(result){
					var html="";
					//当没有收到提示内容时，关闭提示框
					if(500 == result.code){
						$("#autoSearch").html("");
						$("#autoSearch").css("display", "none");
						return false;
					}
					var emps = result.extend.pageInfo.list;
					//遍历收到的list中的提示名字
					$.each(emps,function(index,item) {
						//对提示内容进行处理
						html += "<p onclick='setSearch_onclick(this)' onmouseout='changeBackColor_out(this)' onmouseover='changeBackColor_over(this)'>"
						+item.empName+"</p>";
					});
					//把提示内容放入提示框
					$("#autoSearch").html(html);
					$("#autoSearch").css("display", "block");
				}
			});
		});
		
		//搜索框失去焦点后，关闭提示框
		$("empName_sreach_input").blur(function() {
			console.log("我被执行了");
			$("#autoSearch").html("");
			$("#autoSearch").css("display", "none");
		});
		
		//鼠标移动到内容上
		 function changeBackColor_over(div){
		  $(div).css("background-color","#CCCCCC");
		 }
		 //鼠标离开内容
		 function changeBackColor_out(div){
		  $(div).css("background-color","");
		 }
		 //将点击的内容放到搜索框
		 function setSearch_onclick(div){
		  $("#empName_sreach_input").val(div.innerText);
		  $("#autoSearch").css("display","none");
		 }
	</script>
</body>
</html>