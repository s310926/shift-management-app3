package model;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;



//リストに追加するのは cleanedDate を使う
//list.add(cleanedDate);

public class ShiftDateGenerator {
	public List<String> getDates(int year, int month){
		List<String> dates = new ArrayList<>();
		Calendar cal = Calendar.getInstance();
		cal.set(year, month -1, 1);
		int max = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		for(int i = 1; i <= max ; i++) {
			cal.set(Calendar.DAY_OF_MONTH,i);
//			dates.add(String.format("%04d-%02d-%02d", year,month,i));
			String dateStr = String.format("%04d-%02d-%02d", year, month, i);
			byte[] bytes = dateStr.getBytes(StandardCharsets.UTF_8);
			//2. 新しい文字列を生成し、制御文字や不可視文字を全て除去
			String cleanedDate = new String(bytes, StandardCharsets.UTF_8)
			 .replaceAll("[\\p{Cntrl}\\u0000-\\u001F\\u007F-\\u009F\\uFEFF]", "") // 制御文字、ゼロ幅NBSPなどを除去
			 .trim(); // 前後の空白除去
			dates.add(cleanedDate);

		}
		return dates;
	}
	
	public List<List<String>> getCalendarGrid(int year, int month) {
	    List<List<String>> calendar = new ArrayList<>();
	    List<String> dates = getDates(year, month);
	    Calendar cal = Calendar.getInstance();
	    cal.set(year, month - 1, 1);

	    int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 1; // 日曜=0
//	    int maxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	    int max = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	    List<String> week = new ArrayList<>();
	    for (int i = 0; i < firstDayOfWeek; i++) {
	        week.add(""); // 空白で埋める
	    }

//	    for (int day = 1; day <= maxDay; day++) {
//	        cal.set(Calendar.DAY_OF_MONTH, day);
//	        String dateStr = String.format("%04d-%02d-%02d", year, month, day);
//	        byte[] bytes = dateStr.getBytes(StandardCharsets.UTF_8);
//			String cleaned = new String(bytes, StandardCharsets.UTF_8)
//			 .replaceAll("[\\p{Cntrl}\\u0000-\\u001F\\u007F-\\u009F\\uFEFF]", "")
//			 .trim();
//	        week.add(cleaned);
//
//	        if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
//	            calendar.add(week);
//	            week = new ArrayList<>();
//	        }
//	    }
	    for (String cleanedDate : dates) {
	        week.add(cleanedDate);

	        cal.set(Calendar.YEAR, Integer.parseInt(cleanedDate.substring(0, 4)));
	        cal.set(Calendar.MONTH, Integer.parseInt(cleanedDate.substring(5, 7)) - 1);
	        cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(cleanedDate.substring(8, 10)));

	        if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
	            calendar.add(week);
	            week = new ArrayList<>();
	        }

	    }
	    if (!week.isEmpty()) {
	        while (week.size() < 7) {
	            week.add("");
	        }
	        calendar.add(week);
	    }

	    return calendar;
	}
	
	
	
}
