// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'87dfc9019abaaa0715a82a1c4ec22a79ba11f2eb';

/// See also [projects].
@ProviderFor(projects)
final projectsProvider = AutoDisposeStreamProvider<List<ProjectModel>>.internal(
  projects,
  name: r'projectsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$projectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProjectsRef = AutoDisposeStreamProviderRef<List<ProjectModel>>;
String _$projectByIdHash() => r'25aaf807d24f2daad99d1b40ef2b94bfcbf05ca6';

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

/// See also [projectById].
@ProviderFor(projectById)
const projectByIdProvider = ProjectByIdFamily();

/// See also [projectById].
class ProjectByIdFamily extends Family<AsyncValue<ProjectModel>> {
  /// See also [projectById].
  const ProjectByIdFamily();

  /// See also [projectById].
  ProjectByIdProvider call(
    String id,
  ) {
    return ProjectByIdProvider(
      id,
    );
  }

  @override
  ProjectByIdProvider getProviderOverride(
    covariant ProjectByIdProvider provider,
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
  String? get name => r'projectByIdProvider';
}

/// See also [projectById].
class ProjectByIdProvider extends AutoDisposeFutureProvider<ProjectModel> {
  /// See also [projectById].
  ProjectByIdProvider(
    String id,
  ) : this._internal(
          (ref) => projectById(
            ref as ProjectByIdRef,
            id,
          ),
          from: projectByIdProvider,
          name: r'projectByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectByIdHash,
          dependencies: ProjectByIdFamily._dependencies,
          allTransitiveDependencies:
              ProjectByIdFamily._allTransitiveDependencies,
          id: id,
        );

  ProjectByIdProvider._internal(
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
    FutureOr<ProjectModel> Function(ProjectByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProjectByIdProvider._internal(
        (ref) => create(ref as ProjectByIdRef),
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
  AutoDisposeFutureProviderElement<ProjectModel> createElement() {
    return _ProjectByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectByIdProvider && other.id == id;
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
mixin ProjectByIdRef on AutoDisposeFutureProviderRef<ProjectModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProjectByIdProviderElement
    extends AutoDisposeFutureProviderElement<ProjectModel> with ProjectByIdRef {
  _ProjectByIdProviderElement(super.provider);

  @override
  String get id => (origin as ProjectByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
