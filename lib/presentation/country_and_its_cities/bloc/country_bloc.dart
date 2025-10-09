import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/countries_repo.dart';
import '../data/models/country_and_its_cities.dart';

part 'country_event.dart';
part 'country_state.dart';
part 'country_bloc.freezed.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepo _countryRepo;
  CountryAndItsCities? selectedCountry;
  List<CountryAndItsCities>? availableCountries;

  CountryBloc(this._countryRepo) : super(const CountryState.initial()) {
    on<_FetchCountries>(_onFetchCountries);
    on<_FetchCities>(_onFetchCities);
  }

  Future<void> _onFetchCountries(
    _FetchCountries event,
    Emitter<CountryState> emit,
  ) async {
    emit(const CountryState.loading());
    try {
      final countries = await _countryRepo.getAvailableCountries();
      availableCountries = countries;
      emit(CountryState.countriesLoaded(countries));
    } catch (e) {
      emit(CountryState.error(e.toString()));
    }
  }

  Future<void> _onFetchCities(
    _FetchCities event,
    Emitter<CountryState> emit,
  ) async {
    emit(const CountryState.citiesLoading());
    try {
      final cities = await _countryRepo.getCities(event.countryName);
      emit(CountryState.citiesLoaded(cities));
    } catch (e) {
      emit(CountryState.error(e.toString()));
    }
  }

  void countrySelected(CountryAndItsCities country){
    selectedCountry=CountryAndItsCities(iso2: country.iso2, iso3: country.iso3, country: country.country, cities:[]);
      emit(_CountriesSelected(country));
    //emit(state);
  }
}
