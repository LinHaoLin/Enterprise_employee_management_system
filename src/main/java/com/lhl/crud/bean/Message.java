package com.lhl.crud.bean;

import java.util.HashMap;
import java.util.Map;

import com.github.pagehelper.PageInfo;

/**
 * ͨ�÷�����
 * @author LinHL
 *
 */
public class Message {
	//״̬�� 100-�ɹ���500-ʧ��
	private int code;
	//��ʾ��Ϣ
	private String msg;
	
	//�û�Ҫ���ظ������������
	private Map<String, Object>extend=new HashMap<String, Object>();

	public static Message success() {
		Message result=new Message();
		result.setCode(100);
		result.setMsg("����ɹ���");
		return result;
	}
	
	public static Message fail() {
		Message result=new Message();
		result.setCode(500);
		result.setMsg("����ʧ�ܣ�");
		return result;
	}
	
	public static Message fail(String msg) {
		Message result=new Message();
		result.setCode(500);
		result.setMsg(msg);
		return result;
	}
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	public Message add(String key, Object value) {
		// TODO Auto-generated method stub
		this.getExtend().put(key, value);
		return this;
	}
}
