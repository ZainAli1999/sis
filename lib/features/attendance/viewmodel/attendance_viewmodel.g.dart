// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAttendanceStatusByUidHash() =>
    r'3fe9a0db13fa0c6e59376569260672ef044c3c11';

/// See also [getAttendanceStatusByUid].
@ProviderFor(getAttendanceStatusByUid)
final getAttendanceStatusByUidProvider =
    AutoDisposeStreamProvider<int?>.internal(
  getAttendanceStatusByUid,
  name: r'getAttendanceStatusByUidProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAttendanceStatusByUidHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAttendanceStatusByUidRef = AutoDisposeStreamProviderRef<int?>;
String _$fetchAttendanceHash() => r'928ab3f6418bda9a15390b5348e4b60dcb588f61';

/// See also [fetchAttendance].
@ProviderFor(fetchAttendance)
final fetchAttendanceProvider =
    AutoDisposeStreamProvider<List<AttendanceModel>>.internal(
  fetchAttendance,
  name: r'fetchAttendanceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAttendanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchAttendanceRef
    = AutoDisposeStreamProviderRef<List<AttendanceModel>>;
String _$getAttendanceIdByUidHash() =>
    r'8cf015ba2b458902e50d510d88541365b476a28b';

/// See also [getAttendanceIdByUid].
@ProviderFor(getAttendanceIdByUid)
final getAttendanceIdByUidProvider =
    AutoDisposeFutureProvider<String?>.internal(
  getAttendanceIdByUid,
  name: r'getAttendanceIdByUidProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAttendanceIdByUidHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAttendanceIdByUidRef = AutoDisposeFutureProviderRef<String?>;
String _$attendanceViewModelHash() =>
    r'a4cd6f5a4f08590b8224ab8eb5f0b3d8848d292f';

/// See also [AttendanceViewModel].
@ProviderFor(AttendanceViewModel)
final attendanceViewModelProvider =
    AutoDisposeNotifierProvider<AttendanceViewModel, AsyncValue?>.internal(
  AttendanceViewModel.new,
  name: r'attendanceViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$attendanceViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AttendanceViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
