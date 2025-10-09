import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_and_its_cities.freezed.dart';

part 'country_and_its_cities.g.dart';

@freezed
abstract class CountryAndItsCities with _$CountryAndItsCities{
  const factory CountryAndItsCities({
    required String iso2,
    required String iso3,
    required String country,
    required List<String> cities,

  }) = _CountryAndItsCities;

  factory CountryAndItsCities.fromJson(Map<String, dynamic> json) =>
      _$CountryAndItsCitiesFromJson(json);
}
