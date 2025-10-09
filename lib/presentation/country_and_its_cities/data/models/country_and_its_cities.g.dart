// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_and_its_cities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CountryAndItsCities _$CountryAndItsCitiesFromJson(Map<String, dynamic> json) =>
    _CountryAndItsCities(
      iso2: json['iso2'] as String,
      iso3: json['iso3'] as String,
      country: json['country'] as String,
      cities: (json['cities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CountryAndItsCitiesToJson(
  _CountryAndItsCities instance,
) => <String, dynamic>{
  'iso2': instance.iso2,
  'iso3': instance.iso3,
  'country': instance.country,
  'cities': instance.cities,
};
