// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$meetingsHash() => r'e0f3cc5914ea495cf9d91d55f45abf58d9552363';

/// See also [meetings].
@ProviderFor(meetings)
final meetingsProvider = AutoDisposeStreamProvider<List<MeetingModel>>.internal(
  meetings,
  name: r'meetingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$meetingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MeetingsRef = AutoDisposeStreamProviderRef<List<MeetingModel>>;
String _$getMeetingByIdHash() => r'e468b8c885acc42a2bbd84407d1aa94de04e49e3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getMeetingById].
@ProviderFor(getMeetingById)
const getMeetingByIdProvider = GetMeetingByIdFamily();

/// See also [getMeetingById].
class GetMeetingByIdFamily extends Family<AsyncValue<MeetingModel>> {
  /// See also [getMeetingById].
  const GetMeetingByIdFamily();

  /// See also [getMeetingById].
  GetMeetingByIdProvider call(
    String id,
  ) {
    return GetMeetingByIdProvider(
      id,
    );
  }

  @override
  GetMeetingByIdProvider getProviderOverride(
    covariant GetMeetingByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getMeetingByIdProvider';
}

/// See also [getMeetingById].
class GetMeetingByIdProvider extends AutoDisposeFutureProvider<MeetingModel> {
  /// See also [getMeetingById].
  GetMeetingByIdProvider(
    String id,
  ) : this._internal(
          (ref) => getMeetingById(
            ref as GetMeetingByIdRef,
            id,
          ),
          from: getMeetingByIdProvider,
          name: r'getMeetingByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMeetingByIdHash,
          dependencies: GetMeetingByIdFamily._dependencies,
          allTransitiveDependencies:
              GetMeetingByIdFamily._allTransitiveDependencies,
          id: id,
        );

  GetMeetingByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<MeetingModel> Function(GetMeetingByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMeetingByIdProvider._internal(
        (ref) => create(ref as GetMeetingByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MeetingModel> createElement() {
    return _GetMeetingByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMeetingByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetMeetingByIdRef on AutoDisposeFutureProviderRef<MeetingModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GetMeetingByIdProviderElement
    extends AutoDisposeFutureProviderElement<MeetingModel>
    with GetMeetingByIdRef {
  _GetMeetingByIdProviderElement(super.provider);

  @override
  String get id => (origin as GetMeetingByIdProvider).id;
}

String _$meetingViewModelHash() => r'd3ec98ef4fcf3db2c1d1ab82c18c319f08f77f30';

/// See also [MeetingViewModel].
@ProviderFor(MeetingViewModel)
final meetingViewModelProvider =
    AutoDisposeNotifierProvider<MeetingViewModel, AsyncValue?>.internal(
  MeetingViewModel.new,
  name: r'meetingViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$meetingViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MeetingViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
