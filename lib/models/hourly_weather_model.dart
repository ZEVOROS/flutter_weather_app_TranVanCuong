class HourlyWeatherModel {
  final DateTime dateTime;
  final double temp;
  final String icon;

  HourlyWeatherModel({
    required this.dateTime,
    required this.temp,
    required this.icon,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch((json['dt'] ?? 0) * 1000),
      temp: (json['temp'] ?? 0).toDouble(),
      icon: json['weather']?[0]?['icon'] ?? '',
    );
  }
}
