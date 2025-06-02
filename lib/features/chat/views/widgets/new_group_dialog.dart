import 'dart:io';
import 'dart:typed_data';
import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
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

class NewGroupDialog extends ConsumerStatefulWidget {
  const NewGroupDialog({super.key});

  @override
  ConsumerState<NewGroupDialog> createState() => _NewGroupDialogState();
}

class _NewGroupDialogState extends ConsumerState<NewGroupDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';

  final List<String> _selectMembers = [];
  File? file;

  Uint8List? webFile;

  void selectImage() async {
    var res = await pickFile(FileType.image);
    if (res != null) {
      if (kIsWeb) {
        setState(() {
          webFile = res.files.first.bytes;
        });
      } else {
        setState(() {
          file = File(res.files.first.path!);
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
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
              content: 'Group Created Successfully!',
              context: context,
              toastType: ToastType.success,
            );
            Go.pop(context);
          },
          error: (error, st) {
            showToast(
              context: context,
              content: error.toString(),
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
              "New Group",
              style: context.textTheme.titleSmall?.bold,
            ),
            CustomIconButton(
              onTap: () {
                Go.pop(context);
              },
              child: Icon(
                Icons.cancel,
                color: context.colorScheme.secondary,
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
                Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      file != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(file!),
                            )
                          : webFile != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: MemoryImage(webFile!),
                                )
                              : CustomIconButton(
                                  onTap: selectImage,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        context.colorScheme.surface,
                                    child: const Icon(
                                      Icons.add,
                                      size: 40,
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
                10.kH,
                CustomTextField(
                  controller: _nameController,
                  hintText: "Enter Group Name",
                  enabledBorderColor: context.colorScheme.surface,
                  focusedBorderColor: Palette.themecolor,
                  isOutlinedInputBorder: true,
                  outlineBorderRadius: 12,
                  fillColor: context.colorScheme.surface,
                  filled: true,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
                10.kH,
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

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 8,
                              titleAlignment: ListTileTitleAlignment.top,
                              leading: isSelected
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
                                  : user.profileImage.isEmpty
                                      ? Image.asset(
                                          Constants.defaultProfileImage,
                                          height: 50,
                                          width: 50,
                                        )
                                      : CustomCachedNetworkImage(
                                          imageUrl: user.profileImage,
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return CircleAvatar(
                                              radius: 25,
                                              backgroundImage: imageProvider,
                                            );
                                          },
                                          animChild: CircleAvatar(
                                            backgroundColor:
                                                context.colorScheme.surface,
                                            radius: 25,
                                          ),
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
              if (_nameController.text.isNotEmpty &&
                  (file != null || webFile != null) &&
                  _selectMembers.isNotEmpty) {
                await ref.read(chatViewModelProvider.notifier).createGroup(
                      name: _nameController.text,
                      file: file,
                      selectedUser: _selectMembers,
                    );
              } else if (file == null || webFile != null) {
                showToast(
                  context: context,
                  content: 'Please Select Image',
                  toastType: ToastType.error,
                );
              } else if (_nameController.text.isEmpty) {
                showToast(
                  context: context,
                  content: 'Please Emter Group Name',
                  toastType: ToastType.error,
                );
              } else if (_selectMembers.isEmpty) {
                showToast(
                  context: context,
                  content: 'Please Select Members',
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
                    "Create",
                    style: context.textTheme.bodySmall?.themeWhiteColor.bold,
                  ),
          ),
        ],
      ),
    );
  }
}
