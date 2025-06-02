import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/meeting/model/meeting_model.dart';

class MeetingCard extends ConsumerStatefulWidget {
  final MeetingModel meeting;
  const MeetingCard({
    super.key,
    required this.meeting,
  });

  @override
  ConsumerState<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends ConsumerState<MeetingCard> {
  final _timeFormatter = DateFormat('hh:mm a');
  final _dateFormatter = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    return FilledBox(
      width: context.screenWidth,
      color: context.colorScheme.primary,
      onTap: () {
        Go.named(
          context,
          RouteName.meetingDetailsPage,
          params: {
            "id": widget.meeting.id,
          },
        );
      },
      boxShadow: [
        BoxShadow(
          color: context.colorScheme.surface,
          blurRadius: 5,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.meeting.title,
                      style: context.textTheme.bodyMedium?.w600,
                    ),
                    6.kH,
                    Text(
                      widget.meeting.desc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelLarge?.themeGreyTextColor,
                    ),
                    6.kH,
                    Text(
                      _dateFormatter.format(widget.meeting.date),
                      style: context.textTheme.labelLarge?.themeColor.w600,
                    ),
                  ],
                ),
              ),
              10.kW,
              FilledBox(
                height: 35,
                width: 110,
                innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
                color: Palette.themecolor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
                child: Center(
                  child: Text(
                    _timeFormatter.format(widget.meeting.time),
                    style: context.textTheme.labelLarge?.themeColor.bold,
                  ),
                ),
              ),
            ],
          ),
          8.kH,
          Text(
            'Members',
            style: context.textTheme.labelLarge?.bold,
          ),
          4.kH,
          Stack(
            children: [
              for (int i = 0;
                  i <
                      (widget.meeting.members.length > 5
                          ? 5
                          : widget.meeting.members.length);
                  i++)
                ref.watch(getUserByIdProvider(widget.meeting.members[i])).when(
                      data: (user) {
                        return Positioned(
                          left: i * 25.0,
                          child: user.profileImage.isEmpty
                              ? Image.asset(
                                  Constants.defaultProfileImage,
                                  height: 32,
                                  width: 32,
                                )
                              : CustomCachedNetworkImage(
                                  imageUrl: user.profileImage,
                                  imageBuilder: (context, imageProvider) {
                                    return CircleAvatar(
                                      radius: 16,
                                      backgroundImage: imageProvider,
                                    );
                                  },
                                  animChild: CircleAvatar(
                                    radius: 16,
                                    backgroundColor:
                                        context.colorScheme.surface,
                                  ),
                                ),
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
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: context.colorScheme.surface,
                        ),
                      ),
                    ),
              if (widget.meeting.members.length > 5)
                Positioned(
                  left: 5 * 25.0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: context.colorScheme.surface,
                    child: Text(
                      '+${widget.meeting.members.length - 5}',
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                ),
              const Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.check,
                    color: themewhitecolor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
