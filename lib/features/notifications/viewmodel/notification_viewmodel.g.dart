// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMyNotificationsHash() =>
    r'03a049dd09207fb1f518bc942e2a5dd8db21ae22';

/// See also [fetchMyNotifications].
@ProviderFor(fetchMyNotifications)
final fetchMyNotificationsProvider =
    AutoDisposeStreamProvider<List<NotificationModel>>.internal(
  fetchMyNotifications,
  name: r'fetchMyNotificationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchMyNotificationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchMyNotificationsRef
    = AutoDisposeStreamProviderRef<List<NotificationModel>>;
String _$notificationViewModelHash() =>
    r'60b55428529d6133e58f8bfce2dec70ff3e45f49';

/// See also [NotificationViewModel].
@ProviderFor(NotificationViewModel)
final notificationViewModelProvider =
    AutoDisposeNotifierProvider<NotificationViewModel, AsyncValue?>.internal(
  NotificationViewModel.new,
  name: r'notificationViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
