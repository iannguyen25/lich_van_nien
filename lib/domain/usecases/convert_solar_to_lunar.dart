import 'package:lunar/calendar/Lunar.dart';

import '../../core/utils/lunar_solar_converter.dart';
import '../../data/models/lunar_date.dart';

class ConvertSolarToLunar {
  LunarDate call(DateTime solarDate) {
    Lunar lunarDate = LunarSolarConverter.convertSolarToLunar(solarDate);
    return LunarDate(
      day: lunarDate.getDay(),
      month: lunarDate.getMonth(),
      year: lunarDate.getYear(),
      // isLeapMonth: lunarDate.isLeapMonth(), // Đừng quên kiểm tra lại
    );
  }
}