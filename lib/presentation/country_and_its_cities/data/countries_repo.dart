import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'constants/country_strings.dart';
import 'models/country_and_its_cities.dart';
import 'models/reponse_model.dart';

class CountryRepo{


  List<Map<String, dynamic>> _countriesData = [];

  Future<void> _fetchCountriesData() async {
    if (_countriesData.isEmpty) {
      try {
        final response = await http.get(
          Uri.parse('${CountryStrings.countriesNowBaseUrl}/countries/'),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          _countriesData = List<Map<String, dynamic>>.from(data['data']);
        } else {
          throw const HttpException(
            'Failed to fetch countries and cities.',
          );
        }
      } on SocketException {
        throw const HttpException('No Internet connection. Please check your network.');
      } catch (e) {
        throw HttpException('An unexpected error occurred: ${e.toString()}');
      }
    }
  }

  Future<List<String>> getCountries() async {
    await _fetchCountriesData();
    debugPrint(_countriesData[0].toString());
    return _countriesData
        .map((countryData) => countryData['country'].toString().trim().toLowerCase())
        .toList();
  }

  Future<List<CountryAndItsCities>> getAvailableCountries() async {
    await _fetchCountriesData();

    return _countriesData
        .map((countryData) => CountryAndItsCities.fromJson(countryData))
        .toList();
  }

  Future<List<String>> getCities(String country) async {
    await _fetchCountriesData();
    for (final countryData in _countriesData) {
      if (countryData['country'].toString().trim().toLowerCase() == country.trim().toLowerCase()) {
        return List<String>.from(
          countryData['cities'].map(
                (city) => city.toString().trim().toLowerCase(),
          ),
        );
      }
    }
    throw HttpException('Country $country not found.');
  }

  Future<ResponseModel<bool>> checkCountryExists(String country) async {
    try {
      final countries = await getCountries();
      final exists = countries.contains(country.trim().toLowerCase());
      return ResponseModel.success(
        status: exists ? "200" : "204",
        message:
        exists ? 'Country exists' : 'Please enter a valid country, $country does not exist',
        data: exists,
      );
    } catch (e) {
      return ResponseModel.error(

        error: e.toString(),
      );
    }
  }

  Future<ResponseModel<bool>> checkCityExists(String country, String city) async {
    try {
      final cities = await getCities(country);
      final exists = cities.contains(city.trim().toLowerCase());
      return ResponseModel.success(
        status: exists ? "200" : "204",
        message:
        exists ? 'City exists' : 'Please enter a valid city, $city does not exist in $country',
        data: exists,
      );
    } catch (e) {
      return ResponseModel.error(

        error: e.toString(),

      );
    }
  }
}