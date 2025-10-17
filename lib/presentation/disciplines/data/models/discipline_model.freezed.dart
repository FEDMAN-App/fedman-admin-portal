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
mixin _$CategoryModel {

 String get categoryName; List<String> get categoryValues;
/// Create a copy of CategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<CategoryModel> get copyWith => _$CategoryModelCopyWithImpl<CategoryModel>(this as CategoryModel, _$identity);

  /// Serializes this CategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryModel&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other.categoryValues, categoryValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryName,const DeepCollectionEquality().hash(categoryValues));

@override
String toString() {
  return 'CategoryModel(categoryName: $categoryName, categoryValues: $categoryValues)';
}


}

/// @nodoc
abstract mixin class $CategoryModelCopyWith<$Res>  {
  factory $CategoryModelCopyWith(CategoryModel value, $Res Function(CategoryModel) _then) = _$CategoryModelCopyWithImpl;
@useResult
$Res call({
 String categoryName, List<String> categoryValues
});




}
/// @nodoc
class _$CategoryModelCopyWithImpl<$Res>
    implements $CategoryModelCopyWith<$Res> {
  _$CategoryModelCopyWithImpl(this._self, this._then);

  final CategoryModel _self;
  final $Res Function(CategoryModel) _then;

/// Create a copy of CategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryName = null,Object? categoryValues = null,}) {
  return _then(_self.copyWith(
categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryValues: null == categoryValues ? _self.categoryValues : categoryValues // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryModel].
extension CategoryModelPatterns on CategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _CategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryName,  List<String> categoryValues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryModel() when $default != null:
return $default(_that.categoryName,_that.categoryValues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryName,  List<String> categoryValues)  $default,) {final _that = this;
switch (_that) {
case _CategoryModel():
return $default(_that.categoryName,_that.categoryValues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryName,  List<String> categoryValues)?  $default,) {final _that = this;
switch (_that) {
case _CategoryModel() when $default != null:
return $default(_that.categoryName,_that.categoryValues);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryModel implements CategoryModel {
  const _CategoryModel({required this.categoryName, required final  List<String> categoryValues}): _categoryValues = categoryValues;
  factory _CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

@override final  String categoryName;
 final  List<String> _categoryValues;
@override List<String> get categoryValues {
  if (_categoryValues is EqualUnmodifiableListView) return _categoryValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryValues);
}


/// Create a copy of CategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryModelCopyWith<_CategoryModel> get copyWith => __$CategoryModelCopyWithImpl<_CategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryModel&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other._categoryValues, _categoryValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryName,const DeepCollectionEquality().hash(_categoryValues));

@override
String toString() {
  return 'CategoryModel(categoryName: $categoryName, categoryValues: $categoryValues)';
}


}

/// @nodoc
abstract mixin class _$CategoryModelCopyWith<$Res> implements $CategoryModelCopyWith<$Res> {
  factory _$CategoryModelCopyWith(_CategoryModel value, $Res Function(_CategoryModel) _then) = __$CategoryModelCopyWithImpl;
@override @useResult
$Res call({
 String categoryName, List<String> categoryValues
});




}
/// @nodoc
class __$CategoryModelCopyWithImpl<$Res>
    implements _$CategoryModelCopyWith<$Res> {
  __$CategoryModelCopyWithImpl(this._self, this._then);

  final _CategoryModel _self;
  final $Res Function(_CategoryModel) _then;

/// Create a copy of CategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryName = null,Object? categoryValues = null,}) {
  return _then(_CategoryModel(
categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryValues: null == categoryValues ? _self._categoryValues : categoryValues // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$LevelModel {

 String get levelName; List<CategoryModel> get categories; List<String> get classTypes;
/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LevelModelCopyWith<LevelModel> get copyWith => _$LevelModelCopyWithImpl<LevelModel>(this as LevelModel, _$identity);

  /// Serializes this LevelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelModel&&(identical(other.levelName, levelName) || other.levelName == levelName)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.classTypes, classTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,levelName,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(classTypes));

@override
String toString() {
  return 'LevelModel(levelName: $levelName, categories: $categories, classTypes: $classTypes)';
}


}

/// @nodoc
abstract mixin class $LevelModelCopyWith<$Res>  {
  factory $LevelModelCopyWith(LevelModel value, $Res Function(LevelModel) _then) = _$LevelModelCopyWithImpl;
@useResult
$Res call({
 String levelName, List<CategoryModel> categories, List<String> classTypes
});




}
/// @nodoc
class _$LevelModelCopyWithImpl<$Res>
    implements $LevelModelCopyWith<$Res> {
  _$LevelModelCopyWithImpl(this._self, this._then);

  final LevelModel _self;
  final $Res Function(LevelModel) _then;

/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? levelName = null,Object? categories = null,Object? classTypes = null,}) {
  return _then(_self.copyWith(
levelName: null == levelName ? _self.levelName : levelName // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,classTypes: null == classTypes ? _self.classTypes : classTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [LevelModel].
extension LevelModelPatterns on LevelModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LevelModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LevelModel value)  $default,){
final _that = this;
switch (_that) {
case _LevelModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LevelModel value)?  $default,){
final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String levelName,  List<CategoryModel> categories,  List<String> classTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that.levelName,_that.categories,_that.classTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String levelName,  List<CategoryModel> categories,  List<String> classTypes)  $default,) {final _that = this;
switch (_that) {
case _LevelModel():
return $default(_that.levelName,_that.categories,_that.classTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String levelName,  List<CategoryModel> categories,  List<String> classTypes)?  $default,) {final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that.levelName,_that.categories,_that.classTypes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LevelModel implements LevelModel {
  const _LevelModel({required this.levelName, required final  List<CategoryModel> categories, required final  List<String> classTypes}): _categories = categories,_classTypes = classTypes;
  factory _LevelModel.fromJson(Map<String, dynamic> json) => _$LevelModelFromJson(json);

@override final  String levelName;
 final  List<CategoryModel> _categories;
@override List<CategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<String> _classTypes;
@override List<String> get classTypes {
  if (_classTypes is EqualUnmodifiableListView) return _classTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_classTypes);
}


/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LevelModelCopyWith<_LevelModel> get copyWith => __$LevelModelCopyWithImpl<_LevelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LevelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LevelModel&&(identical(other.levelName, levelName) || other.levelName == levelName)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._classTypes, _classTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,levelName,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_classTypes));

@override
String toString() {
  return 'LevelModel(levelName: $levelName, categories: $categories, classTypes: $classTypes)';
}


}

/// @nodoc
abstract mixin class _$LevelModelCopyWith<$Res> implements $LevelModelCopyWith<$Res> {
  factory _$LevelModelCopyWith(_LevelModel value, $Res Function(_LevelModel) _then) = __$LevelModelCopyWithImpl;
@override @useResult
$Res call({
 String levelName, List<CategoryModel> categories, List<String> classTypes
});




}
/// @nodoc
class __$LevelModelCopyWithImpl<$Res>
    implements _$LevelModelCopyWith<$Res> {
  __$LevelModelCopyWithImpl(this._self, this._then);

  final _LevelModel _self;
  final $Res Function(_LevelModel) _then;

/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? levelName = null,Object? categories = null,Object? classTypes = null,}) {
  return _then(_LevelModel(
levelName: null == levelName ? _self.levelName : levelName // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,classTypes: null == classTypes ? _self._classTypes : classTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$DisciplineModel {

@JsonKey(includeIfNull: false) int? get id; String get name; List<LevelModel> get levels; bool get hasRanking; SportType get sportType;@JsonKey(includeIfNull: false) String? get logoUrl;@JsonKey(includeIfNull: false) String? get status;@JsonKey(includeIfNull: false) DateTime? get createdAt;@JsonKey(includeIfNull: false) DateTime? get updatedAt;
/// Create a copy of DisciplineModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisciplineModelCopyWith<DisciplineModel> get copyWith => _$DisciplineModelCopyWithImpl<DisciplineModel>(this as DisciplineModel, _$identity);

  /// Serializes this DisciplineModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisciplineModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.levels, levels)&&(identical(other.hasRanking, hasRanking) || other.hasRanking == hasRanking)&&(identical(other.sportType, sportType) || other.sportType == sportType)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(levels),hasRanking,sportType,logoUrl,status,createdAt,updatedAt);

@override
String toString() {
  return 'DisciplineModel(id: $id, name: $name, levels: $levels, hasRanking: $hasRanking, sportType: $sportType, logoUrl: $logoUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DisciplineModelCopyWith<$Res>  {
  factory $DisciplineModelCopyWith(DisciplineModel value, $Res Function(DisciplineModel) _then) = _$DisciplineModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) int? id, String name, List<LevelModel> levels, bool hasRanking, SportType sportType,@JsonKey(includeIfNull: false) String? logoUrl,@JsonKey(includeIfNull: false) String? status,@JsonKey(includeIfNull: false) DateTime? createdAt,@JsonKey(includeIfNull: false) DateTime? updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? levels = null,Object? hasRanking = null,Object? sportType = null,Object? logoUrl = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,levels: null == levels ? _self.levels : levels // ignore: cast_nullable_to_non_nullable
as List<LevelModel>,hasRanking: null == hasRanking ? _self.hasRanking : hasRanking // ignore: cast_nullable_to_non_nullable
as bool,sportType: null == sportType ? _self.sportType : sportType // ignore: cast_nullable_to_non_nullable
as SportType,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? id,  String name,  List<LevelModel> levels,  bool hasRanking,  SportType sportType, @JsonKey(includeIfNull: false)  String? logoUrl, @JsonKey(includeIfNull: false)  String? status, @JsonKey(includeIfNull: false)  DateTime? createdAt, @JsonKey(includeIfNull: false)  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisciplineModel() when $default != null:
return $default(_that.id,_that.name,_that.levels,_that.hasRanking,_that.sportType,_that.logoUrl,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? id,  String name,  List<LevelModel> levels,  bool hasRanking,  SportType sportType, @JsonKey(includeIfNull: false)  String? logoUrl, @JsonKey(includeIfNull: false)  String? status, @JsonKey(includeIfNull: false)  DateTime? createdAt, @JsonKey(includeIfNull: false)  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DisciplineModel():
return $default(_that.id,_that.name,_that.levels,_that.hasRanking,_that.sportType,_that.logoUrl,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  int? id,  String name,  List<LevelModel> levels,  bool hasRanking,  SportType sportType, @JsonKey(includeIfNull: false)  String? logoUrl, @JsonKey(includeIfNull: false)  String? status, @JsonKey(includeIfNull: false)  DateTime? createdAt, @JsonKey(includeIfNull: false)  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DisciplineModel() when $default != null:
return $default(_that.id,_that.name,_that.levels,_that.hasRanking,_that.sportType,_that.logoUrl,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DisciplineModel implements DisciplineModel {
  const _DisciplineModel({@JsonKey(includeIfNull: false) this.id, required this.name, required final  List<LevelModel> levels, required this.hasRanking, required this.sportType, @JsonKey(includeIfNull: false) this.logoUrl, @JsonKey(includeIfNull: false) this.status, @JsonKey(includeIfNull: false) this.createdAt, @JsonKey(includeIfNull: false) this.updatedAt}): _levels = levels;
  factory _DisciplineModel.fromJson(Map<String, dynamic> json) => _$DisciplineModelFromJson(json);

@override@JsonKey(includeIfNull: false) final  int? id;
@override final  String name;
 final  List<LevelModel> _levels;
@override List<LevelModel> get levels {
  if (_levels is EqualUnmodifiableListView) return _levels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_levels);
}

@override final  bool hasRanking;
@override final  SportType sportType;
@override@JsonKey(includeIfNull: false) final  String? logoUrl;
@override@JsonKey(includeIfNull: false) final  String? status;
@override@JsonKey(includeIfNull: false) final  DateTime? createdAt;
@override@JsonKey(includeIfNull: false) final  DateTime? updatedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisciplineModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._levels, _levels)&&(identical(other.hasRanking, hasRanking) || other.hasRanking == hasRanking)&&(identical(other.sportType, sportType) || other.sportType == sportType)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_levels),hasRanking,sportType,logoUrl,status,createdAt,updatedAt);

@override
String toString() {
  return 'DisciplineModel(id: $id, name: $name, levels: $levels, hasRanking: $hasRanking, sportType: $sportType, logoUrl: $logoUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DisciplineModelCopyWith<$Res> implements $DisciplineModelCopyWith<$Res> {
  factory _$DisciplineModelCopyWith(_DisciplineModel value, $Res Function(_DisciplineModel) _then) = __$DisciplineModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) int? id, String name, List<LevelModel> levels, bool hasRanking, SportType sportType,@JsonKey(includeIfNull: false) String? logoUrl,@JsonKey(includeIfNull: false) String? status,@JsonKey(includeIfNull: false) DateTime? createdAt,@JsonKey(includeIfNull: false) DateTime? updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? levels = null,Object? hasRanking = null,Object? sportType = null,Object? logoUrl = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_DisciplineModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,levels: null == levels ? _self._levels : levels // ignore: cast_nullable_to_non_nullable
as List<LevelModel>,hasRanking: null == hasRanking ? _self.hasRanking : hasRanking // ignore: cast_nullable_to_non_nullable
as bool,sportType: null == sportType ? _self.sportType : sportType // ignore: cast_nullable_to_non_nullable
as SportType,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
