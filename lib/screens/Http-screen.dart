import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Country {
  final String name;
  final String flag;

  Country({required this.name, required this.flag});

  factory Country.fromJson(json) {
    return Country(
      name: json['name']['common'],
      flag: json['flags']['png'],
    );
  }
}

class HttpPage extends StatefulWidget {
  const HttpPage({super.key});

  @override
  State<HttpPage> createState() => _HttpPage();
}

class _HttpPage extends State<HttpPage> {
  List<Country> countries = [];
  String errorMessage = '';
  String successMessage = '';
  Future<void> getData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('cachedData');
      if (cachedData != null && cachedData.isNotEmpty) {
        List<dynamic> data = json.decode(cachedData);
        List<Country> cachedCountries =
            data.map((json) => Country.fromJson(json)).toList();

        setState(() {
          countries = cachedCountries;
          successMessage = 'Data fetch from cache: ${countries.length}';
        });
      } else {
        final response = await http.get(
            Uri.parse('https://restcountries.com/v3.1/all?fields=name,flags'));

        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          List<Country> fetchedCountries =
              data.map((json) => Country.fromJson(json)).toList();
          prefs.setString('cachedData', json.encode(data));
          setState(() {
            countries = fetchedCountries;
            successMessage = 'Data fetch Success: ${countries.length}';
          });
        } else {
          throw Exception('Failed to load countries');
        }
      }
    } catch (err) {
      setState(() {
        errorMessage = 'Error is comming: $err';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch HTTP Data Example'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: getData,
            child: const Text('Fetch HTTP Data'),
          ),
          const SizedBox(height: 20),
          errorMessage.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : Container(),
          successMessage.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    successMessage,
                    style: const TextStyle(color: Colors.green),
                  ),
                )
              : Container(),
          Expanded(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(countries[index].name),
                    leading: Image.network(countries[index].flag),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
