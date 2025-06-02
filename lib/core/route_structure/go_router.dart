import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sis/core/nav_bar/nav_bar.dart';
import 'package:sis/core/onboarding/onboarding_page.dart';
import 'package:sis/core/common_widgets/error_screen.dart';
import 'package:sis/core/splash/splash_page.dart';
import 'package:sis/features/attendance/views/pages/attendance_page.dart';
import 'package:sis/features/auth/views/pages/change_email_page.dart';
import 'package:sis/features/auth/views/pages/change_password_page.dart';
import 'package:sis/features/auth/views/pages/forgot_password_page.dart';
import 'package:sis/features/auth/views/pages/login_page.dart';
import 'package:sis/features/chat/views/pages/group_profile_page.dart';
import 'package:sis/features/chat/views/pages/message_page.dart';
import 'package:sis/features/dailyreports/views/pages/add_daily_report_page.dart';
import 'package:sis/features/dailyreports/views/pages/daily_report_details_page.dart';
import 'package:sis/features/dailyreports/views/pages/daily_report_options_page.dart';
import 'package:sis/features/dailyreports/views/pages/daily_reports_page.dart';
import 'package:sis/features/projects/views/pages/project_details_page.dart';
import 'package:sis/features/leave/views/pages/add_leave_page.dart';
import 'package:sis/features/leave/views/pages/leave_options_page.dart';
import 'package:sis/features/leave/views/pages/leaves_page.dart';
import 'package:sis/features/meeting/views/pages/add_meeting_page.dart';
import 'package:sis/features/meeting/views/pages/meeting_details_page.dart';
import 'package:sis/features/meeting/views/pages/meetings_page.dart';
import 'package:sis/features/profile/views/pages/edit_profile_page.dart';
import 'package:sis/features/tasks/views/pages/add_task_page.dart';
import 'package:sis/features/tasks/views/pages/edit_task_page.dart';
import 'package:sis/features/tasks/views/pages/task_details_page.dart';

class RouteName {
  static const String splashPage = 'splash';
  static const String onboardingPage = 'onboarding';
  static const String loginPage = 'login';
  static const String signupPage = 'sign-up';
  static const String attendancePage = 'attendance';
  static const String homePage = 'home';
  static const String addMeetingPage = 'add-meeting';
  static const String meetingsPage = 'meetings';
  static const String meetingDetailsPage = 'meeting-details';
  static const String addLeavePage = 'add-leave';
  static const String leaveOptionsPage = 'leave-options';
  static const String leavesPage = 'leaves';
  static const String addDailyReportPage = 'add-daily-report';
  static const String dailyReportOptionsPage = 'daily-report-options';
  static const String dailyReportsPage = 'daily-reports';
  static const String dailyReportDetailsPage = 'daily-report-details';
  static const String notificationsPage = 'notifications';
  static const String profilePage = 'profile';
  static const String navbar = 'navbar';
  static const String editProfilePage = 'edit-profile';
  static const String changePasswordPage = 'change-password';
  static const String forgotPasswordPage = 'forgot-password';
  static const String changeEmailPage = 'change-email';
  static const String projectDetailsPage = 'project-details';
  static const String projectsPage = 'projects';
  static const String addProjectPage = 'add-project';
  static const String tasksPage = 'tasks';
  static const String taskDetailsPage = 'task-details';
  static const String addTaskPage = 'add-task';
  static const String editTaskPage = 'edit-task';
  static const String chatPage = 'chat';
  static const String groupProfilePage = 'group-profile';
  static const String messagePage = 'message';
  static const String editMessagePage = 'edit-message';

  GoRouter myrouter = GoRouter(
    errorPageBuilder: (context, state) {
      return const MaterialPage(
        child: ErrorScreen(),
      );
    },
    routes: [
      GoRoute(
        path: '/',
        name: splashPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SplashPage(),
          );
        },
      ),
      GoRoute(
        path: '/$onboardingPage',
        name: onboardingPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OnboardingPage(),
          );
        },
      ),
      GoRoute(
        path: '/$loginPage',
        name: loginPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginPage(),
          );
        },
      ),
      GoRoute(
        path: '/$homePage',
        name: homePage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: NavBar(
              currentIndex: 0,
            ),
          );
        },
      ),
      GoRoute(
        path: '/$projectsPage',
        name: projectsPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: NavBar(
              currentIndex: 1,
            ),
          );
        },
      ),
      GoRoute(
        path: '/$tasksPage',
        name: tasksPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: NavBar(
              currentIndex: 2,
            ),
          );
        },
      ),
      GoRoute(
        path: '/$chatPage',
        name: chatPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: NavBar(
              currentIndex: 3,
            ),
          );
        },
      ),
      GoRoute(
        path: '/$profilePage',
        name: profilePage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: NavBar(
              currentIndex: 4,
            ),
          );
        },
      ),
      GoRoute(
        path: '/$projectDetailsPage/:id',
        name: projectDetailsPage,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ProjectDetailsPage(
              id: state.pathParameters['id'] ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: '/$taskDetailsPage/:id',
        name: taskDetailsPage,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: TaskDetailsPage(
              id: state.pathParameters['id'] ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: '/$addTaskPage',
        name: addTaskPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AddTaskPage(),
          );
        },
      ),
      GoRoute(
        path: '/$editTaskPage/:id',
        name: editTaskPage,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: EditTaskPage(
              id: state.pathParameters['id'] ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: '/$editProfilePage',
        name: editProfilePage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: EditProfilePage(),
          );
        },
      ),
      GoRoute(
        path: '/$changePasswordPage',
        name: changePasswordPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ChangePasswordPage(),
          );
        },
      ),
      GoRoute(
        path: '/$forgotPasswordPage',
        name: forgotPasswordPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ForgotPasswordPage(),
          );
        },
      ),
      GoRoute(
        path: '/$changeEmailPage',
        name: changeEmailPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ChangeEmailPage(),
          );
        },
      ),
      GoRoute(
        path: '/$attendancePage',
        name: attendancePage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AttendancePage(),
          );
        },
      ),
      GoRoute(
        path: '/$addMeetingPage',
        name: addMeetingPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AddMeetingPage(),
          );
        },
      ),
      GoRoute(
        path: '/$meetingsPage',
        name: meetingsPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: MeetingsPage(),
          );
        },
      ),
      GoRoute(
        path: '/$meetingDetailsPage/:id',
        name: meetingDetailsPage,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: MeetingDetailsPage(
              id: state.pathParameters['id'] ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: '/$leaveOptionsPage',
        name: leaveOptionsPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LeaveOptionsPage(),
          );
        },
      ),
      GoRoute(
        path: '/$addLeavePage',
        name: addLeavePage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AddLeavePage(),
          );
        },
      ),
      GoRoute(
        path: '/$leavesPage',
        name: leavesPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LeavesPage(),
          );
        },
      ),
      GoRoute(
        path: '/$addDailyReportPage',
        name: addDailyReportPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AddDailyReportPage(),
          );
        },
      ),
      GoRoute(
        path: '/$dailyReportOptionsPage',
        name: dailyReportOptionsPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: DailyReportOptionsPage(),
          );
        },
      ),
      GoRoute(
        path: '/$dailyReportsPage',
        name: dailyReportsPage,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: DailyReportsPage(),
          );
        },
      ),
      GoRoute(
        path: '/$dailyReportDetailsPage/:id',
        name: dailyReportDetailsPage,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: DailyReportDetailsPage(
              id: state.pathParameters['id'] ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: '/$messagePage/:uid/:name/:isGroupChat/:profilePic',
        name: messagePage,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: MessagePage(
              uid: state.pathParameters['uid'] ?? "",
              name: state.pathParameters['name'] ?? "",
              isGroupChat: state.pathParameters['isGroupChat'] == 'true',
              profilePic: state.pathParameters['profilePic'] ?? "",
            ),
          );
        },
      ),
      GoRoute(
        path: '/$groupProfilePage/:id',
        name: groupProfilePage,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: GroupProfilePage(
              id: state.pathParameters['id'] ?? "",
            ),
          );
        },
      ),
    ],
  );
}
