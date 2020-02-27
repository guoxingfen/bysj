package bysj.swzl.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.util.Random;

public class CheckCodeUtils {
	//����֤��
	public static StringBuilder strb=new StringBuilder();
	public static Image generateCode() {
		// ͼƬ�Ŀ���
		int width = 100;
        int height = 45;
		BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		//��䱳��ɫ
		Graphics g=image.getGraphics();
		g.setColor(Color.PINK);
		g.fillRect(0,0,width,height);
		// ���߿�
		g.setColor(new Color(118, 176, 212));
        g.drawRect(0,0,width - 1,height - 1);
		// ���������֤��
        String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghigklmnopqrstuvwxyz0123456789";
        // �����strb
        strb.delete(0, strb.length());
        Random ran = new Random();
        for (int i = 1; i <= 4; i++) {
            int index = ran.nextInt(str.length());
            //��ȡ�ַ�
            char ch = str.charAt(index);
            strb.append(ch);
            //д��֤��
            g.setFont(new Font("����",Font.BOLD,20));
            g.setColor(Color.BLUE);
            g.drawString(ch+"",width/5*i,height/2);
        }
        // ��������
        g.setColor(Color.GREEN);
        for (int i = 0; i < 10; i++) {
            int x1 = ran.nextInt(width);
            int x2 = ran.nextInt(width);

            int y1 = ran.nextInt(height);
            int y2 = ran.nextInt(height);
            g.drawLine(x1,y1,x2,y2);
        }
		return image;
	}
	
}
