package bysj.swzl.utils;

import java.io.IOException;

import org.json.JSONException;

import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.SmsSingleSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;

public class SendSmsUtils {

	    // 短信应用SDK AppID
		private static final int appid=1400193030; // 1400开头
		// 短信应用SDK AppKey
		private static final String appkey="996ca565ed7541c11ea392fc60a4a601";
		// 短信模板ID，需要在短信应用中申请
		private static final int templateId=297494; // NOTE: 这里的模板ID`7839`只是一个示例，真实的模板ID需要在短信控制台中申请
		//templateId7839对应的内容是"您的验证码是: {1}"
		// 参数的个数为2
		private static String code;
		private static final String time="1";
		// 签名
		private static final String smsSign="哥兴奋公众号"; // NOTE: 签名参数使用的是`签名内容`，而不是`签名ID`。这里的签名"腾讯云"只是一个示例，真实的签名需要在短信控制台申请。
		// 发送短信
		// 返回结果
		//0：成功
		//1016：手机号格式错误
		//1023：单个手机号 30 秒内下发短信条数超过设定的上限
		//1024：单个手机号 1 小时内下发短信条数超过设定的上限
		//1025：单个手机号日下发短信条数超过设定的上限
		public static String sendMessage(String phoneNumber) {
			int mobile_code = (int)((Math.random()*9+1)*100000);
			code=Integer.toString(mobile_code);
			SmsSingleSenderResult result=null;
			try {
				SmsSingleSender ssender=new SmsSingleSender(appid,appkey);
				result=ssender.sendWithParam("86", phoneNumber, templateId, new String[] {code,time}, smsSign, "", "");
			} catch (JSONException | HTTPException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 返回格式：0:6148868
			return Integer.toString(result.result)+":"+code;
		}
}
