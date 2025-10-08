// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discipline_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DisciplineModel {

 String get id; String get name; int get levels; bool get rankingEnabled; List<String> get levelNames; String? get description; DateTime? get createdAt; DateTime? get updatedAt; bool? get isActive;
/// Create a copy of DisciplineModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisciplineModelCopyWith<DisciplineModel> get copyWith => _$DisciplineModelCopyWithImpl<DisciplineModel>(this as DisciplineModel, _$identity);

  /// Serializes this DisciplineModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisciplineModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.levels, levels) || other.levels == levels)&&(identical(other.rankingEnabled, rankingEnabled) || other.rankingEnabled == rankingEnabled)&&const DeepCollectionEquality().equals(other.levelNames, levelNames)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,levels,rankingEnabled,const DeepCollectionEquality().hash(levelNames),description,createdAt,updatedAt,isActive);

@override
String toString() {
  return 'DisciplineModel(id: $id, name: $name, levels: $levels, rankingEnabled: $rankingEnabled, levelNames: $levelNames, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $DisciplineModelCopyWith<$Res>  {
  factory $DisciplineModelCopyWith(DisciplineModel value, $Res Function(DisciplineModel) _then) = _$DisciplineModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, int levels, bool rankingEnabled, List<String> levelNames, String? description, DateTime? createdAt, DateTime? updatedAt, bool? isActive
});




}
/// @nodoc
class _$DisciplineModelCopyWithImpl<$Res>
    implements $DisciplineModelCopyWith<$Res> {
  _$DisciplineModelCopyWithImpl(this._self, this._then);

  final DisciplineModel _self;
  final $Res Function(DisciplineModel) _then;

/// Create a copy of DisciplineModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? levels = null,Object? rankingEnabled = null,Object? levelNames = null,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isActive = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,levels: null == levels ? _self.levels : levels // ignore: cast_nullable_to_non_nullable
as int,rankingEnabled: null == rankingEnabled ? _self.rankingEnabled : rankingEnabled // ignore: cast_nullable_to_non_nullable
as bool,levelNames: null == levelNames ? _self.levelNames : levelNames // ignore: cast_nullable_to_non_nullable
as List<String>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [DisciplineModel].
extension DisciplineModelPatterns on DisciplineModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisciplineModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisciplineModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisciplineModel value)  $default,){
final _that = this;
switch (_that) {
case _DisciplineModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisciplineModel value)?  $default,){
final _that = this;
switch (_that) {
case _DisciplineModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int levels,  bool rankingEnabled,  List<String> levelNames,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  bool? isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisciplineModel() when $default != null:
return $default(_that.id,_that.name,_that.levels,_that.rankingEnabled,_that.levelNames,_that.description,_that.createdAt,_that.updatedAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int levels,  bool rankingEnabled,  List<String> levelNames,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  bool? isActive)  $default,) {final _that = this;
switch (_that) {
case _DisciplineModel():
return $default(_that.id,_that.name,_that.levels,_that.rankingEnabled,_that.levelNames,_that.description,_that.createdAt,_that.updatedAt,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int levels,  bool rankingEnabled,  List<String> levelNames,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  bool? isActive)?  $default,) {final _that = this;
switch (_that) {
case _DisciplineModel() when $default != null:
return $default(_that.id,_that.name,_that.levels,_that.rankingEnabled,_that.levelNames,_that.description,_that.createdAt,_that.updatedAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DisciplineModel implements DisciplineModel {
  const _DisciplineModel({required this.id, required this.name, required this.levels, required this.rankingEnabled, required final  List<String> levelNames, this.description, this.createdAt, this.updatedAt, this.isActive}): _levelNames = levelNames;
  factory _DisciplineModel.fromJson(Map<String, dynamic> json) => _$DisciplineModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  int levels;
@override final  bool rankingEnabled;
 final  List<String> _levelNames;
@override List<String> get levelNames {
  if (_levelNames is EqualUnmodifiableListView) return _levelNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_levelNames);
}

@override final  String? description;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  bool? isActive;

/// Create a copy of DisciplineModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisciplineModelCopyWith<_DisciplineModel> get copyWith => __$DisciplineModelCopyWithImpl<_DisciplineModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisciplineModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisciplineModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.levels, levels) || other.levels == levels)&&(identical(other.rankingEnabled, rankingEnabled) || other.rankingEnabled == rankingEnabled)&&const DeepCollectionEquality().equals(other._levelNames, _levelNames)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,levels,rankingEnabled,const DeepCollectionEquality().hash(_levelNames),description,createdAt,updatedAt,isActive);

@override
String toString() {
  return 'DisciplineModel(id: $id, name: $name, levels: $levels, rankingEnabled: $rankingEnabled, levelNames: $levelNames, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$DisciplineModelCopyWith<$Res> implements $DisciplineModelCopyWith<$Res> {
  factory _$DisciplineModelCopyWith(_DisciplineModel value, $Res Function(_DisciplineModel) _then) = __$DisciplineModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int levels, bool rankingEnabled, List<String> levelNames, String? description, DateTime? createdAt, DateTime? updatedAt, bool? isActive
});




}
/// @nodoc
class __$DisciplineModelCopyWithImpl<$Res>
    implements _$DisciplineModelCopyWith<$Res> {
  __$DisciplineModelCopyWithImpl(this._self, this._then);

  final _DisciplineModel _self;
  final $Res Function(_DisciplineModel) _then;

/// Create a copy of DisciplineModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? levels = null,Object? rankingEnabled = null,Object? levelNames = null,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isActive = freezed,}) {
  return _then(_DisciplineModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,levels: null == levels ? _self.levels : levels // ignore: cast_nullable_to_non_nullable
as int,rankingEnabled: null == rankingEnabled ? _self.rankingEnabled : rankingEnabled // ignore: cast_nullable_to_non_nullable
as bool,levelNames: null == levelNames ? _self._levelNames : levelNames // ignore: cast_nullable_to_non_nullable
as List<String>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
