// lib/config/app_config.dart

   class AppConfig {
     static const String apiBaseUrl = 'https://api.example.com';
     static const bool isProduction = false;

     static String getApiBaseUrl() {
       return apiBaseUrl;
     }

     static bool isProductionMode() {
       return isProduction;
     }
   }