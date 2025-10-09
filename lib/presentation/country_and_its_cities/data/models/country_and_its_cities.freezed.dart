// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_and_its_cities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CountryAndItsCities {

 String get iso2; String get iso3; String get country; List<String> get cities;
/// Create a copy of CountryAndItsCities
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryAndItsCitiesCopyWith<CountryAndItsCities> get copyWith => _$CountryAndItsCitiesCopyWithImpl<CountryAndItsCities>(this as CountryAndItsCities, _$identity);

  /// Serializes this CountryAndItsCities to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountryAndItsCities&&(identical(other.iso2, iso2) || other.iso2 == iso2)&&(identical(other.iso3, iso3) || other.iso3 == iso3)&&(identical(other.country, country) || other.country == country)&&const DeepCollectionEquality().equals(other.cities, cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,iso2,iso3,country,const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'CountryAndItsCities(iso2: $iso2, iso3: $iso3, country: $country, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $CountryAndItsCitiesCopyWith<$Res>  {
  factory $CountryAndItsCitiesCopyWith(CountryAndItsCities value, $Res Function(CountryAndItsCities) _then) = _$CountryAndItsCitiesCopyWithImpl;
@useResult
$Res call({
 String iso2, String iso3, String country, List<String> cities
});




}
/// @nodoc
class _$CountryAndItsCitiesCopyWithImpl<$Res>
    implements $CountryAndItsCitiesCopyWith<$Res> {
  _$CountryAndItsCitiesCopyWithImpl(this._self, this._then);

  final CountryAndItsCities _self;
  final $Res Function(CountryAndItsCities) _then;

/// Create a copy of CountryAndItsCities
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iso2 = null,Object? iso3 = null,Object? country = null,Object? cities = null,}) {
  return _then(_self.copyWith(
iso2: null == iso2 ? _self.iso2 : iso2 // ignore: cast_nullable_to_non_nullable
as String,iso3: null == iso3 ? _self.iso3 : iso3 // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CountryAndItsCities].
extension CountryAndItsCitiesPatterns on CountryAndItsCities {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CountryAndItsCities value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CountryAndItsCities() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CountryAndItsCities value)  $default,){
final _that = this;
switch (_that) {
case _CountryAndItsCities():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CountryAndItsCities value)?  $default,){
final _that = this;
switch (_that) {
case _CountryAndItsCities() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String iso2,  String iso3,  String country,  List<String> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CountryAndItsCities() when $default != null:
return $default(_that.iso2,_that.iso3,_that.country,_that.cities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String iso2,  String iso3,  String country,  List<String> cities)  $default,) {final _that = this;
switch (_that) {
case _CountryAndItsCities():
return $default(_that.iso2,_that.iso3,_that.country,_that.cities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String iso2,  String iso3,  String country,  List<String> cities)?  $default,) {final _that = this;
switch (_that) {
case _CountryAndItsCities() when $default != null:
return $default(_that.iso2,_that.iso3,_that.country,_that.cities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CountryAndItsCities implements CountryAndItsCities {
  const _CountryAndItsCities({required this.iso2, required this.iso3, required this.country, required final  List<String> cities}): _cities = cities;
  factory _CountryAndItsCities.fromJson(Map<String, dynamic> json) => _$CountryAndItsCitiesFromJson(json);

@override final  String iso2;
@override final  String iso3;
@override final  String country;
 final  List<String> _cities;
@override List<String> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of CountryAndItsCities
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryAndItsCitiesCopyWith<_CountryAndItsCities> get copyWith => __$CountryAndItsCitiesCopyWithImpl<_CountryAndItsCities>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountryAndItsCitiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountryAndItsCities&&(identical(other.iso2, iso2) || other.iso2 == iso2)&&(identical(other.iso3, iso3) || other.iso3 == iso3)&&(identical(other.country, country) || other.country == country)&&const DeepCollectionEquality().equals(other._cities, _cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,iso2,iso3,country,const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'CountryAndItsCities(iso2: $iso2, iso3: $iso3, country: $country, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$CountryAndItsCitiesCopyWith<$Res> implements $CountryAndItsCitiesCopyWith<$Res> {
  factory _$CountryAndItsCitiesCopyWith(_CountryAndItsCities value, $Res Function(_CountryAndItsCities) _then) = __$CountryAndItsCitiesCopyWithImpl;
@override @useResult
$Res call({
 String iso2, String iso3, String country, List<String> cities
});




}
/// @nodoc
class __$CountryAndItsCitiesCopyWithImpl<$Res>
    implements _$CountryAndItsCitiesCopyWith<$Res> {
  __$CountryAndItsCitiesCopyWithImpl(this._self, this._then);

  final _CountryAndItsCities _self;
  final $Res Function(_CountryAndItsCities) _then;

/// Create a copy of CountryAndItsCities
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? iso2 = null,Object? iso3 = null,Object? country = null,Object? cities = null,}) {
  return _then(_CountryAndItsCities(
iso2: null == iso2 ? _self.iso2 : iso2 // ignore: cast_nullable_to_non_nullable
as String,iso3: null == iso3 ? _self.iso3 : iso3 // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
