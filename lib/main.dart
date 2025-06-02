import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/theme_notifier_provider.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:sis/features/notifications/service/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyABHz-f5DpHbYj7g9FN0ge7kcblWKzvgDg",
        authDomain: "sis-tm.firebaseapp.com",
        projectId: "sis-tm",
        storageBucket: "sis-tm.appspot.com",
        messagingSenderId: "993855769329",
        appId: "1:993855769329:web:381d7f693563786d3a3750",
        measurementId: "G-56NLKHJ4LK",
      ),
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final permission = await messaging.requestPermission();
    log('User granted permission: ${permission.authorizationStatus}');

    final fcmToken = await messaging.getToken(
      vapidKey:
          "BCNWbl0BmB9SblcDQq5vnUX9Wsjq3hdCQyuRn9Sk9WXzutFvaWwDLKU8jPDEbobGTlKRzY6AViN7UjWMQF-VUG8",
    );
    log('FCM Token: $fcmToken');
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).getData();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _routes = RouteName();
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    notificationService.requestNotificationPermission(context);
    notificationService.getDeviceToken();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    checkTokenOnAppStart();
    super.initState();
  }

  Future<void> checkTokenOnAppStart() async {
    String? token = await FirebaseMessaging.instance.getToken();
    final user = ref.watch(currentUserNotifierProvider);
    if (token != null && user != null) {
      await ref
          .read(authViewModelProvider.notifier)
          .updateDeviceToken(newDeviceToken: token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SIS',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeNotifierProvider).value,
      routerConfig: _routes.myrouter,
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: Builder(
          builder: (context) {
            return ResponsiveScaledBox(
              width: ResponsiveValue<double?>(
                context,
                defaultValue: null,
                conditionalValues: [
                  const Condition.equals(name: PHONE, value: 450),
                ],
              ).value,
              child: ClampingScrollWrapper.builder(context, widget!),
            );
          },
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: PHONE),
          const Breakpoint(start: 451, end: 750, name: MOBILE),
          const Breakpoint(start: 751, end: 1080, name: TABLET),
          const Breakpoint(start: 1081, end: double.infinity, name: DESKTOP),
        ],
      ),
    );
  }
}
