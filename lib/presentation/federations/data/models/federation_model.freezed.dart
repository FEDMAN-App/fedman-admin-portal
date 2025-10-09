// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'federation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FederationModel {

 int? get id; String get name;@FederationTypeConverter() FederationType get type;@JsonKey(name: 'address') String get streetAddress;@JsonKey(name: 'postalCode') String get postCode; String get city; String get country;@JsonKey(name: 'logoUrl') String? get fedLogo; List<dynamic> get documents; String? get status;@JsonKey(name: 'createdAt') String? get createdDate;@JsonKey(name: 'updatedAt') String? get updatedAt;@JsonKey(includeIfNull: false) List<int> get memberFederationIdsWhenCreation;@JsonKey(includeIfNull: false) List<int> get parentFederationIdsWhenCreation; int get memberCount; int get parentCount;
/// Create a copy of FederationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FederationModelCopyWith<FederationModel> get copyWith => _$FederationModelCopyWithImpl<FederationModel>(this as FederationModel, _$identity);

  /// Serializes this FederationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FederationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.streetAddress, streetAddress) || other.streetAddress == streetAddress)&&(identical(other.postCode, postCode) || other.postCode == postCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.fedLogo, fedLogo) || other.fedLogo == fedLogo)&&const DeepCollectionEquality().equals(other.documents, documents)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.memberFederationIdsWhenCreation, memberFederationIdsWhenCreation)&&const DeepCollectionEquality().equals(other.parentFederationIdsWhenCreation, parentFederationIdsWhenCreation)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.parentCount, parentCount) || other.parentCount == parentCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,streetAddress,postCode,city,country,fedLogo,const DeepCollectionEquality().hash(documents),status,createdDate,updatedAt,const DeepCollectionEquality().hash(memberFederationIdsWhenCreation),const DeepCollectionEquality().hash(parentFederationIdsWhenCreation),memberCount,parentCount);

@override
String toString() {
  return 'FederationModel(id: $id, name: $name, type: $type, streetAddress: $streetAddress, postCode: $postCode, city: $city, country: $country, fedLogo: $fedLogo, documents: $documents, status: $status, createdDate: $createdDate, updatedAt: $updatedAt, memberFederationIdsWhenCreation: $memberFederationIdsWhenCreation, parentFederationIdsWhenCreation: $parentFederationIdsWhenCreation, memberCount: $memberCount, parentCount: $parentCount)';
}


}

/// @nodoc
abstract mixin class $FederationModelCopyWith<$Res>  {
  factory $FederationModelCopyWith(FederationModel value, $Res Function(FederationModel) _then) = _$FederationModelCopyWithImpl;
@useResult
$Res call({
 int? id, String name,@FederationTypeConverter() FederationType type,@JsonKey(name: 'address') String streetAddress,@JsonKey(name: 'postalCode') String postCode, String city, String country,@JsonKey(name: 'logoUrl') String? fedLogo, List<dynamic> documents, String? status,@JsonKey(name: 'createdAt') String? createdDate,@JsonKey(name: 'updatedAt') String? updatedAt,@JsonKey(includeIfNull: false) List<int> memberFederationIdsWhenCreation,@JsonKey(includeIfNull: false) List<int> parentFederationIdsWhenCreation, int memberCount, int parentCount
});




}
/// @nodoc
class _$FederationModelCopyWithImpl<$Res>
    implements $FederationModelCopyWith<$Res> {
  _$FederationModelCopyWithImpl(this._self, this._then);

  final FederationModel _self;
  final $Res Function(FederationModel) _then;

/// Create a copy of FederationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? type = null,Object? streetAddress = null,Object? postCode = null,Object? city = null,Object? country = null,Object? fedLogo = freezed,Object? documents = null,Object? status = freezed,Object? createdDate = freezed,Object? updatedAt = freezed,Object? memberFederationIdsWhenCreation = null,Object? parentFederationIdsWhenCreation = null,Object? memberCount = null,Object? parentCount = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FederationType,streetAddress: null == streetAddress ? _self.streetAddress : streetAddress // ignore: cast_nullable_to_non_nullable
as String,postCode: null == postCode ? _self.postCode : postCode // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,fedLogo: freezed == fedLogo ? _self.fedLogo : fedLogo // ignore: cast_nullable_to_non_nullable
as String?,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<dynamic>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdDate: freezed == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,memberFederationIdsWhenCreation: null == memberFederationIdsWhenCreation ? _self.memberFederationIdsWhenCreation : memberFederationIdsWhenCreation // ignore: cast_nullable_to_non_nullable
as List<int>,parentFederationIdsWhenCreation: null == parentFederationIdsWhenCreation ? _self.parentFederationIdsWhenCreation : parentFederationIdsWhenCreation // ignore: cast_nullable_to_non_nullable
as List<int>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,parentCount: null == parentCount ? _self.parentCount : parentCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FederationModel].
extension FederationModelPatterns on FederationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FederationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FederationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FederationModel value)  $default,){
final _that = this;
switch (_that) {
case _FederationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FederationModel value)?  $default,){
final _that = this;
switch (_that) {
case _FederationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name, @FederationTypeConverter()  FederationType type, @JsonKey(name: 'address')  String streetAddress, @JsonKey(name: 'postalCode')  String postCode,  String city,  String country, @JsonKey(name: 'logoUrl')  String? fedLogo,  List<dynamic> documents,  String? status, @JsonKey(name: 'createdAt')  String? createdDate, @JsonKey(name: 'updatedAt')  String? updatedAt, @JsonKey(includeIfNull: false)  List<int> memberFederationIdsWhenCreation, @JsonKey(includeIfNull: false)  List<int> parentFederationIdsWhenCreation,  int memberCount,  int parentCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FederationModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.streetAddress,_that.postCode,_that.city,_that.country,_that.fedLogo,_that.documents,_that.status,_that.createdDate,_that.updatedAt,_that.memberFederationIdsWhenCreation,_that.parentFederationIdsWhenCreation,_that.memberCount,_that.parentCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name, @FederationTypeConverter()  FederationType type, @JsonKey(name: 'address')  String streetAddress, @JsonKey(name: 'postalCode')  String postCode,  String city,  String country, @JsonKey(name: 'logoUrl')  String? fedLogo,  List<dynamic> documents,  String? status, @JsonKey(name: 'createdAt')  String? createdDate, @JsonKey(name: 'updatedAt')  String? updatedAt, @JsonKey(includeIfNull: false)  List<int> memberFederationIdsWhenCreation, @JsonKey(includeIfNull: false)  List<int> parentFederationIdsWhenCreation,  int memberCount,  int parentCount)  $default,) {final _that = this;
switch (_that) {
case _FederationModel():
return $default(_that.id,_that.name,_that.type,_that.streetAddress,_that.postCode,_that.city,_that.country,_that.fedLogo,_that.documents,_that.status,_that.createdDate,_that.updatedAt,_that.memberFederationIdsWhenCreation,_that.parentFederationIdsWhenCreation,_that.memberCount,_that.parentCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name, @FederationTypeConverter()  FederationType type, @JsonKey(name: 'address')  String streetAddress, @JsonKey(name: 'postalCode')  String postCode,  String city,  String country, @JsonKey(name: 'logoUrl')  String? fedLogo,  List<dynamic> documents,  String? status, @JsonKey(name: 'createdAt')  String? createdDate, @JsonKey(name: 'updatedAt')  String? updatedAt, @JsonKey(includeIfNull: false)  List<int> memberFederationIdsWhenCreation, @JsonKey(includeIfNull: false)  List<int> parentFederationIdsWhenCreation,  int memberCount,  int parentCount)?  $default,) {final _that = this;
switch (_that) {
case _FederationModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.streetAddress,_that.postCode,_that.city,_that.country,_that.fedLogo,_that.documents,_that.status,_that.createdDate,_that.updatedAt,_that.memberFederationIdsWhenCreation,_that.parentFederationIdsWhenCreation,_that.memberCount,_that.parentCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FederationModel implements FederationModel {
  const _FederationModel({this.id, required this.name, @FederationTypeConverter() required this.type, @JsonKey(name: 'address') required this.streetAddress, @JsonKey(name: 'postalCode') required this.postCode, required this.city, required this.country, @JsonKey(name: 'logoUrl') this.fedLogo, final  List<dynamic> documents = const [], this.status, @JsonKey(name: 'createdAt') this.createdDate, @JsonKey(name: 'updatedAt') this.updatedAt, @JsonKey(includeIfNull: false) final  List<int> memberFederationIdsWhenCreation = const [], @JsonKey(includeIfNull: false) final  List<int> parentFederationIdsWhenCreation = const [], this.memberCount = 0, this.parentCount = 0}): _documents = documents,_memberFederationIdsWhenCreation = memberFederationIdsWhenCreation,_parentFederationIdsWhenCreation = parentFederationIdsWhenCreation;
  factory _FederationModel.fromJson(Map<String, dynamic> json) => _$FederationModelFromJson(json);

@override final  int? id;
@override final  String name;
@override@FederationTypeConverter() final  FederationType type;
@override@JsonKey(name: 'address') final  String streetAddress;
@override@JsonKey(name: 'postalCode') final  String postCode;
@override final  String city;
@override final  String country;
@override@JsonKey(name: 'logoUrl') final  String? fedLogo;
 final  List<dynamic> _documents;
@override@JsonKey() List<dynamic> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

@override final  String? status;
@override@JsonKey(name: 'createdAt') final  String? createdDate;
@override@JsonKey(name: 'updatedAt') final  String? updatedAt;
 final  List<int> _memberFederationIdsWhenCreation;
@override@JsonKey(includeIfNull: false) List<int> get memberFederationIdsWhenCreation {
  if (_memberFederationIdsWhenCreation is EqualUnmodifiableListView) return _memberFederationIdsWhenCreation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberFederationIdsWhenCreation);
}

 final  List<int> _parentFederationIdsWhenCreation;
@override@JsonKey(includeIfNull: false) List<int> get parentFederationIdsWhenCreation {
  if (_parentFederationIdsWhenCreation is EqualUnmodifiableListView) return _parentFederationIdsWhenCreation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parentFederationIdsWhenCreation);
}

@override@JsonKey() final  int memberCount;
@override@JsonKey() final  int parentCount;

/// Create a copy of FederationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FederationModelCopyWith<_FederationModel> get copyWith => __$FederationModelCopyWithImpl<_FederationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FederationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FederationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.streetAddress, streetAddress) || other.streetAddress == streetAddress)&&(identical(other.postCode, postCode) || other.postCode == postCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.fedLogo, fedLogo) || other.fedLogo == fedLogo)&&const DeepCollectionEquality().equals(other._documents, _documents)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._memberFederationIdsWhenCreation, _memberFederationIdsWhenCreation)&&const DeepCollectionEquality().equals(other._parentFederationIdsWhenCreation, _parentFederationIdsWhenCreation)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.parentCount, parentCount) || other.parentCount == parentCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,streetAddress,postCode,city,country,fedLogo,const DeepCollectionEquality().hash(_documents),status,createdDate,updatedAt,const DeepCollectionEquality().hash(_memberFederationIdsWhenCreation),const DeepCollectionEquality().hash(_parentFederationIdsWhenCreation),memberCount,parentCount);

@override
String toString() {
  return 'FederationModel(id: $id, name: $name, type: $type, streetAddress: $streetAddress, postCode: $postCode, city: $city, country: $country, fedLogo: $fedLogo, documents: $documents, status: $status, createdDate: $createdDate, updatedAt: $updatedAt, memberFederationIdsWhenCreation: $memberFederationIdsWhenCreation, parentFederationIdsWhenCreation: $parentFederationIdsWhenCreation, memberCount: $memberCount, parentCount: $parentCount)';
}


}

/// @nodoc
abstract mixin class _$FederationModelCopyWith<$Res> implements $FederationModelCopyWith<$Res> {
  factory _$FederationModelCopyWith(_FederationModel value, $Res Function(_FederationModel) _then) = __$FederationModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name,@FederationTypeConverter() FederationType type,@JsonKey(name: 'address') String streetAddress,@JsonKey(name: 'postalCode') String postCode, String city, String country,@JsonKey(name: 'logoUrl') String? fedLogo, List<dynamic> documents, String? status,@JsonKey(name: 'createdAt') String? createdDate,@JsonKey(name: 'updatedAt') String? updatedAt,@JsonKey(includeIfNull: false) List<int> memberFederationIdsWhenCreation,@JsonKey(includeIfNull: false) List<int> parentFederationIdsWhenCreation, int memberCount, int parentCount
});




}
/// @nodoc
class __$FederationModelCopyWithImpl<$Res>
    implements _$FederationModelCopyWith<$Res> {
  __$FederationModelCopyWithImpl(this._self, this._then);

  final _FederationModel _self;
  final $Res Function(_FederationModel) _then;

/// Create a copy of FederationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? type = null,Object? streetAddress = null,Object? postCode = null,Object? city = null,Object? country = null,Object? fedLogo = freezed,Object? documents = null,Object? status = freezed,Object? createdDate = freezed,Object? updatedAt = freezed,Object? memberFederationIdsWhenCreation = null,Object? parentFederationIdsWhenCreation = null,Object? memberCount = null,Object? parentCount = null,}) {
  return _then(_FederationModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FederationType,streetAddress: null == streetAddress ? _self.streetAddress : streetAddress // ignore: cast_nullable_to_non_nullable
as String,postCode: null == postCode ? _self.postCode : postCode // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,fedLogo: freezed == fedLogo ? _self.fedLogo : fedLogo // ignore: cast_nullable_to_non_nullable
as String?,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<dynamic>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdDate: freezed == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,memberFederationIdsWhenCreation: null == memberFederationIdsWhenCreation ? _self._memberFederationIdsWhenCreation : memberFederationIdsWhenCreation // ignore: cast_nullable_to_non_nullable
as List<int>,parentFederationIdsWhenCreation: null == parentFederationIdsWhenCreation ? _self._parentFederationIdsWhenCreation : parentFederationIdsWhenCreation // ignore: cast_nullable_to_non_nullable
as List<int>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,parentCount: null == parentCount ? _self.parentCount : parentCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
