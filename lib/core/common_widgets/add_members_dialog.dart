import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/auth/models/auth_model.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class AddMembersDialog extends ConsumerStatefulWidget {
  final List<String> selectMembers;
  final List<String>? employeesDeviceTokens;
  final Function pageState;
  const AddMembersDialog({
    super.key,
    required this.selectMembers,
    this.employeesDeviceTokens,
    required this.pageState,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddMembersDialogState();
}

class _AddMembersDialogState extends ConsumerState<AddMembersDialog> {
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
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
                    CustomTextField(
                      controller: _searchController,
                      hintText: "Search Members",
                      enabledBorderColor: context.colorScheme.surface,
                      focusedBorderColor: Palette.themecolor,
                      isOutlinedInputBorder: true,
                      outlineBorderRadius: 40,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 16,
                      ),
                      suffix: const Icon(
                        Icons.search,
                        size: 25,
                      ),
                      onChanged: (value) {
                        dialogState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                    10.kH,
                    ref.watch(fetchUsersProvider).when(
                          data: (users) {
                            final searchUsers = users.where((employee) {
                              bool matchesSearchQuery = [
                                "${employee.firstName} ${employee.lastName}",
                                employee.cid,
                              ].any((element) => element
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()));
                              return matchesSearchQuery;
                            }).toList();
                            return SliderView(
                              scrollDirection: Axis.vertical,
                              items: searchUsers.length,
                              padding: EdgeInsets.zero,
                              childBuilder: (context, index) {
                                final user = searchUsers[index];
                                final isSelected =
                                    widget.selectMembers.contains(user.uid);
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 8,
                                  titleAlignment: ListTileTitleAlignment.top,
                                  leading: user.profileImage.isEmpty
                                      ? _buildAvatar(isSelected)
                                      : _buildCachedImage(
                                          user.profileImage,
                                          isSelected,
                                        ),
                                  title: Text(
                                    "${user.firstName} ${user.lastName}",
                                    style: context.textTheme.bodySmall?.w600,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.cid,
                                        style: context.textTheme.labelLarge
                                            ?.themeGreyTextColor,
                                      ),
                                      Text(
                                        user.designation,
                                        style: context
                                            .textTheme.labelLarge?.themeColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _handleSelection(
                                      isSelected,
                                      user,
                                      dialogState,
                                      widget.pageState,
                                    );
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
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Go.pop(context);
                },
                child: Text(
                  "Done",
                  style: context.textTheme.bodyMedium?.themeWhiteColor.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(bool isSelected) {
    return isSelected
        ? _selectedAvatar()
        : Image.asset(
            Constants.defaultProfileImage,
            height: 50,
            width: 50,
          );
  }

  Widget _buildCachedImage(
    String imageUrl,
    bool isSelected,
  ) {
    return isSelected
        ? _selectedAvatar(imageUrl: imageUrl)
        : CustomCachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                radius: 25,
                backgroundImage: imageProvider,
              );
            },
            animChild: const CircleAvatar(
              radius: 25,
              backgroundColor: themegreycolor,
            ),
          );
  }

  Widget _selectedAvatar({
    String? imageUrl,
  }) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.secondary,
          width: 2.5,
        ),
        shape: BoxShape.circle,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                opacity: 0.5,
              )
            : const DecorationImage(
                image: AssetImage(Constants.defaultProfileImage),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
      ),
      child: Icon(
        Icons.check,
        color: context.colorScheme.secondary,
        size: 30,
      ),
    );
  }

  _handleSelection(
    bool isSelected,
    AuthModel user,
    Function dialogState,
    Function pageState,
  ) {
    pageState(() {
      if (isSelected) {
        widget.selectMembers.remove(user.uid);
        widget.employeesDeviceTokens
            ?.removeWhere((token) => user.deviceTokens.contains(token));
      } else {
        widget.selectMembers.add(user.uid);
        widget.employeesDeviceTokens?.addAll(user.deviceTokens);
      }
    });
    dialogState(() {
      if (isSelected) {
        widget.selectMembers.remove(user.uid);
        widget.employeesDeviceTokens
            ?.removeWhere((token) => user.deviceTokens.contains(token));
      } else {
        widget.selectMembers.add(user.uid);
        widget.employeesDeviceTokens?.addAll(user.deviceTokens);
      }
    });
  }
}
