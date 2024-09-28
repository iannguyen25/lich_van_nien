import 'package:lunar/lunar.dart';

class LunarSolarConverter {
  static Lunar convertSolarToLunar(DateTime solarDate) {
    Solar solar = Solar.fromDate(solarDate);
    return solar.getLunar();
  }

  static Solar convertLunarToSolar(int lunarYear, int lunarMonth, int lunarDay) {
    Lunar lunar = Lunar.fromYmd(lunarYear, lunarMonth, lunarDay);
    return lunar.getSolar();
  }
}