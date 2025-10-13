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

@JsonKey(includeIfNull: false) int? get id; String get name;@FederationTypeConverter() FederationType get type;@JsonKey(name: 'address') String get streetAddress;@JsonKey(name: 'postalCode') String get postCode; String get city; String get country;@JsonKey(includeIfNull: false, name: 'logoUrl') String? get fedLogo;@JsonKey(includeIfNull: false, toJson: _dynamicListToJson) List<DocumentModel> get documents;@JsonKey(includeIfNull: false) String? get status;@JsonKey(name: 'createdAt', includeIfNull: false) String? get createdDate;@JsonKey(name: 'updatedAt', includeIfNull: false) String? get updatedAt;@JsonKey(includeIfNull: false) String? get joinedAt;@JsonKey(includeIfNull: false, toJson: _listToJson) List<int>? get memberFederationIds;@JsonKey(includeIfNull: false, toJson: _listToJson) List<int>? get parentFederationIds;@JsonKey(includeIfNull: false) int? get memberCount;@JsonKey(includeIfNull: false) int? get parentCount;
/// Create a copy of FederationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FederationModelCopyWith<FederationModel> get copyWith => _$FederationModelCopyWithImpl<FederationModel>(this as FederationModel, _$identity);

  /// Serializes this FederationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FederationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.streetAddress, streetAddress) || other.streetAddress == streetAddress)&&(identical(other.postCode, postCode) || other.postCode == postCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.fedLogo, fedLogo) || other.fedLogo == fedLogo)&&const DeepCollectionEquality().equals(other.documents, documents)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&const DeepCollectionEquality().equals(other.memberFederationIds, memberFederationIds)&&const DeepCollectionEquality().equals(other.parentFederationIds, parentFederationIds)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.parentCount, parentCount) || other.parentCount == parentCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,streetAddress,postCode,city,country,fedLogo,const DeepCollectionEquality().hash(documents),status,createdDate,updatedAt,joinedAt,const DeepCollectionEquality().hash(memberFederationIds),const DeepCollectionEquality().hash(parentFederationIds),memberCount,parentCount);

@override
String toString() {
  return 'FederationModel(id: $id, name: $name, type: $type, streetAddress: $streetAddress, postCode: $postCode, city: $city, country: $country, fedLogo: $fedLogo, documents: $documents, status: $status, createdDate: $createdDate, updatedAt: $updatedAt, joinedAt: $joinedAt, memberFederationIds: $memberFederationIds, parentFederationIds: $parentFederationIds, memberCount: $memberCount, parentCount: $parentCount)';
}


}

/// @nodoc
abstract mixin class $FederationModelCopyWith<$Res>  {
  factory $FederationModelCopyWith(FederationModel value, $Res Function(FederationModel) _then) = _$FederationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) int? id, String name,@FederationTypeConverter() FederationType type,@JsonKey(name: 'address') String streetAddress,@JsonKey(name: 'postalCode') String postCode, String city, String country,@JsonKey(includeIfNull: false, name: 'logoUrl') String? fedLogo,@JsonKey(includeIfNull: false, toJson: _dynamicListToJson) List<DocumentModel> documents,@JsonKey(includeIfNull: false) String? status,@JsonKey(name: 'createdAt', includeIfNull: false) String? createdDate,@JsonKey(name: 'updatedAt', includeIfNull: false) String? updatedAt,@JsonKey(includeIfNull: false) String? joinedAt,@JsonKey(includeIfNull: false, toJson: _listToJson) List<int>? memberFederationIds,@JsonKey(includeIfNull: false, toJson: _listToJson) List<int>? parentFederationIds,@JsonKey(includeIfNull: false) int? memberCount,@JsonKey(includeIfNull: false) int? parentCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? type = null,Object? streetAddress = null,Object? postCode = null,Object? city = null,Object? country = null,Object? fedLogo = freezed,Object? documents = null,Object? status = freezed,Object? createdDate = freezed,Object? updatedAt = freezed,Object? joinedAt = freezed,Object? memberFederationIds = freezed,Object? parentFederationIds = freezed,Object? memberCount = freezed,Object? parentCount = freezed,}) {
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
as List<DocumentModel>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdDate: freezed == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as String?,memberFederationIds: freezed == memberFederationIds ? _self.memberFederationIds : memberFederationIds // ignore: cast_nullable_to_non_nullable
as List<int>?,parentFederationIds: freezed == parentFederationIds ? _self.parentFederationIds : parentFederationIds // ignore: cast_nullable_to_non_nullable
as List<int>?,memberCount: freezed == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int?,parentCount: freezed == parentCount ? _self.parentCount : parentCount // ignore: cast_nullable_to_non_nullable
as int?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? id,  String name, @FederationTypeConverter()  FederationType type, @JsonKey(name: 'address')  String streetAddress, @JsonKey(name: 'postalCode')  String postCode,  String city,  String country, @JsonKey(includeIfNull: false, name: 'logoUrl')  String? fedLogo, @JsonKey(includeIfNull: false, toJson: _dynamicListToJson)  List<DocumentModel> documents, @JsonKey(includeIfNull: false)  String? status, @JsonKey(name: 'createdAt', includeIfNull: false)  String? createdDate, @JsonKey(name: 'updatedAt', includeIfNull: false)  String? updatedAt, @JsonKey(includeIfNull: false)  String? joinedAt, @JsonKey(includeIfNull: false, toJson: _listToJson)  List<int>? memberFederationIds, @JsonKey(includeIfNull: false, toJson: _listToJson)  List<int>? parentFederationIds, @JsonKey(includeIfNull: false)  int? memberCount, @JsonKey(includeIfNull: false)  int? parentCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FederationModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.streetAddress,_that.postCode,_that.city,_that.country,_that.fedLogo,_that.documents,_that.status,_that.createdDate,_that.updatedAt,_that.joinedAt,_that.memberFederationIds,_that.parentFederationIds,_that.memberCount,_that.parentCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? id,  String name, @FederationTypeConverter()  FederationType type, @JsonKey(name: 'address')  String streetAddress, @JsonKey(name: 'postalCode')  String postCode,  String city,  String country, @JsonKey(includeIfNull: false, name: 'logoUrl')  String? fedLogo, @JsonKey(includeIfNull: false, toJson: _dynamicListToJson)  List<DocumentModel> documents, @JsonKey(includeIfNull: false)  String? status, @JsonKey(name: 'createdAt', includeIfNull: false)  String? createdDate, @JsonKey(name: 'updatedAt', includeIfNull: false)  String? updatedAt, @JsonKey(includeIfNull: false)  String? joinedAt, @JsonKey(includeIfNull: false, toJson: _listToJson)  List<int>? memberFederationIds, @JsonKey(includeIfNull: false, toJson: _listToJson)  List<int>? parentFederationIds, @JsonKey(includeIfNull: false)  int? memberCount, @JsonKey(includeIfNull: false)  int? parentCount)  $default,) {final _that = this;
switch (_that) {
case _FederationModel():
return $default(_that.id,_that.name,_that.type,_that.streetAddress,_that.postCode,_that.city,_that.country,_that.fedLogo,_that.documents,_that.status,_that.createdDate,_that.updatedAt,_that.joinedAt,_that.memberFederationIds,_that.parentFederationIds,_that.memberCount,_that.parentCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  int? id,  String name, @FederationTypeConverter()  FederationType type, @JsonKey(name: 'address')  String streetAddress, @JsonKey(name: 'postalCode')  String postCode,  String city,  String country, @JsonKey(includeIfNull: false, name: 'logoUrl')  String? fedLogo, @JsonKey(includeIfNull: false, toJson: _dynamicListToJson)  List<DocumentModel> documents, @JsonKey(includeIfNull: false)  String? status, @JsonKey(name: 'createdAt', includeIfNull: false)  String? createdDate, @JsonKey(name: 'updatedAt', includeIfNull: false)  String? updatedAt, @JsonKey(includeIfNull: false)  String? joinedAt, @JsonKey(includeIfNull: false, toJson: _listToJson)  List<int>? memberFederationIds, @JsonKey(includeIfNull: false, toJson: _listToJson)  List<int>? parentFederationIds, @JsonKey(includeIfNull: false)  int? memberCount, @JsonKey(includeIfNull: false)  int? parentCount)?  $default,) {final _that = this;
switch (_that) {
case _FederationModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.streetAddress,_that.postCode,_that.city,_that.country,_that.fedLogo,_that.documents,_that.status,_that.createdDate,_that.updatedAt,_that.joinedAt,_that.memberFederationIds,_that.parentFederationIds,_that.memberCount,_that.parentCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FederationModel implements FederationModel {
  const _FederationModel({@JsonKey(includeIfNull: false) this.id, required this.name, @FederationTypeConverter() required this.type, @JsonKey(name: 'address') required this.streetAddress, @JsonKey(name: 'postalCode') required this.postCode, required this.city, required this.country, @JsonKey(includeIfNull: false, name: 'logoUrl') this.fedLogo, @JsonKey(includeIfNull: false, toJson: _dynamicListToJson) final  List<DocumentModel> documents = const [], @JsonKey(includeIfNull: false) this.status, @JsonKey(name: 'createdAt', includeIfNull: false) this.createdDate, @JsonKey(name: 'updatedAt', includeIfNull: false) this.updatedAt, @JsonKey(includeIfNull: false) this.joinedAt, @JsonKey(includeIfNull: false, toJson: _listToJson) final  List<int>? memberFederationIds, @JsonKey(includeIfNull: false, toJson: _listToJson) final  List<int>? parentFederationIds, @JsonKey(includeIfNull: false) this.memberCount, @JsonKey(includeIfNull: false) this.parentCount}): _documents = documents,_memberFederationIds = memberFederationIds,_parentFederationIds = parentFederationIds;
  factory _FederationModel.fromJson(Map<String, dynamic> json) => _$FederationModelFromJson(json);

@override@JsonKey(includeIfNull: false) final  int? id;
@override final  String name;
@override@FederationTypeConverter() final  FederationType type;
@override@JsonKey(name: 'address') final  String streetAddress;
@override@JsonKey(name: 'postalCode') final  String postCode;
@override final  String city;
@override final  String country;
@override@JsonKey(includeIfNull: false, name: 'logoUrl') final  String? fedLogo;
 final  List<DocumentModel> _documents;
@override@JsonKey(includeIfNull: false, toJson: _dynamicListToJson) List<DocumentModel> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

@override@JsonKey(includeIfNull: false) final  String? status;
@override@JsonKey(name: 'createdAt', includeIfNull: false) final  String? createdDate;
@override@JsonKey(name: 'updatedAt', includeIfNull: false) final  String? updatedAt;
@override@JsonKey(includeIfNull: false) final  String? joinedAt;
 final  List<int>? _memberFederationIds;
@override@JsonKey(includeIfNull: false, toJson: _listToJson) List<int>? get memberFederationIds {
  final value = _memberFederationIds;
  if (value == null) return null;
  if (_memberFederationIds is EqualUnmodifiableListView) return _memberFederationIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int>? _parentFederationIds;
@override@JsonKey(includeIfNull: false, toJson: _listToJson) List<int>? get parentFederationIds {
  final value = _parentFederationIds;
  if (value == null) return null;
  if (_parentFederationIds is EqualUnmodifiableListView) return _parentFederationIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false) final  int? memberCount;
@override@JsonKey(includeIfNull: false) final  int? parentCount;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FederationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.streetAddress, streetAddress) || other.streetAddress == streetAddress)&&(identical(other.postCode, postCode) || other.postCode == postCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.fedLogo, fedLogo) || other.fedLogo == fedLogo)&&const DeepCollectionEquality().equals(other._documents, _documents)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&const DeepCollectionEquality().equals(other._memberFederationIds, _memberFederationIds)&&const DeepCollectionEquality().equals(other._parentFederationIds, _parentFederationIds)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.parentCount, parentCount) || other.parentCount == parentCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,streetAddress,postCode,city,country,fedLogo,const DeepCollectionEquality().hash(_documents),status,createdDate,updatedAt,joinedAt,const DeepCollectionEquality().hash(_memberFederationIds),const DeepCollectionEquality().hash(_parentFederationIds),memberCount,parentCount);

@override
String toString() {
  return 'FederationModel(id: $id, name: $name, type: $type, streetAddress: $streetAddress, postCode: $postCode, city: $city, country: $country, fedLogo: $fedLogo, documents: $documents, status: $status, createdDate: $createdDate, updatedAt: $updatedAt, joinedAt: $joinedAt, memberFederationIds: $memberFederationIds, parentFederationIds: $parentFederationIds, memberCount: $memberCount, parentCount: $parentCount)';
}


}

/// @nodoc
abstract mixin class _$FederationModelCopyWith<$Res> implements $FederationModelCopyWith<$Res> {
  factory _$FederationModelCopyWith(_FederationModel value, $Res Function(_FederationModel) _then) = __$FederationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) int? id, String name,@FederationTypeConverter() FederationType type,@JsonKey(name: 'address') String streetAddress,@JsonKey(name: 'postalCode') String postCode, String city, String country,@JsonKey(includeIfNull: false, name: 'logoUrl') String? fedLogo,@JsonKey(includeIfNull: false, toJson: _dynamicListToJson) List<DocumentModel> documents,@JsonKey(includeIfNull: false) String? status,@JsonKey(name: 'createdAt', includeIfNull: false) String? createdDate,@JsonKey(name: 'updatedAt', includeIfNull: false) String? updatedAt,@JsonKey(includeIfNull: false) String? joinedAt,@JsonKey(includeIfNull: false, toJson: _listToJson) List<int>? memberFederationIds,@JsonKey(includeIfNull: false, toJson: _listToJson) List<int>? parentFederationIds,@JsonKey(includeIfNull: false) int? memberCount,@JsonKey(includeIfNull: false) int? parentCount
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? type = null,Object? streetAddress = null,Object? postCode = null,Object? city = null,Object? country = null,Object? fedLogo = freezed,Object? documents = null,Object? status = freezed,Object? createdDate = freezed,Object? updatedAt = freezed,Object? joinedAt = freezed,Object? memberFederationIds = freezed,Object? parentFederationIds = freezed,Object? memberCount = freezed,Object? parentCount = freezed,}) {
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
as List<DocumentModel>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdDate: freezed == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as String?,memberFederationIds: freezed == memberFederationIds ? _self._memberFederationIds : memberFederationIds // ignore: cast_nullable_to_non_nullable
as List<int>?,parentFederationIds: freezed == parentFederationIds ? _self._parentFederationIds : parentFederationIds // ignore: cast_nullable_to_non_nullable
as List<int>?,memberCount: freezed == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int?,parentCount: freezed == parentCount ? _self.parentCount : parentCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
