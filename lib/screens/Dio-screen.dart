import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
class Country {
  final String name;
  final String currencies;

  Country({required this.name , required this.currencies});

  factory Country.fromJson(json) {
    return Country(
      name: json['name']['common'],
      currencies: json['name']['official'],
    );
  }
}

class DioHomePage extends StatefulWidget {
  const DioHomePage({super.key});

  @override
  State<DioHomePage> createState() => _DioHomePage();
}

class _DioHomePage extends State<DioHomePage> {
  List<Country> countries = [];
  String errorMessage = '';
  String successMessage = '';
  Future<void> getData() async {
    try {
      final response = await Dio().get('https://restcountries.com/v3.1/region/asia');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Country> fetchedCountries = data.map((json) => Country.fromJson(json)).toList();

        setState(() {
          countries = fetchedCountries;
          successMessage = 'Data fetch Success: ${countries.length}';
        });
      } else {
        throw Exception('Failed to load countries');
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
        title: const Text('Fetch DIO Data Example'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: getData,
            child: const Text('Fetch DIO Data'),
          ),
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
                   subtitle: Text(countries[index].currencies),
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
