part of 'country_bloc.dart';

@freezed
class CountryEvent with _$CountryEvent {
  const factory CountryEvent.started() = _Started;
  const factory CountryEvent.fetchCountries() = _FetchCountries;
  const factory CountryEvent.fetchCities(String countryName) = _FetchCities;
}
