package com.lhl.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lhl.crud.bean.Department;
import com.lhl.crud.bean.Message;
import com.lhl.crud.service.DepartmentService;

/**
 * 处理和部门有关的请求
 * @author LinHL
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 返回所有的部门信息
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Message getDepts() {
		List<Department> list=departmentService.getDepts();
		return Message.success().add("depts", list);
	}
}
