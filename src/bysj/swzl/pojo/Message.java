package bysj.swzl.pojo;

import bysj.swzl.constant.MesCode;

// 传递信息的类
public class Message {

	// 消息字段 
	private String message;
	// 代码
	private MesCode code;
	// 对象
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
