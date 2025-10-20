package model;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class ShiftDateGenerator {
	public List<String> getDates(int year, int month){
		List<String> dates = new ArrayList<>();
		Calendar cal = Calendar.getInstance();
		cal.set(year, month -1, 1);
		int max = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		for(int i = 1; i <= max ; i++) {
			cal.set(Calendar.DAY_OF_MONTH,i);
			dates.add(String.format("%04d-%02d-%02d", year,month,i));
		}
		return dates;
	}
	
	public List<List<String>> getCalendarGrid(int year, int month) {
	    List<List<String>> calendar = new ArrayList<>();
	    Calendar cal = Calendar.getInstance();
	    cal.set(year, month - 1, 1);

	    int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 1; // 日曜=0
	    int maxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

	    List<String> week = new ArrayList<>();
	    for (int i = 0; i < firstDayOfWeek; i++) {
	        week.add(""); // 空白で埋める
	    }

	    for (int day = 1; day <= maxDay; day++) {
	        cal.set(Calendar.DAY_OF_MONTH, day);
	        String dateStr = String.format("%04d-%02d-%02d", year, month, day);
	        week.add(dateStr);

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
