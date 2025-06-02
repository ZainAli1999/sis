// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyReportsHash() => r'7aa63674522e32c0edf17de98abbbbf1bd20f78f';

/// See also [dailyReports].
@ProviderFor(dailyReports)
final dailyReportsProvider =
    AutoDisposeStreamProvider<List<DailyReportModel>>.internal(
  dailyReports,
  name: r'dailyReportsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dailyReportsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyReportsRef = AutoDisposeStreamProviderRef<List<DailyReportModel>>;
String _$dailyReportByIdHash() => r'588e965a58f30fdc1063ae5f85df650474f9a128';

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

/// See also [dailyReportById].
@ProviderFor(dailyReportById)
const dailyReportByIdProvider = DailyReportByIdFamily();

/// See also [dailyReportById].
class DailyReportByIdFamily extends Family<AsyncValue<DailyReportModel>> {
  /// See also [dailyReportById].
  const DailyReportByIdFamily();

  /// See also [dailyReportById].
  DailyReportByIdProvider call(
    String id,
  ) {
    return DailyReportByIdProvider(
      id,
    );
  }

  @override
  DailyReportByIdProvider getProviderOverride(
    covariant DailyReportByIdProvider provider,
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
  String? get name => r'dailyReportByIdProvider';
}

/// See also [dailyReportById].
class DailyReportByIdProvider
    extends AutoDisposeFutureProvider<DailyReportModel> {
  /// See also [dailyReportById].
  DailyReportByIdProvider(
    String id,
  ) : this._internal(
          (ref) => dailyReportById(
            ref as DailyReportByIdRef,
            id,
          ),
          from: dailyReportByIdProvider,
          name: r'dailyReportByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dailyReportByIdHash,
          dependencies: DailyReportByIdFamily._dependencies,
          allTransitiveDependencies:
              DailyReportByIdFamily._allTransitiveDependencies,
          id: id,
        );

  DailyReportByIdProvider._internal(
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
    FutureOr<DailyReportModel> Function(DailyReportByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DailyReportByIdProvider._internal(
        (ref) => create(ref as DailyReportByIdRef),
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
  AutoDisposeFutureProviderElement<DailyReportModel> createElement() {
    return _DailyReportByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyReportByIdProvider && other.id == id;
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
mixin DailyReportByIdRef on AutoDisposeFutureProviderRef<DailyReportModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DailyReportByIdProviderElement
    extends AutoDisposeFutureProviderElement<DailyReportModel>
    with DailyReportByIdRef {
  _DailyReportByIdProviderElement(super.provider);

  @override
  String get id => (origin as DailyReportByIdProvider).id;
}

String _$dailyViewModelHash() => r'3e3ef8e43277435834428bfb19ea1ba8bb3bb020';

/// See also [DailyViewModel].
@ProviderFor(DailyViewModel)
final dailyViewModelProvider =
    AutoDisposeNotifierProvider<DailyViewModel, AsyncValue?>.internal(
  DailyViewModel.new,
  name: r'dailyViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DailyViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
