package model;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

public class DateGenerator {
	public static List<String> getDatesForMonth(int year,int month){
		List<String> dates = new ArrayList<>();
		YearMonth yearMonth = YearMonth.of(year, month);
		for(int day = 1; day <= yearMonth.lengthOfMonth(); day++) {
			LocalDate date = LocalDate.of(year, month, day);
			dates.add(date.toString());
		}
		return dates;
	}
}
