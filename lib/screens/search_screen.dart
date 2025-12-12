import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ctrl = TextEditingController();
  List<String> suggestions = [];

  Future<void> fetchSuggestions(String query) async {
    if (query.length < 2) {
      setState(() => suggestions = []);
      return;
    }

    // mẫu Suggest
    const cities = [
      'London',
      'Paris',
      'Tokyo',
      'Hanoi',
      'Ho Chi Minh City',
      'New York',
      'Beijing',
      'Berlin',
      'Sydney',
      'Seoul',
      'Bangkok',
    ];

    final results = cities
        .where((c) => c.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() => suggestions = results);
  }

  void selectCity(String city) {
    Navigator.pop(context, city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search City"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              decoration: InputDecoration(
                hintText: "Enter city name...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: fetchSuggestions,
            ),
            const SizedBox(height: 20),

            if (suggestions.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      leading: const Icon(Icons.location_city),
                      title: Text(suggestions[i]),
                      onTap: () => selectCity(suggestions[i]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
