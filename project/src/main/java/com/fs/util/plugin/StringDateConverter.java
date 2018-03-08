package com.fs.util.plugin;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.springframework.core.convert.converter.Converter;
/**
 * String Date Converter
 */
public class StringDateConverter implements Converter<String, Date> {
	
	public Date convert(String source) {
        DateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = dateTimeFormat.parse(source);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }
}
