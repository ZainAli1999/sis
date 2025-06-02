import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class UsersDialog extends ConsumerStatefulWidget {
  const UsersDialog({super.key});

  @override
  ConsumerState<UsersDialog> createState() => _UsersDialogState();
}

class _UsersDialogState extends ConsumerState<UsersDialog> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: AlertDialog(
        backgroundColor: context.colorScheme.primary,
        scrollable: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Chat",
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
            10.kH,
            CustomTextField(
              controller: _searchController,
              hintText: "Search",
              enabledBorderColor: context.colorScheme.surface,
              focusedBorderColor: Palette.themecolor,
              isOutlinedInputBorder: true,
              outlineBorderRadius: 40,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 16,
              ),
              prefix: const Icon(
                Icons.search,
                size: 25,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
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
                        final filteredUsers = users.where((user) {
                          bool matchesSearchQuery = [
                            "${user.firstName} ${user.lastName}",
                          ].any(
                            (element) => element
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()),
                          );
                          return matchesSearchQuery;
                        }).toList();

                        return SliderView(
                          scrollDirection: Axis.vertical,
                          items: filteredUsers.length,
                          padding: EdgeInsets.zero,
                          childBuilder: (context, index) {
                            final user = filteredUsers[index];

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 8,
                              titleAlignment: ListTileTitleAlignment.top,
                              leading: user.profileImage.isEmpty
                                  ? Image.asset(
                                      Constants.defaultProfileImage,
                                      height: 50,
                                      width: 50,
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: user.profileImage,
                                      imageBuilder: (context, imageProvider) {
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
                                Go.pop(context);
                                Go.named(
                                  context,
                                  RouteName.messagePage,
                                  params: {
                                    "uid": user.uid,
                                    "isGroupChat": "false",
                                    "name":
                                        "${user.firstName} ${user.lastName}",
                                    "profilePic": "profilePic",
                                  },
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
      ),
    );
  }
}
