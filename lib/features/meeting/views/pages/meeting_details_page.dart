import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/choose_image_dialog.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/custom_zoom_widget.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/common_widgets/outlined_box.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/pick_file.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/meeting/model/meeting_model.dart';
import 'package:sis/features/meeting/viewmodel/meeting_viewmodel.dart';

class MeetingDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const MeetingDetailsPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<MeetingDetailsPage> createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends ConsumerState<MeetingDetailsPage> {
  final _timeFormatter = DateFormat('hh:mm a');
  final _dateFormatter = DateFormat('MMMM dd, yyyy');

  File? goingReceipt;
  File? returnReceipt;

  Uint8List? goingReceiptWeb;
  Uint8List? returnReceiptWeb;

  void selectGoingReceipt(Function(void Function()) newState) async {
    var res = await pickFile(FileType.image);
    if (res != null) {
      if (kIsWeb) {
        newState(() {
          goingReceiptWeb = res.files.first.bytes;
        });
      } else {
        newState(() {
          goingReceipt = File(res.files.first.path!);
        });
      }
    }
  }

  void selectReturnReceipt(Function(void Function()) newState) async {
    var res = await pickFile(FileType.image);
    if (res != null) {
      if (kIsWeb) {
        newState(() {
          returnReceiptWeb = res.files.first.bytes;
        });
      } else {
        newState(() {
          returnReceipt = File(res.files.first.path!);
        });
      }
    }
  }

  bool _hasChanges() {
    return goingReceipt != null || returnReceipt != null;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        meetingViewModelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      meetingViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              content: 'Meeting Updated Successfully!',
              context: context,
              toastType: ToastType.success,
            );
            Go.pop(context);
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

    return ref.watch(getMeetingByIdProvider(widget.id)).when(
          data: (meeting) => Stack(
            children: [
              Scaffold(
                appBar: _buildPageHeader(meeting),
                body: _buildPageBody(meeting),
                // bottomNavigationBar: _buildPageFooter(meeting),
              ),
              if (isLoading) const LoadingProgress(),
            ],
          ),
          error: (error, st) {
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          },
          loading: () => const Scaffold(
            body: LoadingProgress(),
          ),
        );
  }

  PreferredSizeWidget _buildPageHeader(MeetingModel meeting) {
    return AppBar(
      title: const Text('Meeting Details'),
      actions: [
        FilledBox(
          height: 35,
          width: 110,
          innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
          color: Palette.themecolor.withAlpha(38),
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              _timeFormatter.format(meeting.time),
              style: context.textTheme.labelLarge
                  ?.copyWith(
                    color: Palette.themecolor,
                  )
                  .w600,
            ),
          ),
        ),
        15.kW,
      ],
    );
  }

  Widget _buildPageBody(MeetingModel meeting) {
    final user = ref.watch(currentUserNotifierProvider)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meeting.title,
                  style: context.textTheme.bodyMedium?.bold,
                ),
                6.kH,
                Text.rich(
                  TextSpan(
                    text: "Desc:  ",
                    style: context.textTheme.labelLarge?.themeGreyTextColor,
                    children: [
                      TextSpan(
                        text: meeting.desc,
                        style: context.textTheme.labelLarge?.themeGreyTextColor,
                      ),
                    ],
                  ),
                ),
                6.kH,
                Text.rich(
                  TextSpan(
                    text: "Date:  ",
                    style: context.textTheme.labelLarge?.themeGreyTextColor,
                    children: [
                      TextSpan(
                        text: _dateFormatter.format(meeting.date),
                        style: context.textTheme.labelLarge?.themeGreyTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Members',
              style: context.textTheme.bodyMedium?.bold,
            ),
          ),
          10.kH,
          SizedBox(
            height: 90,
            child: GridView.builder(
              itemCount: meeting.members.length,
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 110,
              ),
              itemBuilder: (context, index) {
                final meetingUser = meeting.members[index];
                return ref.watch(getUserByIdProvider(meetingUser)).when(
                      data: (employee) {
                        return Column(
                          children: [
                            employee.profileImage.isEmpty
                                ? Image.asset(
                                    Constants.defaultProfileImage,
                                    height: 60,
                                    width: 60,
                                  )
                                : CustomCachedNetworkImage(
                                    imageUrl: employee.profileImage,
                                    imageBuilder: (context, imageProvider) {
                                      return CircleAvatar(
                                        radius: 30,
                                        backgroundImage: imageProvider,
                                      );
                                    },
                                    animChild: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          context.colorScheme.surface,
                                    ),
                                  ),
                            5.kH,
                            Text(
                              "${employee.firstName} ${employee.lastName}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: context.textTheme.labelLarge?.w500,
                            ),
                          ],
                        );
                      },
                      error: (error, st) {
                        return Center(
                          child: Text(
                            error.toString(),
                          ),
                        );
                      },
                      loading: () => Shimmer.fromColors(
                        baseColor: context.colorScheme.surfaceDim,
                        highlightColor: context.colorScheme.shadow,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: context.colorScheme.surface,
                            ),
                            5.kH,
                            Container(
                              height: 15,
                              width: 100,
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
              },
            ),
          ),
          20.kH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Going Receipt',
                  style: context.textTheme.bodyMedium?.bold,
                ),
                if (meeting.uid == user.uid)
                  CustomButton(
                    height: 35,
                    width: 100,
                    buttoncolor: Palette.themecolor,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      chooseImageDialog(
                        context: context,
                        title: 'Upload Going Receipt',
                        button1Color: Palette.themecolor,
                        content: StatefulBuilder(
                          builder: (context, newState) {
                            return goingReceipt != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      goingReceipt!,
                                      height: 200,
                                      width: context.screenWidth,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : goingReceiptWeb != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.memory(
                                          goingReceiptWeb!,
                                          height: 200,
                                          width: context.screenWidth,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : OutlinedBox(
                                        height: 200,
                                        width: context.screenWidth,
                                        onTap: () {
                                          selectGoingReceipt(newState);
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: context.colorScheme.secondary,
                                          size: 40,
                                        ),
                                      );
                          },
                        ),
                        button1Child: Text(
                          "Upload",
                          style:
                              context.textTheme.bodySmall?.themeWhiteColor.bold,
                        ),
                        onTapButton1: () async {
                          Go.pop(context);
                          if (_hasChanges()) {
                            await ref
                                .read(meetingViewModelProvider.notifier)
                                .updateMeetingDetails(
                                  id: meeting.id,
                                  goingReceipt: goingReceipt,
                                  goingReceiptWeb: goingReceiptWeb,
                                );
                          } else {
                            showToast(
                              content: "No changes to update",
                              context: context,
                              toastType: ToastType.error,
                            );
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                    child: Text(
                      "Add",
                      style: context.textTheme.labelLarge?.themeWhiteColor.bold,
                    ),
                  ),
              ],
            ),
          ),
          5.kH,
          Row(
            children: [
              meeting.goingReceipt != null
                  ? FilledBox(
                      outerBoxPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      innerBoxPadding: const EdgeInsets.all(12),
                      child: IntrinsicWidth(
                        child: Text(
                          meeting.goingReceipt!.split('/').last,
                          style: context.textTheme.labelLarge,
                        ),
                      ),
                      onTap: () {
                        Go.route(
                          context,
                          WidgetZoom(
                            heroAnimationTag: meeting.goingReceipt!,
                            zoomWidget: CustomCachedNetworkImage(
                              imageUrl: meeting.goingReceipt!,
                              imageBuilder: (context, imageProvider) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image(
                                    image: imageProvider,
                                    height: 100,
                                    width: 100,
                                  ),
                                );
                              },
                              animChild: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: context.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "No Going Receipt Found",
                        style: context.textTheme.bodySmall,
                      ),
                    ),
            ],
          ),
          15.kH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Return Receipt',
                  style: context.textTheme.bodyMedium?.bold,
                ),
                if (meeting.uid == user.uid)
                  CustomButton(
                    height: 35,
                    width: 100,
                    buttoncolor: Palette.themecolor,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      chooseImageDialog(
                        context: context,
                        title: 'Upload Return Receipt',
                        button1Color: Palette.themecolor,
                        content: StatefulBuilder(
                          builder: (context, newState) {
                            return returnReceipt != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      returnReceipt!,
                                      height: 200,
                                      width: context.screenWidth,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : OutlinedBox(
                                    height: 200,
                                    width: context.screenWidth,
                                    onTap: () {
                                      selectReturnReceipt(newState);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: context.colorScheme.secondary,
                                      size: 40,
                                    ),
                                  );
                          },
                        ),
                        button1Child: Text(
                          "Upload",
                          style:
                              context.textTheme.bodySmall?.themeWhiteColor.bold,
                        ),
                        onTapButton1: () async {
                          Go.pop(context);
                          if (_hasChanges()) {
                            await ref
                                .read(meetingViewModelProvider.notifier)
                                .updateMeetingDetails(
                                  id: meeting.id,
                                  returnReceipt: returnReceipt,
                                );
                          } else {
                            showToast(
                              content: "No changes to update",
                              context: context,
                              toastType: ToastType.error,
                            );
                            Go.pop(context);
                          }
                        },
                      );
                    },
                    child: Text(
                      "Add",
                      style: context.textTheme.labelLarge?.themeWhiteColor.bold,
                    ),
                  ),
              ],
            ),
          ),
          5.kH,
          Row(
            children: [
              meeting.returnReceipt != null
                  ? FilledBox(
                      outerBoxPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      innerBoxPadding: const EdgeInsets.all(12),
                      child: IntrinsicWidth(
                        child: Text(
                          meeting.returnReceipt!.split('/').last,
                          style: context.textTheme.labelLarge,
                        ),
                      ),
                      onTap: () {
                        Go.route(
                          context,
                          WidgetZoom(
                            heroAnimationTag: meeting.returnReceipt!,
                            zoomWidget: CustomCachedNetworkImage(
                              imageUrl: meeting.returnReceipt!,
                              imageBuilder: (context, imageProvider) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image(
                                    image: imageProvider,
                                    height: 100,
                                    width: 100,
                                  ),
                                );
                              },
                              animChild: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: context.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "No Return Receipt Found",
                        style: context.textTheme.bodySmall,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildPageFooter(MeetingModel meeting) {
  //   final isLoading = ref.watch(
  //       meetingViewModelProvider.select((val) => val?.isLoading == true));
  //   return Padding(
  //     padding: const EdgeInsets.all(15.0),
  //     child: CustomButton(
  //       height: 55,
  //       borderRadius: BorderRadius.circular(12),
  //       buttoncolor: _hasChanges() ? Palette.themecolor : themegreycolor,
  //       onTap: () async {
  //         if (_hasChanges()) {
  //           await ref
  //               .read(meetingViewModelProvider.notifier)
  //               .updateMeetingDetails(
  //                 id: meeting.id,
  //                 goingReceipt: goingReceipt,
  //                 returnReceipt: returnReceipt,
  //               );
  //         } else {
  //           showSnackBar(context, "No changes to update");
  //         }
  //       },
  //       child: isLoading
  //           ? const Center(
  //               child: CircularProgressIndicator(
  //                 color: themewhitecolor,
  //               ),
  //             )
  //           : Text(
  //               "Save Changes",
  //               style: _hasChanges()
  //                   ? context.textTheme.bodyMedium?.themeWhiteColor.bold
  //                   : context.textTheme.bodyMedium?.themeGreyTextColor.bold,
  //             ),
  //     ),
  //   );
  // }
}
