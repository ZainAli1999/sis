// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupByIdHash() => r'320a8b04c8351c820645920937fad570b67fd189';

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

/// See also [groupById].
@ProviderFor(groupById)
const groupByIdProvider = GroupByIdFamily();

/// See also [groupById].
class GroupByIdFamily extends Family<AsyncValue<GroupModel>> {
  /// See also [groupById].
  const GroupByIdFamily();

  /// See also [groupById].
  GroupByIdProvider call(
    String id,
  ) {
    return GroupByIdProvider(
      id,
    );
  }

  @override
  GroupByIdProvider getProviderOverride(
    covariant GroupByIdProvider provider,
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
  String? get name => r'groupByIdProvider';
}

/// See also [groupById].
class GroupByIdProvider extends AutoDisposeStreamProvider<GroupModel> {
  /// See also [groupById].
  GroupByIdProvider(
    String id,
  ) : this._internal(
          (ref) => groupById(
            ref as GroupByIdRef,
            id,
          ),
          from: groupByIdProvider,
          name: r'groupByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupByIdHash,
          dependencies: GroupByIdFamily._dependencies,
          allTransitiveDependencies: GroupByIdFamily._allTransitiveDependencies,
          id: id,
        );

  GroupByIdProvider._internal(
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
    Stream<GroupModel> Function(GroupByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupByIdProvider._internal(
        (ref) => create(ref as GroupByIdRef),
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
  AutoDisposeStreamProviderElement<GroupModel> createElement() {
    return _GroupByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupByIdProvider && other.id == id;
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
mixin GroupByIdRef on AutoDisposeStreamProviderRef<GroupModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GroupByIdProviderElement
    extends AutoDisposeStreamProviderElement<GroupModel> with GroupByIdRef {
  _GroupByIdProviderElement(super.provider);

  @override
  String get id => (origin as GroupByIdProvider).id;
}

String _$unseenMessagesCountHash() =>
    r'f094f72d5ad7f1e429ee8be8a5946f0ccbbe2184';

/// See also [unseenMessagesCount].
@ProviderFor(unseenMessagesCount)
const unseenMessagesCountProvider = UnseenMessagesCountFamily();

/// See also [unseenMessagesCount].
class UnseenMessagesCountFamily extends Family<AsyncValue<int>> {
  /// See also [unseenMessagesCount].
  const UnseenMessagesCountFamily();

  /// See also [unseenMessagesCount].
  UnseenMessagesCountProvider call(
    String senderId,
    String receiverId,
  ) {
    return UnseenMessagesCountProvider(
      senderId,
      receiverId,
    );
  }

  @override
  UnseenMessagesCountProvider getProviderOverride(
    covariant UnseenMessagesCountProvider provider,
  ) {
    return call(
      provider.senderId,
      provider.receiverId,
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
  String? get name => r'unseenMessagesCountProvider';
}

/// See also [unseenMessagesCount].
class UnseenMessagesCountProvider extends AutoDisposeStreamProvider<int> {
  /// See also [unseenMessagesCount].
  UnseenMessagesCountProvider(
    String senderId,
    String receiverId,
  ) : this._internal(
          (ref) => unseenMessagesCount(
            ref as UnseenMessagesCountRef,
            senderId,
            receiverId,
          ),
          from: unseenMessagesCountProvider,
          name: r'unseenMessagesCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unseenMessagesCountHash,
          dependencies: UnseenMessagesCountFamily._dependencies,
          allTransitiveDependencies:
              UnseenMessagesCountFamily._allTransitiveDependencies,
          senderId: senderId,
          receiverId: receiverId,
        );

  UnseenMessagesCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.senderId,
    required this.receiverId,
  }) : super.internal();

  final String senderId;
  final String receiverId;

  @override
  Override overrideWith(
    Stream<int> Function(UnseenMessagesCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnseenMessagesCountProvider._internal(
        (ref) => create(ref as UnseenMessagesCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        senderId: senderId,
        receiverId: receiverId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<int> createElement() {
    return _UnseenMessagesCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnseenMessagesCountProvider &&
        other.senderId == senderId &&
        other.receiverId == receiverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderId.hashCode);
    hash = _SystemHash.combine(hash, receiverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UnseenMessagesCountRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `senderId` of this provider.
  String get senderId;

  /// The parameter `receiverId` of this provider.
  String get receiverId;
}

class _UnseenMessagesCountProviderElement
    extends AutoDisposeStreamProviderElement<int> with UnseenMessagesCountRef {
  _UnseenMessagesCountProviderElement(super.provider);

  @override
  String get senderId => (origin as UnseenMessagesCountProvider).senderId;
  @override
  String get receiverId => (origin as UnseenMessagesCountProvider).receiverId;
}

String _$chatGroupsHash() => r'0e63aa6f6b56d401ae9f62b06b47f253d1d1ed33';

/// See also [chatGroups].
@ProviderFor(chatGroups)
final chatGroupsProvider = AutoDisposeStreamProvider<List<GroupModel>>.internal(
  chatGroups,
  name: r'chatGroupsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatGroupsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatGroupsRef = AutoDisposeStreamProviderRef<List<GroupModel>>;
String _$chatContactsHash() => r'130fd4846d326237b578ad446ead70f52442240c';

/// See also [chatContacts].
@ProviderFor(chatContacts)
final chatContactsProvider =
    AutoDisposeStreamProvider<List<ChatContactModel>>.internal(
  chatContacts,
  name: r'chatContactsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatContactsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatContactsRef = AutoDisposeStreamProviderRef<List<ChatContactModel>>;
String _$chatStreamHash() => r'de17a0fedee26d75f210577b3f2aa12fb88f928c';

/// See also [chatStream].
@ProviderFor(chatStream)
const chatStreamProvider = ChatStreamFamily();

/// See also [chatStream].
class ChatStreamFamily extends Family<AsyncValue<List<MessageModel>>> {
  /// See also [chatStream].
  const ChatStreamFamily();

  /// See also [chatStream].
  ChatStreamProvider call(
    String contactId,
  ) {
    return ChatStreamProvider(
      contactId,
    );
  }

  @override
  ChatStreamProvider getProviderOverride(
    covariant ChatStreamProvider provider,
  ) {
    return call(
      provider.contactId,
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
  String? get name => r'chatStreamProvider';
}

/// See also [chatStream].
class ChatStreamProvider extends AutoDisposeStreamProvider<List<MessageModel>> {
  /// See also [chatStream].
  ChatStreamProvider(
    String contactId,
  ) : this._internal(
          (ref) => chatStream(
            ref as ChatStreamRef,
            contactId,
          ),
          from: chatStreamProvider,
          name: r'chatStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatStreamHash,
          dependencies: ChatStreamFamily._dependencies,
          allTransitiveDependencies:
              ChatStreamFamily._allTransitiveDependencies,
          contactId: contactId,
        );

  ChatStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contactId,
  }) : super.internal();

  final String contactId;

  @override
  Override overrideWith(
    Stream<List<MessageModel>> Function(ChatStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatStreamProvider._internal(
        (ref) => create(ref as ChatStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contactId: contactId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<MessageModel>> createElement() {
    return _ChatStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatStreamProvider && other.contactId == contactId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contactId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatStreamRef on AutoDisposeStreamProviderRef<List<MessageModel>> {
  /// The parameter `contactId` of this provider.
  String get contactId;
}

class _ChatStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<MessageModel>>
    with ChatStreamRef {
  _ChatStreamProviderElement(super.provider);

  @override
  String get contactId => (origin as ChatStreamProvider).contactId;
}

String _$groupChatStreamHash() => r'e94d4092847acfed57292b3677886fbf4017bb16';

/// See also [groupChatStream].
@ProviderFor(groupChatStream)
const groupChatStreamProvider = GroupChatStreamFamily();

/// See also [groupChatStream].
class GroupChatStreamFamily extends Family<AsyncValue<List<MessageModel>>> {
  /// See also [groupChatStream].
  const GroupChatStreamFamily();

  /// See also [groupChatStream].
  GroupChatStreamProvider call(
    String groupId,
  ) {
    return GroupChatStreamProvider(
      groupId,
    );
  }

  @override
  GroupChatStreamProvider getProviderOverride(
    covariant GroupChatStreamProvider provider,
  ) {
    return call(
      provider.groupId,
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
  String? get name => r'groupChatStreamProvider';
}

/// See also [groupChatStream].
class GroupChatStreamProvider
    extends AutoDisposeStreamProvider<List<MessageModel>> {
  /// See also [groupChatStream].
  GroupChatStreamProvider(
    String groupId,
  ) : this._internal(
          (ref) => groupChatStream(
            ref as GroupChatStreamRef,
            groupId,
          ),
          from: groupChatStreamProvider,
          name: r'groupChatStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupChatStreamHash,
          dependencies: GroupChatStreamFamily._dependencies,
          allTransitiveDependencies:
              GroupChatStreamFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  GroupChatStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    Stream<List<MessageModel>> Function(GroupChatStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupChatStreamProvider._internal(
        (ref) => create(ref as GroupChatStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<MessageModel>> createElement() {
    return _GroupChatStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupChatStreamProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupChatStreamRef on AutoDisposeStreamProviderRef<List<MessageModel>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupChatStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<MessageModel>>
    with GroupChatStreamRef {
  _GroupChatStreamProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupChatStreamProvider).groupId;
}

String _$chatViewModelHash() => r'f97b9dbf1430d7812e4d72df347431a6b4f2862a';

/// See also [ChatViewModel].
@ProviderFor(ChatViewModel)
final chatViewModelProvider =
    AutoDisposeNotifierProvider<ChatViewModel, AsyncValue?>.internal(
  ChatViewModel.new,
  name: r'chatViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
