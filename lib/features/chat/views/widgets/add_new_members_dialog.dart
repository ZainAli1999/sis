import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/pick_file.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/chat/viewmodel/chat_viewmodel.dart';

class AddNewMembersDialog extends ConsumerStatefulWidget {
  final String groupId;
  final List<String> membersUid;
  const AddNewMembersDialog({
    super.key,
    required this.groupId,
    required this.membersUid,
  });

  @override
  ConsumerState<AddNewMembersDialog> createState() =>
      _AddNewMembersDialogState();
}

class _AddNewMembersDialogState extends ConsumerState<AddNewMembersDialog> {
  final List<String> _selectMembers = [];

  File? image;

  void selectImage() async {
    var res = await pickFile(FileType.image);
    if (res != null) {
      setState(() {
        image = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(chatViewModelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      chatViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              content: 'Member Added Successfully!',
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
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: AlertDialog(
        backgroundColor: context.colorScheme.primary,
        scrollable: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add Members",
              style: context.textTheme.titleSmall?.bold,
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
          height: context.screenHeight / 100 * 50,
          width: context.screenWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ref.watch(fetchUsersProvider).when(
                      data: (users) {
                        return SliderView(
                          scrollDirection: Axis.vertical,
                          items: users.length,
                          padding: EdgeInsets.zero,
                          childBuilder: (context, index) {
                            final user = users[index];
                            final isSelected =
                                _selectMembers.contains(user.uid);

                            final currentMembers =
                                widget.membersUid.contains(user.uid);

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 8,
                              titleAlignment: ListTileTitleAlignment.top,
                              leading: (currentMembers || isSelected)
                                  ? Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: context.colorScheme.secondary,
                                          width: 2.5,
                                        ),
                                        shape: BoxShape.circle,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            Constants.defaultProfileImage,
                                          ),
                                          fit: BoxFit.cover,
                                          opacity: 0.5,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: context.colorScheme.secondary,
                                        size: 30,
                                      ),
                                    )
                                  : Image.asset(
                                      Constants.defaultProfileImage,
                                      height: 50,
                                      width: 50,
                                    ),
                              title: Text(
                                "${user.firstName} ${user.lastName}",
                                style: context.textTheme.bodySmall?.w600,
                              ),
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    _selectMembers.remove(user.uid);
                                  } else {
                                    _selectMembers.add(user.uid);
                                  }
                                });
                              },
                            );
                          },
                        );
                      },
                      error: (error, st) => Center(
                        child: Text(
                          error.toString(),
                        ),
                      ),
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
                    ),
              ],
            ),
          ),
        ),
        actions: [
          CustomButton(
            height: 50,
            buttoncolor: Palette.themecolor,
            borderRadius: BorderRadius.circular(30),
            onTap: () async {
              if (_selectMembers.isNotEmpty) {
                await ref.read(chatViewModelProvider.notifier).addMembers(
                      id: widget.groupId,
                      addMemberUid: _selectMembers,
                    );
              } else if (_selectMembers.isEmpty) {
                showToast(
                  content: 'Please Select Members',
                  context: context,
                  toastType: ToastType.error,
                );
              }
            },
            child: isLoading
                ? Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: themewhitecolor,
                      size: 30,
                    ),
                  )
                : Text(
                    "Add",
                    style: context.textTheme.bodySmall?.themeWhiteColor.bold,
                  ),
          ),
        ],
      ),
    );
  }
}
