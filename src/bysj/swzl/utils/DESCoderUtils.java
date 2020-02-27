package bysj.swzl.utils;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import Decoder.BASE64Decoder;
import Decoder.BASE64Encoder;

public class DESCoderUtils {

	//统一的密钥
	private static String key="Ud871jQHzkk=";
	
	private static final String ALGORITHM = "DES";
	// base64解密
	public static byte[] decryptBASE64() throws Exception {
		return (new BASE64Decoder()).decodeBuffer(key);
	}
 
	// base64加密
	public static String encryptBASE64(byte[] key) throws Exception {
		return (new BASE64Encoder()).encodeBuffer(key);
	}
	
	private static Key toKey(byte[] key) throws Exception {
		DESKeySpec dks = new DESKeySpec(key);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(ALGORITHM);
		SecretKey secretKey = keyFactory.generateSecret(dks);
		return secretKey;
	}
 
	// 解密 
	public static byte[] decrypt(byte[] data) throws Exception {
		Key k = toKey(decryptBASE64());
		Cipher cipher = Cipher.getInstance(ALGORITHM);
		cipher.init(Cipher.DECRYPT_MODE, k);
		return cipher.doFinal(data);
	}
 
	// 加密
	public static byte[] encrypt(byte[] data) throws Exception {
		Key k = toKey(decryptBASE64());
		Cipher cipher = Cipher.getInstance(ALGORITHM);
		cipher.init(Cipher.ENCRYPT_MODE, k);
		return cipher.doFinal(data);
	}
}
