package bysj.swzl.utils;

import java.io.IOException;

import org.json.JSONException;

import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.SmsSingleSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;

public class SendSmsUtils {

	    // ����Ӧ��SDK AppID
		private static final int appid=1400193030; // 1400��ͷ
		// ����Ӧ��SDK AppKey
		private static final String appkey="996ca565ed7541c11ea392fc60a4a601";
		// ����ģ��ID����Ҫ�ڶ���Ӧ��������
		private static final int templateId=297494; // NOTE: �����ģ��ID`7839`ֻ��һ��ʾ������ʵ��ģ��ID��Ҫ�ڶ��ſ���̨������
		//templateId7839��Ӧ��������"������֤����: {1}"
		// �����ĸ���Ϊ2
		private static String code;
		private static final String time="1";
		// ǩ��
		private static final String smsSign="���˷ܹ��ں�"; // NOTE: ǩ������ʹ�õ���`ǩ������`��������`ǩ��ID`�������ǩ��"��Ѷ��"ֻ��һ��ʾ������ʵ��ǩ����Ҫ�ڶ��ſ���̨���롣
		// ���Ͷ���
		// ���ؽ��
		//0���ɹ�
		//1016���ֻ��Ÿ�ʽ����
		//1023�������ֻ��� 30 �����·��������������趨������
		//1024�������ֻ��� 1 Сʱ���·��������������趨������
		//1025�������ֻ������·��������������趨������
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
			// ���ظ�ʽ��0:6148868
			return Integer.toString(result.result)+":"+code;
		}
}
