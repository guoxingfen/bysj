package bysj.swzl.pojo;

import bysj.swzl.constant.MesCode;

// ������Ϣ����
public class Message {

	// ��Ϣ�ֶ� 
	private String message;
	// ����
	private MesCode code;
	// ����
	private Object obj;
	
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public MesCode getCode() {
		return code;
	}
	public void setCode(MesCode code) {
		this.code = code;
	}
	
}
