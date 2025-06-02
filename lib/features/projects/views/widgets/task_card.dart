import 'package:flutter/material.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final List<String> _profileImages = [
    'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
    'https://t3.ftcdn.net/jpg/03/02/88/46/360_F_302884605_actpipOdPOQHDTnFtp4zg4RtlWzhOASp.jpg',
    'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
    'https://t3.ftcdn.net/jpg/03/02/88/46/360_F_302884605_actpipOdPOQHDTnFtp4zg4RtlWzhOASp.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return FilledBox(
      width: context.screenWidth,
      color: context.colorScheme.primary,
      onTap: () {
        Go.named(
          context,
          RouteName.projectDetailsPage,
        );
      },
      boxShadow: [
        BoxShadow(
          color: context.colorScheme.surface,
          blurRadius: 10,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meeting Online',
                    style: context.textTheme.bodyMedium?.w600,
                  ),
                  6.kH,
                  Text(
                    'Discuss team tasks for the day',
                    style: context.textTheme.labelLarge?.themeGreyTextColor,
                  ),
                ],
              ),
              FilledBox(
                height: 35,
                width: 110,
                innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
                color: Palette.themecolor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
                child: Center(
                  child: Text(
                    '10:00 AM',
                    style: context.textTheme.labelLarge?.themeColor.bold,
                  ),
                ),
              ),
            ],
          ),
          8.kH,
          Text(
            'Teams',
            style: context.textTheme.labelLarge?.bold,
          ),
          4.kH,
          Stack(
            alignment: Alignment.center,
            children: [
              for (int i = 0; i < _profileImages.length; i++)
                Positioned(
                  left: i * 25.0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(_profileImages[i]),
                  ),
                ),
              Positioned(
                left: _profileImages.length * 25.0,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: context.colorScheme.surface,
                  child: Text(
                    '+5',
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
