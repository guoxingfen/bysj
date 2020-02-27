package bysj.swzl.convert;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

public class DateConvert implements Converter<String,Date>{

	@Override
	public Date convert(String arg0) {
		SimpleDateFormat sdf=new SimpleDateFormat();
		sdf.applyPattern("yyyy-MM-dd'T'HH:mm");
		try {
			return sdf.parse(arg0);
		} catch (ParseException e) {
			sdf.applyPattern("yyyy-MM-dd HH:mm:ss");
			try {
				return sdf.parse(arg0);
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		return null;
	}

	
}
