import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/theme/theme_notifier_provider.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/features/attendance/action/attendance_action.dart';
import 'package:sis/features/attendance/viewmodel/attendance_viewmodel.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final TextEditingController _lateReasonController = TextEditingController();

  @override
  void dispose() {
    _lateReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider)!;

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              content: 'Logged Out Successfully!',
              context: context,
              toastType: ToastType.success,
            );
            Go.namedReplace(
              context,
              RouteName.loginPage,
            );
          },
          error: (error, st) {
            showToast(
              content: error.toString(),
              context: context,
              toastType: ToastType.error,
            );
          },
          loading: () {},
        );
      },
    );

    final isLoading = ref.watch(
        attendanceViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      attendanceViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            if (data is CheckedIn) {
              showToast(
                content: 'Checked In Successfully!',
                context: context,
                toastType: ToastType.success,
              );
            } else if (data is CheckedOut) {
              showToast(
                content: 'Checked Out Successfully!',
                context: context,
                toastType: ToastType.success,
              );
            } else if (data is LateCheckInRequired) {
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, dialogState) {
                    return FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      child: AlertDialog(
                        backgroundColor: context.colorScheme.primary,
                        scrollable: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reason For Late Check-in",
                              style: context.textTheme.bodyMedium?.bold,
                            ),
                            CustomIconButton(
                              onTap: () {
                                Go.pop(context);
                              },
                              child: const Icon(
                                Icons.cancel,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        content: SizedBox(
                          width: context.screenWidth,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _lateReasonController,
                                validator: validateField,
                                hintText: "Late Reason",
                                maxLines: 4,
                                filled: true,
                                fillColor: context.colorScheme.surface,
                              ),
                              20.kH,
                              CustomButton(
                                height: 55,
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  ref
                                      .read(
                                          attendanceViewModelProvider.notifier)
                                      .checkIn(
                                        lateReason: _lateReasonController.text,
                                      );
                                  Go.pop(context);
                                },
                                child: Text(
                                  "Done",
                                  style: context.textTheme.bodyMedium
                                      ?.themeWhiteColor.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (data is AlreadyCheckedIn) {
              showToast(
                content: 'Already Checked In!',
                context: context,
                toastType: ToastType.info,
              );
            } else if (data is MarkedAbsent) {
              showToast(
                content: 'Absent Marked Successfully!',
                context: context,
                toastType: ToastType.success,
              );
            } else if (data is InvalidIP) {
              showToast(
                content: 'Access Denied: Invalid IP!',
                context: context,
                toastType: ToastType.error,
              );
            }
          },
          error: (error, st) {
            showToast(
              content: error.toString(),
              context: context,
              toastType: ToastType.error,
            );
          },
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          ref.watch(getAttendanceStatusByUidProvider).when(
                data: (status) {
                  return Column(
                    children: [
                      if (status != 1 && status != 2 && status != 3)
                        FadeInRight(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: CustomButton(
                              height: 40,
                              width: 120,
                              border: Border.all(
                                color: Palette.themecolor,
                              ),
                              buttoncolor: transparentcolor,
                              borderRadius: BorderRadius.circular(30),
                              onTap: () async {
                                await ref
                                    .read(attendanceViewModelProvider.notifier)
                                    .checkIn();
                              },
                              child: isLoading
                                  ? LoadingAnimationWidget.inkDrop(
                                      color: Palette.themecolor,
                                      size: 25,
                                    )
                                  : Text(
                                      "Check In",
                                      style: context.textTheme.labelLarge
                                          ?.themeColor.bold,
                                    ),
                            ),
                          ),
                        ),
                      if (status == 1)
                        ref.watch(getAttendanceIdByUidProvider).when(
                              data: (id) => FadeInRight(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                  ),
                                  child: CustomButton(
                                    height: 40,
                                    width: 120,
                                    border: Border.all(
                                      color: themeredcolor,
                                    ),
                                    buttoncolor: transparentcolor,
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () async {
                                      await ref
                                          .read(attendanceViewModelProvider
                                              .notifier)
                                          .checkOut(id: id!);
                                    },
                                    child: isLoading
                                        ? Center(
                                            child:
                                                LoadingAnimationWidget.inkDrop(
                                              color: themeredcolor,
                                              size: 25,
                                            ),
                                          )
                                        : Text(
                                            "Check Out",
                                            style: context.textTheme.labelLarge
                                                ?.themeRedColor.bold,
                                          ),
                                  ),
                                ),
                              ),
                              error: (error, st) {
                                return Text(
                                  error.toString(),
                                );
                              },
                              loading: () => LoadingAnimationWidget.inkDrop(
                                color: themeredcolor,
                                size: 25,
                              ),
                            ),
                      if (status == 2)
                        FadeInRight(
                          child: CustomButton(
                            height: 40,
                            width: 130,
                            buttoncolor: themeredcolor.withAlpha(25),
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              showToast(
                                content: 'You have checked-out already!',
                                context: context,
                                toastType: ToastType.info,
                              );
                            },
                            child: Text(
                              "Checked-Out",
                              style: context.textTheme.labelLarge
                                  ?.copyWith(color: themeredcolor)
                                  .bold,
                            ),
                          ),
                        ),
                      if (status == 3)
                        FadeInRight(
                          child: CustomButton(
                            height: 40,
                            width: 130,
                            buttoncolor: themeredcolor.withAlpha(25),
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              showToast(
                                content: 'You are Absent today!',
                                context: context,
                                toastType: ToastType.info,
                              );
                            },
                            child: Text(
                              "Absent",
                              style: context.textTheme.labelLarge
                                  ?.copyWith(color: themeredcolor)
                                  .bold,
                            ),
                          ),
                        ),
                    ],
                  );
                },
                loading: () => FadeInRight(
                  delay: const Duration(seconds: 3),
                  child: LoadingAnimationWidget.inkDrop(
                    color: Palette.themecolor,
                    size: 25,
                  ),
                ),
                error: (error, st) {
                  return Center(
                    child: Text(
                      error.toString(),
                    ),
                  );
                },
              ),
          15.kW,
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  user.profileImage.isEmpty
                      ? Image.asset(
                          Constants.defaultProfileImage,
                          height: 80,
                          width: 80,
                        )
                      : CustomCachedNetworkImage(
                          imageUrl: user.profileImage,
                          imageBuilder: (context, imageProvider) {
                            return CircleAvatar(
                              radius: 40,
                              backgroundImage: imageProvider,
                            );
                          },
                          animChild: CircleAvatar(
                            backgroundColor: context.colorScheme.surface,
                            radius: 40,
                          ),
                        ),
                  15.kW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.firstName} ${user.lastName}",
                        style: context.textTheme.titleMedium?.bold,
                      ),
                      Text(
                        user.designation.toUpperCase(),
                        style: context.textTheme.bodySmall?.themeColor.w500,
                      ),
                      8.kH,
                      Text(
                        user.phoneNumber,
                        style: context.textTheme.labelLarge?.themeGreyTextColor,
                      ),
                    ],
                  ),
                ],
              ),
              20.kH,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: List.generate(
                    profilemodel.length,
                    (index) => ListTile(
                      onTap: () async {
                        if (index == 0) {
                          Go.named(context, RouteName.editProfilePage);
                        } else if (index == 1) {
                          Go.named(context, RouteName.changePasswordPage);
                        } else if (index == 2) {
                          Go.named(context, RouteName.changeEmailPage);
                        } else if (index == 3) {
                          Go.named(context, RouteName.attendancePage);
                        } else if (index == 4) {
                          Go.named(context, RouteName.dailyReportOptionsPage);
                        } else if (index == 5) {
                          Go.named(context, RouteName.meetingsPage);
                        } else if (index == 6) {
                          Go.named(context, RouteName.leaveOptionsPage);
                        } else if (index == 8) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .logout();
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 20,
                      leading: CircleAvatar(
                        backgroundColor: Palette.themecolor.withAlpha(25),
                        child: profilemodel[index].icon,
                      ),
                      title: Text(
                        profilemodel[index].title,
                        style: context.textTheme.bodySmall?.bold,
                      ),
                      trailing: index == 7
                          ? Switch.adaptive(
                              activeColor: Palette.themecolor,
                              inactiveThumbColor: Palette.themecolor,
                              value: ref
                                      .watch(themeNotifierProvider.notifier)
                                      .mode ==
                                  ThemeMode.dark,
                              onChanged: (val) async {
                                await ref
                                    .read(themeNotifierProvider.notifier)
                                    .toggleTheme();
                              })
                          : const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                    ),
                  ),
                ),
              ),
              60.kH,
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileModel {
  final Icon icon;
  final String title;
  ProfileModel({required this.icon, required this.title});
}

List<ProfileModel> profilemodel = [
  ProfileModel(
    icon: const Icon(
      Icons.person_outline,
      color: Palette.themecolor,
    ),
    title: "Edit Profile",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.lock_outline,
      color: Palette.themecolor,
    ),
    title: "Change Password",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.email_outlined,
      color: Palette.themecolor,
    ),
    title: "Change Email",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.check_circle_outline,
      color: Palette.themecolor,
    ),
    title: "Attendance",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.report_outlined,
      color: Palette.themecolor,
    ),
    title: "Daily Report",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.meeting_room_outlined,
      color: Palette.themecolor,
    ),
    title: "Meeting",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.timelapse_outlined,
      color: Palette.themecolor,
    ),
    title: "Leave",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.dark_mode_outlined,
      color: Palette.themecolor,
    ),
    title: "Dark Theme",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.logout,
      color: Palette.themecolor,
    ),
    title: "Logout",
  ),
];
