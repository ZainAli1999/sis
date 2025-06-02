// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchTasksHash() => r'8a4fa3fb4c4fa62ca7f69cb6b3785faa1bf81fef';

/// See also [fetchTasks].
@ProviderFor(fetchTasks)
final fetchTasksProvider = AutoDisposeStreamProvider<List<TaskModel>>.internal(
  fetchTasks,
  name: r'fetchTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchTasksRef = AutoDisposeStreamProviderRef<List<TaskModel>>;
String _$tasksByStatusHash() => r'a2ee49bf5de7362ab70b814987d056c10b3319e5';

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

/// See also [tasksByStatus].
@ProviderFor(tasksByStatus)
const tasksByStatusProvider = TasksByStatusFamily();

/// See also [tasksByStatus].
class TasksByStatusFamily extends Family<AsyncValue<List<TaskModel>>> {
  /// See also [tasksByStatus].
  const TasksByStatusFamily();

  /// See also [tasksByStatus].
  TasksByStatusProvider call(
    int status,
  ) {
    return TasksByStatusProvider(
      status,
    );
  }

  @override
  TasksByStatusProvider getProviderOverride(
    covariant TasksByStatusProvider provider,
  ) {
    return call(
      provider.status,
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
  String? get name => r'tasksByStatusProvider';
}

/// See also [tasksByStatus].
class TasksByStatusProvider extends AutoDisposeStreamProvider<List<TaskModel>> {
  /// See also [tasksByStatus].
  TasksByStatusProvider(
    int status,
  ) : this._internal(
          (ref) => tasksByStatus(
            ref as TasksByStatusRef,
            status,
          ),
          from: tasksByStatusProvider,
          name: r'tasksByStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tasksByStatusHash,
          dependencies: TasksByStatusFamily._dependencies,
          allTransitiveDependencies:
              TasksByStatusFamily._allTransitiveDependencies,
          status: status,
        );

  TasksByStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final int status;

  @override
  Override overrideWith(
    Stream<List<TaskModel>> Function(TasksByStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TasksByStatusProvider._internal(
        (ref) => create(ref as TasksByStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<TaskModel>> createElement() {
    return _TasksByStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TasksByStatusProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TasksByStatusRef on AutoDisposeStreamProviderRef<List<TaskModel>> {
  /// The parameter `status` of this provider.
  int get status;
}

class _TasksByStatusProviderElement
    extends AutoDisposeStreamProviderElement<List<TaskModel>>
    with TasksByStatusRef {
  _TasksByStatusProviderElement(super.provider);

  @override
  int get status => (origin as TasksByStatusProvider).status;
}

String _$getTaskByIdHash() => r'0106dcb7307cd7d7bd1fdea48af73a8c47b48f1b';

/// See also [getTaskById].
@ProviderFor(getTaskById)
const getTaskByIdProvider = GetTaskByIdFamily();

/// See also [getTaskById].
class GetTaskByIdFamily extends Family<AsyncValue<TaskModel>> {
  /// See also [getTaskById].
  const GetTaskByIdFamily();

  /// See also [getTaskById].
  GetTaskByIdProvider call(
    String id,
  ) {
    return GetTaskByIdProvider(
      id,
    );
  }

  @override
  GetTaskByIdProvider getProviderOverride(
    covariant GetTaskByIdProvider provider,
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
  String? get name => r'getTaskByIdProvider';
}

/// See also [getTaskById].
class GetTaskByIdProvider extends AutoDisposeFutureProvider<TaskModel> {
  /// See also [getTaskById].
  GetTaskByIdProvider(
    String id,
  ) : this._internal(
          (ref) => getTaskById(
            ref as GetTaskByIdRef,
            id,
          ),
          from: getTaskByIdProvider,
          name: r'getTaskByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTaskByIdHash,
          dependencies: GetTaskByIdFamily._dependencies,
          allTransitiveDependencies:
              GetTaskByIdFamily._allTransitiveDependencies,
          id: id,
        );

  GetTaskByIdProvider._internal(
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
    FutureOr<TaskModel> Function(GetTaskByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTaskByIdProvider._internal(
        (ref) => create(ref as GetTaskByIdRef),
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
  AutoDisposeFutureProviderElement<TaskModel> createElement() {
    return _GetTaskByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTaskByIdProvider && other.id == id;
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
mixin GetTaskByIdRef on AutoDisposeFutureProviderRef<TaskModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GetTaskByIdProviderElement
    extends AutoDisposeFutureProviderElement<TaskModel> with GetTaskByIdRef {
  _GetTaskByIdProviderElement(super.provider);

  @override
  String get id => (origin as GetTaskByIdProvider).id;
}

String _$getTasksByProjectIdHash() =>
    r'9c690ba97b1ae4adb5925f61a8a164f5d914a9fb';

/// See also [getTasksByProjectId].
@ProviderFor(getTasksByProjectId)
const getTasksByProjectIdProvider = GetTasksByProjectIdFamily();

/// See also [getTasksByProjectId].
class GetTasksByProjectIdFamily extends Family<AsyncValue<List<TaskModel>>> {
  /// See also [getTasksByProjectId].
  const GetTasksByProjectIdFamily();

  /// See also [getTasksByProjectId].
  GetTasksByProjectIdProvider call(
    String projectId,
  ) {
    return GetTasksByProjectIdProvider(
      projectId,
    );
  }

  @override
  GetTasksByProjectIdProvider getProviderOverride(
    covariant GetTasksByProjectIdProvider provider,
  ) {
    return call(
      provider.projectId,
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
  String? get name => r'getTasksByProjectIdProvider';
}

/// See also [getTasksByProjectId].
class GetTasksByProjectIdProvider
    extends AutoDisposeFutureProvider<List<TaskModel>> {
  /// See also [getTasksByProjectId].
  GetTasksByProjectIdProvider(
    String projectId,
  ) : this._internal(
          (ref) => getTasksByProjectId(
            ref as GetTasksByProjectIdRef,
            projectId,
          ),
          from: getTasksByProjectIdProvider,
          name: r'getTasksByProjectIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTasksByProjectIdHash,
          dependencies: GetTasksByProjectIdFamily._dependencies,
          allTransitiveDependencies:
              GetTasksByProjectIdFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  GetTasksByProjectIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
  }) : super.internal();

  final String projectId;

  @override
  Override overrideWith(
    FutureOr<List<TaskModel>> Function(GetTasksByProjectIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTasksByProjectIdProvider._internal(
        (ref) => create(ref as GetTasksByProjectIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TaskModel>> createElement() {
    return _GetTasksByProjectIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTasksByProjectIdProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetTasksByProjectIdRef on AutoDisposeFutureProviderRef<List<TaskModel>> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _GetTasksByProjectIdProviderElement
    extends AutoDisposeFutureProviderElement<List<TaskModel>>
    with GetTasksByProjectIdRef {
  _GetTasksByProjectIdProviderElement(super.provider);

  @override
  String get projectId => (origin as GetTasksByProjectIdProvider).projectId;
}

String _$taskViewModelHash() => r'8af0722917deea92aaae2c62a0823f7947b6154d';

/// See also [TaskViewModel].
@ProviderFor(TaskViewModel)
final taskViewModelProvider =
    AutoDisposeNotifierProvider<TaskViewModel, AsyncValue?>.internal(
  TaskViewModel.new,
  name: r'taskViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
