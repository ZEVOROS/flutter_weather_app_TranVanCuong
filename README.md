# 🌤️ Flutter Weather App

Ứng dụng thời tiết sử dụng Flutter -- hỗ trợ xem thời tiết theo vị trí,
tìm kiếm địa điểm, dự báo theo giờ và theo ngày.\
Project được xây dựng theo kiến trúc **Provider + Service Layer**, dễ mở
rộng và bảo trì.

------------------------------------------------------------------------

## 🚀 Tính năng chính

-   Lấy thời tiết theo vị trí hiện tại\
-   Tìm kiếm địa điểm\
-   Dự báo theo giờ & ngày\
-   Chế độ tối -- sáng\
-   Hoạt động offline\
-   Kiểm tra kết nối mạng

------------------------------------------------------------------------

## 📂 Cấu trúc thư mục `lib/`

    lib/
    ├── models/
    │   ├── forecast_model.dart
    │   ├── hourly_weather_model.dart
    │   ├── location_model.dart
    │   └── weather_model.dart
    │
    ├── providers/
    │   ├── location_provider.dart
    │   ├── settings_provider.dart
    │   └── weather_provider.dart
    │
    ├── screens/
    │   ├── forecast_screen.dart
    │   ├── home_screen.dart
    │   ├── search_screen.dart
    │   └── settings_screen.dart
    │
    ├── services/
    │   ├── connectivity_service.dart
    │   ├── location_service.dart
    │   ├── storage_service.dart
    │   └── weather_service.dart
    │
    ├── utils/
    │   ├── constants.dart
    │   ├── date_formatter.dart
    │   └── weather_icons.dart
    │
    └── widgets/
        ├── current_weather_card.dart
        ├── daily_forecast_card.dart
        ├── error_widget.dart
        ├── hourly_forecast_list.dart
        ├── loading_shimmer.dart
        └── weather_card.dart

------------------------------------------------------------------------

## 🔧 Cài đặt & chạy project

### 1. Cài dependencies

    flutter pub get

### 2. Chạy ứng dụng

    flutter run


