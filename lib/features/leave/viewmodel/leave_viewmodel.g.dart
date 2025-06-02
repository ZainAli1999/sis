// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchLeavesHash() => r'446f2d2855f9ad898b5c5c928963c54466dc69f6';

/// See also [fetchLeaves].
@ProviderFor(fetchLeaves)
final fetchLeavesProvider =
    AutoDisposeStreamProvider<List<LeaveModel>>.internal(
  fetchLeaves,
  name: r'fetchLeavesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchLeavesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchLeavesRef = AutoDisposeStreamProviderRef<List<LeaveModel>>;
String _$leaveViewModelHash() => r'8aa8313ad9818e90cb668a40c999de6b4a4fce5a';

/// See also [LeaveViewModel].
@ProviderFor(LeaveViewModel)
final leaveViewModelProvider =
    AutoDisposeNotifierProvider<LeaveViewModel, AsyncValue?>.internal(
  LeaveViewModel.new,
  name: r'leaveViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$leaveViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LeaveViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
