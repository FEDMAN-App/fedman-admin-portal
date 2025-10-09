// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CountryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryEvent()';
}


}

/// @nodoc
class $CountryEventCopyWith<$Res>  {
$CountryEventCopyWith(CountryEvent _, $Res Function(CountryEvent) __);
}


/// Adds pattern-matching-related methods to [CountryEvent].
extension CountryEventPatterns on CountryEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FetchCountries value)?  fetchCountries,TResult Function( _FetchCities value)?  fetchCities,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchCountries() when fetchCountries != null:
return fetchCountries(_that);case _FetchCities() when fetchCities != null:
return fetchCities(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FetchCountries value)  fetchCountries,required TResult Function( _FetchCities value)  fetchCities,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FetchCountries():
return fetchCountries(_that);case _FetchCities():
return fetchCities(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FetchCountries value)?  fetchCountries,TResult? Function( _FetchCities value)?  fetchCities,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchCountries() when fetchCountries != null:
return fetchCountries(_that);case _FetchCities() when fetchCities != null:
return fetchCities(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  fetchCountries,TResult Function( String countryName)?  fetchCities,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchCountries() when fetchCountries != null:
return fetchCountries();case _FetchCities() when fetchCities != null:
return fetchCities(_that.countryName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  fetchCountries,required TResult Function( String countryName)  fetchCities,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FetchCountries():
return fetchCountries();case _FetchCities():
return fetchCities(_that.countryName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  fetchCountries,TResult? Function( String countryName)?  fetchCities,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchCountries() when fetchCountries != null:
return fetchCountries();case _FetchCities() when fetchCities != null:
return fetchCities(_that.countryName);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements CountryEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryEvent.started()';
}


}




/// @nodoc


class _FetchCountries implements CountryEvent {
  const _FetchCountries();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchCountries);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryEvent.fetchCountries()';
}


}




/// @nodoc


class _FetchCities implements CountryEvent {
  const _FetchCities(this.countryName);
  

 final  String countryName;

/// Create a copy of CountryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchCitiesCopyWith<_FetchCities> get copyWith => __$FetchCitiesCopyWithImpl<_FetchCities>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchCities&&(identical(other.countryName, countryName) || other.countryName == countryName));
}


@override
int get hashCode => Object.hash(runtimeType,countryName);

@override
String toString() {
  return 'CountryEvent.fetchCities(countryName: $countryName)';
}


}

/// @nodoc
abstract mixin class _$FetchCitiesCopyWith<$Res> implements $CountryEventCopyWith<$Res> {
  factory _$FetchCitiesCopyWith(_FetchCities value, $Res Function(_FetchCities) _then) = __$FetchCitiesCopyWithImpl;
@useResult
$Res call({
 String countryName
});




}
/// @nodoc
class __$FetchCitiesCopyWithImpl<$Res>
    implements _$FetchCitiesCopyWith<$Res> {
  __$FetchCitiesCopyWithImpl(this._self, this._then);

  final _FetchCities _self;
  final $Res Function(_FetchCities) _then;

/// Create a copy of CountryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? countryName = null,}) {
  return _then(_FetchCities(
null == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CountryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryState()';
}


}

/// @nodoc
class $CountryStateCopyWith<$Res>  {
$CountryStateCopyWith(CountryState _, $Res Function(CountryState) __);
}


/// Adds pattern-matching-related methods to [CountryState].
extension CountryStatePatterns on CountryState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _CountriesLoaded value)?  countriesLoaded,TResult Function( _CountriesSelected value)?  countrySelected,TResult Function( _CitiesLoading value)?  citiesLoading,TResult Function( _CitiesLoaded value)?  citiesLoaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CountriesLoaded() when countriesLoaded != null:
return countriesLoaded(_that);case _CountriesSelected() when countrySelected != null:
return countrySelected(_that);case _CitiesLoading() when citiesLoading != null:
return citiesLoading(_that);case _CitiesLoaded() when citiesLoaded != null:
return citiesLoaded(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _CountriesLoaded value)  countriesLoaded,required TResult Function( _CountriesSelected value)  countrySelected,required TResult Function( _CitiesLoading value)  citiesLoading,required TResult Function( _CitiesLoaded value)  citiesLoaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _CountriesLoaded():
return countriesLoaded(_that);case _CountriesSelected():
return countrySelected(_that);case _CitiesLoading():
return citiesLoading(_that);case _CitiesLoaded():
return citiesLoaded(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _CountriesLoaded value)?  countriesLoaded,TResult? Function( _CountriesSelected value)?  countrySelected,TResult? Function( _CitiesLoading value)?  citiesLoading,TResult? Function( _CitiesLoaded value)?  citiesLoaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CountriesLoaded() when countriesLoaded != null:
return countriesLoaded(_that);case _CountriesSelected() when countrySelected != null:
return countrySelected(_that);case _CitiesLoading() when citiesLoading != null:
return citiesLoading(_that);case _CitiesLoaded() when citiesLoaded != null:
return citiesLoaded(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CountryAndItsCities> countries)?  countriesLoaded,TResult Function( CountryAndItsCities country)?  countrySelected,TResult Function()?  citiesLoading,TResult Function( List<String> cities)?  citiesLoaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CountriesLoaded() when countriesLoaded != null:
return countriesLoaded(_that.countries);case _CountriesSelected() when countrySelected != null:
return countrySelected(_that.country);case _CitiesLoading() when citiesLoading != null:
return citiesLoading();case _CitiesLoaded() when citiesLoaded != null:
return citiesLoaded(_that.cities);case _Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CountryAndItsCities> countries)  countriesLoaded,required TResult Function( CountryAndItsCities country)  countrySelected,required TResult Function()  citiesLoading,required TResult Function( List<String> cities)  citiesLoaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _CountriesLoaded():
return countriesLoaded(_that.countries);case _CountriesSelected():
return countrySelected(_that.country);case _CitiesLoading():
return citiesLoading();case _CitiesLoaded():
return citiesLoaded(_that.cities);case _Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CountryAndItsCities> countries)?  countriesLoaded,TResult? Function( CountryAndItsCities country)?  countrySelected,TResult? Function()?  citiesLoading,TResult? Function( List<String> cities)?  citiesLoaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CountriesLoaded() when countriesLoaded != null:
return countriesLoaded(_that.countries);case _CountriesSelected() when countrySelected != null:
return countrySelected(_that.country);case _CitiesLoading() when citiesLoading != null:
return citiesLoading();case _CitiesLoaded() when citiesLoaded != null:
return citiesLoaded(_that.cities);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CountryState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryState.initial()';
}


}




/// @nodoc


class _Loading implements CountryState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryState.loading()';
}


}




/// @nodoc


class _CountriesLoaded implements CountryState {
  const _CountriesLoaded(final  List<CountryAndItsCities> countries): _countries = countries;
  

 final  List<CountryAndItsCities> _countries;
 List<CountryAndItsCities> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}


/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountriesLoadedCopyWith<_CountriesLoaded> get copyWith => __$CountriesLoadedCopyWithImpl<_CountriesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountriesLoaded&&const DeepCollectionEquality().equals(other._countries, _countries));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_countries));

@override
String toString() {
  return 'CountryState.countriesLoaded(countries: $countries)';
}


}

/// @nodoc
abstract mixin class _$CountriesLoadedCopyWith<$Res> implements $CountryStateCopyWith<$Res> {
  factory _$CountriesLoadedCopyWith(_CountriesLoaded value, $Res Function(_CountriesLoaded) _then) = __$CountriesLoadedCopyWithImpl;
@useResult
$Res call({
 List<CountryAndItsCities> countries
});




}
/// @nodoc
class __$CountriesLoadedCopyWithImpl<$Res>
    implements _$CountriesLoadedCopyWith<$Res> {
  __$CountriesLoadedCopyWithImpl(this._self, this._then);

  final _CountriesLoaded _self;
  final $Res Function(_CountriesLoaded) _then;

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? countries = null,}) {
  return _then(_CountriesLoaded(
null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<CountryAndItsCities>,
  ));
}


}

/// @nodoc


class _CountriesSelected implements CountryState {
  const _CountriesSelected(this.country);
  

 final  CountryAndItsCities country;

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountriesSelectedCopyWith<_CountriesSelected> get copyWith => __$CountriesSelectedCopyWithImpl<_CountriesSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountriesSelected&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,country);

@override
String toString() {
  return 'CountryState.countrySelected(country: $country)';
}


}

/// @nodoc
abstract mixin class _$CountriesSelectedCopyWith<$Res> implements $CountryStateCopyWith<$Res> {
  factory _$CountriesSelectedCopyWith(_CountriesSelected value, $Res Function(_CountriesSelected) _then) = __$CountriesSelectedCopyWithImpl;
@useResult
$Res call({
 CountryAndItsCities country
});


$CountryAndItsCitiesCopyWith<$Res> get country;

}
/// @nodoc
class __$CountriesSelectedCopyWithImpl<$Res>
    implements _$CountriesSelectedCopyWith<$Res> {
  __$CountriesSelectedCopyWithImpl(this._self, this._then);

  final _CountriesSelected _self;
  final $Res Function(_CountriesSelected) _then;

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? country = null,}) {
  return _then(_CountriesSelected(
null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as CountryAndItsCities,
  ));
}

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountryAndItsCitiesCopyWith<$Res> get country {
  
  return $CountryAndItsCitiesCopyWith<$Res>(_self.country, (value) {
    return _then(_self.copyWith(country: value));
  });
}
}

/// @nodoc


class _CitiesLoading implements CountryState {
  const _CitiesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CitiesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryState.citiesLoading()';
}


}




/// @nodoc


class _CitiesLoaded implements CountryState {
  const _CitiesLoaded(final  List<String> cities): _cities = cities;
  

 final  List<String> _cities;
 List<String> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CitiesLoadedCopyWith<_CitiesLoaded> get copyWith => __$CitiesLoadedCopyWithImpl<_CitiesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CitiesLoaded&&const DeepCollectionEquality().equals(other._cities, _cities));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'CountryState.citiesLoaded(cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$CitiesLoadedCopyWith<$Res> implements $CountryStateCopyWith<$Res> {
  factory _$CitiesLoadedCopyWith(_CitiesLoaded value, $Res Function(_CitiesLoaded) _then) = __$CitiesLoadedCopyWithImpl;
@useResult
$Res call({
 List<String> cities
});




}
/// @nodoc
class __$CitiesLoadedCopyWithImpl<$Res>
    implements _$CitiesLoadedCopyWith<$Res> {
  __$CitiesLoadedCopyWithImpl(this._self, this._then);

  final _CitiesLoaded _self;
  final $Res Function(_CitiesLoaded) _then;

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cities = null,}) {
  return _then(_CitiesLoaded(
null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _Error implements CountryState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CountryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CountryStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
