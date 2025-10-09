part of 'country_bloc.dart';

@freezed
class CountryState with _$CountryState {
  const factory CountryState.initial() = _Initial;
  const factory CountryState.loading() = _Loading;
  const factory CountryState.countriesLoaded(List<CountryAndItsCities> countries) = _CountriesLoaded;
  const factory CountryState.countrySelected(CountryAndItsCities country) = _CountriesSelected;
  const factory CountryState.citiesLoading() = _CitiesLoading;
  const factory CountryState.citiesLoaded(List<String> cities) = _CitiesLoaded;
  const factory CountryState.error(String message) = _Error;
}
