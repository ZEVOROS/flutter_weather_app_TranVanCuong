🌤️ Flutter Weather App

Ứng dụng thời tiết sử dụng Flutter – hỗ trợ xem thông tin thời tiết theo vị trí hiện tại, tìm kiếm địa điểm, xem dự báo chi tiết theo giờ và theo ngày.
Project được xây dựng theo kiến trúc Provider + Service Layer giúp dễ mở rộng và bảo trì.

🚀 Tính năng chính
✔️ 1. Lấy thời tiết theo vị trí hiện tại

Sử dụng location_service.dart để lấy vị trí GPS

Gọi API trong weather_service.dart

Hiển thị trên home_screen.dart

✔️ 2. Tìm kiếm địa điểm

Nhập tên địa điểm

Lấy thông tin gợi ý

Xem thời tiết của địa điểm được chọn

✔️ 3. Xem dự báo theo giờ & theo ngày

Hiển thị biểu đồ/list dự báo

Widget:

hourly_forecast_list.dart

daily_forecast_card.dart

✔️ 4. Chế độ tối – sáng (Theme Settings)

Quản lý trong settings_provider.dart

Màn hình chỉnh: settings_screen.dart

✔️ 5. Hoạt động ngoại tuyến (Offline Support)

Lưu cache bằng storage_service.dart

✔️ 6. Kiểm tra kết nối mạng

Tự động hiển thị widget lỗi khi mất mạng

Sử dụng connectivity_service.dart

📂 Cấu trúc thư mục
lib/
│
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

🏛 Kiến trúc ứng dụng

Ứng dụng được xây theo mô hình:

Provider Layer

Quản lý trạng thái:

WeatherProvider → Lấy & lưu thời tiết

LocationProvider → Lấy vị trí

SettingsProvider → Theme, units…

Service Layer

Tương tác với API, thiết bị, lưu trữ:

location_service.dart → Lấy vị trí GPS

weather_service.dart → Gọi API OpenWeather

storage_service.dart → Lưu cache

connectivity_service.dart → Theo dõi trạng thái Internet

UI Layer

Giao diện chính trong screens/

Component tái sử dụng trong widgets/

🔧 Công nghệ sử dụng

Flutter & Dart

Provider (quản lý state)

HTTP package

Geolocator (lấy vị trí)

SharedPreferences hoặc Hive (tùy bạn dùng)

Connectivity Plus (kiểm tra mạng)

📦 Cài đặt & chạy project
1. Clone project
   git clone <repo-url>
   cd flutter_weather_app

2. Cài dependencies
   flutter pub get

3. Chạy ứng dụng
   flutter run

🔑 API Key cấu hình

Ứng dụng sử dụng OpenWeather API.
