package com.lhl.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lhl.crud.bean.Department;
import com.lhl.crud.bean.Employee;
import com.lhl.crud.dao.DepartmentMapper;
import com.lhl.crud.dao.EmployeeMapper;

/**
 * ����dao��Ĺ���
 * 
 * @author LinHL �Ƽ�Spring����Ŀʹ��Spring�ĵ�Ԫ���ԣ������Զ�ע��������Ҫ���齨 1������SpringTestģ��
 *         2��@ContextConfigurationָ��Spring�����ļ���λ�� 3��ֱ��ʹ��autowiredҪʹ�õ��������
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	/**
	 * ����DepartmentMapper
	 */
	@Test
	public void tsetCRUD() {
		/*
		 * //1������SpringIOC���� ApplicationContext ioc=new
		 * ClassPathXmlApplicationContext("applicationContext.xml"); //2���������л�ȡmapper
		 * DepartmentMapper bean=ioc.getBean(DepartmentMapper.class);
		 */
		System.out.println(departmentMapper);

		// 1�����뼸������
		// departmentMapper.insertSelective(new Department(null, "������"));
		// departmentMapper.insertSelective(new Department(null, "���Բ�"));

		// 2������Ա�����ݣ�����Ա������
		// employeeMapper.insertSelective(new
		// Employee(null,"Jerry","M","Jerry@lhl.com",1));

		// 3������������Ա����������ʹ�ÿ���ִ������������sqlSession��
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		long startTime=System.currentTimeMillis();
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@lhl.com", 1));
		}
		long endTime=System.currentTimeMillis();
		System.out.println(endTime-startTime);
		System.out.println("�������");
	}
}
