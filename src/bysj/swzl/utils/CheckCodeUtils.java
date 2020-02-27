package bysj.swzl.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.util.Random;

public class CheckCodeUtils {
	//存验证码
	public static StringBuilder strb=new StringBuilder();
	public static Image generateCode() {
		// 图片的宽、高
		int width = 100;
        int height = 45;
		BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		//填充背景色
		Graphics g=image.getGraphics();
		g.setColor(Color.PINK);
		g.fillRect(0,0,width,height);
		// 画边框
		g.setColor(new Color(118, 176, 212));
        g.drawRect(0,0,width - 1,height - 1);
		// 随机生成验证码
        String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghigklmnopqrstuvwxyz0123456789";
        // 先清空strb
        strb.delete(0, strb.length());
        Random ran = new Random();
        for (int i = 1; i <= 4; i++) {
            int index = ran.nextInt(str.length());
            //获取字符
            char ch = str.charAt(index);
            strb.append(ch);
            //写验证码
            g.setFont(new Font("宋体",Font.BOLD,20));
            g.setColor(Color.BLUE);
            g.drawString(ch+"",width/5*i,height/2);
        }
        // 画干扰线
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
