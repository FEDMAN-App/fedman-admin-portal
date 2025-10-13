// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'federation_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FederationMemberModel {

 int get id; String get name; String get country; String get city; String get joinedAt;
/// Create a copy of FederationMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FederationMemberModelCopyWith<FederationMemberModel> get copyWith => _$FederationMemberModelCopyWithImpl<FederationMemberModel>(this as FederationMemberModel, _$identity);

  /// Serializes this FederationMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FederationMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,country,city,joinedAt);

@override
String toString() {
  return 'FederationMemberModel(id: $id, name: $name, country: $country, city: $city, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $FederationMemberModelCopyWith<$Res>  {
  factory $FederationMemberModelCopyWith(FederationMemberModel value, $Res Function(FederationMemberModel) _then) = _$FederationMemberModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String country, String city, String joinedAt
});




}
/// @nodoc
class _$FederationMemberModelCopyWithImpl<$Res>
    implements $FederationMemberModelCopyWith<$Res> {
  _$FederationMemberModelCopyWithImpl(this._self, this._then);

  final FederationMemberModel _self;
  final $Res Function(FederationMemberModel) _then;

/// Create a copy of FederationMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? country = null,Object? city = null,Object? joinedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FederationMemberModel].
extension FederationMemberModelPatterns on FederationMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FederationMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FederationMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FederationMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _FederationMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FederationMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _FederationMemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String country,  String city,  String joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FederationMemberModel() when $default != null:
return $default(_that.id,_that.name,_that.country,_that.city,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String country,  String city,  String joinedAt)  $default,) {final _that = this;
switch (_that) {
case _FederationMemberModel():
return $default(_that.id,_that.name,_that.country,_that.city,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String country,  String city,  String joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _FederationMemberModel() when $default != null:
return $default(_that.id,_that.name,_that.country,_that.city,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FederationMemberModel implements FederationMemberModel {
  const _FederationMemberModel({required this.id, required this.name, required this.country, required this.city, required this.joinedAt});
  factory _FederationMemberModel.fromJson(Map<String, dynamic> json) => _$FederationMemberModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String country;
@override final  String city;
@override final  String joinedAt;

/// Create a copy of FederationMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FederationMemberModelCopyWith<_FederationMemberModel> get copyWith => __$FederationMemberModelCopyWithImpl<_FederationMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FederationMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FederationMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,country,city,joinedAt);

@override
String toString() {
  return 'FederationMemberModel(id: $id, name: $name, country: $country, city: $city, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$FederationMemberModelCopyWith<$Res> implements $FederationMemberModelCopyWith<$Res> {
  factory _$FederationMemberModelCopyWith(_FederationMemberModel value, $Res Function(_FederationMemberModel) _then) = __$FederationMemberModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String country, String city, String joinedAt
});




}
/// @nodoc
class __$FederationMemberModelCopyWithImpl<$Res>
    implements _$FederationMemberModelCopyWith<$Res> {
  __$FederationMemberModelCopyWithImpl(this._self, this._then);

  final _FederationMemberModel _self;
  final $Res Function(_FederationMemberModel) _then;

/// Create a copy of FederationMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? country = null,Object? city = null,Object? joinedAt = null,}) {
  return _then(_FederationMemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
