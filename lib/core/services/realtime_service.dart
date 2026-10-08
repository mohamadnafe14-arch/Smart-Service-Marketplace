import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:smart_service_market_place/core/secrets/pusher_secrets.dart';
import 'package:smart_service_market_place/features/chat/model/services/chat_channel_authorizer.dart';

typedef RealtimeEventHandler = void Function(PusherEvent event);
typedef RealtimeErrorHandler = void Function(String message);

@lazySingleton
class RealtimeService {
  RealtimeService(this._channelAuthorizer);

  final ChatChannelAuthorizer _channelAuthorizer;
  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();
  final Map<String, Set<RealtimeEventHandler>> _handlers = {};
  final Set<RealtimeErrorHandler> _errorHandlers = {};
  Future<void>? _connection;
  String? _token;

  Future<void> subscribe({
    required String channelName,
    required String token,
    required RealtimeEventHandler onEvent,
    required RealtimeErrorHandler onError,
  }) async {
    _token = token;
    _errorHandlers.add(onError);
    final handlers = _handlers.putIfAbsent(channelName, () => {});
    if (!handlers.add(onEvent)) return;
    try {
      await _ensureConnected();
      if (handlers.length == 1) {
        await _pusher.subscribe(channelName: channelName);
      }
    } catch (_) {
      handlers.remove(onEvent);
      if (handlers.isEmpty) _handlers.remove(channelName);
      if (_handlers.isEmpty) _errorHandlers.remove(onError);
      if (_handlers.isEmpty) await _disconnectIfIdle();
      rethrow;
    }
  }

  Future<void> unsubscribe({
    required String channelName,
    required RealtimeEventHandler onEvent,
    required RealtimeErrorHandler onError,
  }) async {
    _errorHandlers.remove(onError);
    final handlers = _handlers[channelName];
    if (handlers == null) return;
    handlers.remove(onEvent);
    if (handlers.isEmpty) {
      _handlers.remove(channelName);
      await _pusher.unsubscribe(channelName: channelName);
    }
    if (_handlers.isEmpty) await _disconnectIfIdle();
  }

  Future<void> _ensureConnected() async {
    final activeConnection = _connection;
    if (activeConnection != null) {
      await activeConnection;
      return;
    }
    final connection = _initialize();
    _connection = connection;
    try {
      await connection;
    } catch (_) {
      if (identical(_connection, connection)) _connection = null;
      rethrow;
    }
  }

  Future<void> _initialize() async {
    await _pusher.init(
      apiKey: pusherApiKey,
      cluster: pusherCluster,
      onAuthorizer: (channelName, socketId, _) => _channelAuthorizer.authorize(
        token: _token!,
        channelName: channelName,
        socketId: socketId,
      ),
      onEvent: (event) {
        for (final handler in List<RealtimeEventHandler>.from(
          _handlers[event.channelName] ?? const {},
        )) {
          handler(event);
        }
      },
      onError: (message, code, error) => _reportError(message),
      onSubscriptionError: (message, error) => _reportError(message),
    );
    await _pusher.connect();
  }

  void _reportError(String message) {
    for (final handler in List<RealtimeErrorHandler>.from(_errorHandlers)) {
      handler(message);
    }
  }

  Future<void> _disconnectIfIdle() async {
    _connection = null;
    _token = null;
    await _pusher.disconnect();
  }
}
