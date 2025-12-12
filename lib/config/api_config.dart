class ApiConfig {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  static String buildUrl(String path, Map<String, String> params) {
    final query = params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');

    return '$baseUrl$path?$query';
  }
}
