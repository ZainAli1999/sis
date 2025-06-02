// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';

class NotificationService with WidgetsBindingObserver {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AppLifecycleState? _appLifecycleState;

  NotificationService() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;
  }

  void requestNotificationPermission(BuildContext context) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User provisional granted permission');
    } else {
      showToast(
        content:
            'Notification Permission Denied, Please allow notifications for updates',
        context: context,
        toastType: ToastType.error,
      );
      Future.delayed(const Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  Future<String> getDeviceToken() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    String? token = await messaging.getToken();
    print('token: $token');
    return token!;
  }

  void initLocalNotification(
    BuildContext context,
    RemoteMessage message,
  ) async {
    var androidInitSetting =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSetting = InitializationSettings(
      android: androidInitSetting,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print('Notification title: ${notification!.title}');
        print('Notification body: ${notification.body}');
      }

      if (Platform.isAndroid && context.mounted) {
        initLocalNotification(context, message);
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.high,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: channel.sound,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: "my_data",
      );
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });

    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null && message.data.isNotEmpty) {
          handleMessage(context, message);
        }
      },
    );
  }

  Future<void> handleMessage(
    BuildContext context,
    RemoteMessage message,
  ) async {
    if (_appLifecycleState == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (GoRouter.maybeOf(context) != null) {
          Go.named(
            context,
            RouteName.notificationsPage,
          );
        }
      });
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
