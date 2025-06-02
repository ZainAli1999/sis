// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceAction {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AttendanceAction);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AttendanceAction()';
  }
}

/// @nodoc
class $AttendanceActionCopyWith<$Res> {
  $AttendanceActionCopyWith(
      AttendanceAction _, $Res Function(AttendanceAction) __);
}

/// @nodoc

class CheckedIn implements AttendanceAction {
  const CheckedIn(this.data);

  final AttendanceModel data;

  /// Create a copy of AttendanceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CheckedInCopyWith<CheckedIn> get copyWith =>
      _$CheckedInCopyWithImpl<CheckedIn>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckedIn &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'AttendanceAction.checkedIn(data: $data)';
  }
}

/// @nodoc
abstract mixin class $CheckedInCopyWith<$Res>
    implements $AttendanceActionCopyWith<$Res> {
  factory $CheckedInCopyWith(CheckedIn value, $Res Function(CheckedIn) _then) =
      _$CheckedInCopyWithImpl;
  @useResult
  $Res call({AttendanceModel data});
}

/// @nodoc
class _$CheckedInCopyWithImpl<$Res> implements $CheckedInCopyWith<$Res> {
  _$CheckedInCopyWithImpl(this._self, this._then);

  final CheckedIn _self;
  final $Res Function(CheckedIn) _then;

  /// Create a copy of AttendanceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(CheckedIn(
      null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as AttendanceModel,
    ));
  }
}

/// @nodoc

class CheckedOut implements AttendanceAction {
  const CheckedOut(this.data);

  final AttendanceModel data;

  /// Create a copy of AttendanceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CheckedOutCopyWith<CheckedOut> get copyWith =>
      _$CheckedOutCopyWithImpl<CheckedOut>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckedOut &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'AttendanceAction.checkedOut(data: $data)';
  }
}

/// @nodoc
abstract mixin class $CheckedOutCopyWith<$Res>
    implements $AttendanceActionCopyWith<$Res> {
  factory $CheckedOutCopyWith(
          CheckedOut value, $Res Function(CheckedOut) _then) =
      _$CheckedOutCopyWithImpl;
  @useResult
  $Res call({AttendanceModel data});
}

/// @nodoc
class _$CheckedOutCopyWithImpl<$Res> implements $CheckedOutCopyWith<$Res> {
  _$CheckedOutCopyWithImpl(this._self, this._then);

  final CheckedOut _self;
  final $Res Function(CheckedOut) _then;

  /// Create a copy of AttendanceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(CheckedOut(
      null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as AttendanceModel,
    ));
  }
}

/// @nodoc

class LateCheckInRequired implements AttendanceAction {
  const LateCheckInRequired();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LateCheckInRequired);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AttendanceAction.lateCheckInRequired()';
  }
}

/// @nodoc

class AlreadyCheckedIn implements AttendanceAction {
  const AlreadyCheckedIn();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AlreadyCheckedIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AttendanceAction.alreadyCheckedIn()';
  }
}

/// @nodoc

class MarkedAbsent implements AttendanceAction {
  const MarkedAbsent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MarkedAbsent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AttendanceAction.markedAbsent()';
  }
}

/// @nodoc

class InvalidIP implements AttendanceAction {
  const InvalidIP();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InvalidIP);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AttendanceAction.invalidIP()';
  }
}

// dart format on
