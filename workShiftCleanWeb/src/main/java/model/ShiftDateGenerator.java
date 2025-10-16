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
}
