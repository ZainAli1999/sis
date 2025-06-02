// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientByIdHash() => r'b06107ed8b4d3841b838ee35b583757134272585';

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

/// See also [clientById].
@ProviderFor(clientById)
const clientByIdProvider = ClientByIdFamily();

/// See also [clientById].
class ClientByIdFamily extends Family<AsyncValue<ClientModel>> {
  /// See also [clientById].
  const ClientByIdFamily();

  /// See also [clientById].
  ClientByIdProvider call(
    String id,
  ) {
    return ClientByIdProvider(
      id,
    );
  }

  @override
  ClientByIdProvider getProviderOverride(
    covariant ClientByIdProvider provider,
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
  String? get name => r'clientByIdProvider';
}

/// See also [clientById].
class ClientByIdProvider extends AutoDisposeFutureProvider<ClientModel> {
  /// See also [clientById].
  ClientByIdProvider(
    String id,
  ) : this._internal(
          (ref) => clientById(
            ref as ClientByIdRef,
            id,
          ),
          from: clientByIdProvider,
          name: r'clientByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clientByIdHash,
          dependencies: ClientByIdFamily._dependencies,
          allTransitiveDependencies:
              ClientByIdFamily._allTransitiveDependencies,
          id: id,
        );

  ClientByIdProvider._internal(
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
    FutureOr<ClientModel> Function(ClientByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClientByIdProvider._internal(
        (ref) => create(ref as ClientByIdRef),
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
  AutoDisposeFutureProviderElement<ClientModel> createElement() {
    return _ClientByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientByIdProvider && other.id == id;
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
mixin ClientByIdRef on AutoDisposeFutureProviderRef<ClientModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ClientByIdProviderElement
    extends AutoDisposeFutureProviderElement<ClientModel> with ClientByIdRef {
  _ClientByIdProviderElement(super.provider);

  @override
  String get id => (origin as ClientByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
