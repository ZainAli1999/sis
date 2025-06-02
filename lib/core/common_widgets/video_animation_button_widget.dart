// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:vshop/theme/colors.dart';

// class VideoAnimationButtonWidget extends StatefulWidget {
//   final bool playButtonShow;

//   final bool pause;
//   final Color indicatorColor;
//   final double indicatorSize;
//   // final bool network;
//   final int videoType;
//   final dynamic path;
//   final double height;
//   final double width;
//   final double playButtonSize;
//   Decoration? foregroundDecoration;
//   VideoAnimationButtonWidget({
//     super.key,
//     this.playButtonShow = true,
//     this.pause = true,
//     this.indicatorColor = themewhitecolor,
//     this.indicatorSize = 20,
//     this.videoType = 0,
//     required this.path,
//     this.height = 50,
//     this.width = double.infinity,
//     this.playButtonSize = 30,
//     this.foregroundDecoration,
//   });

//   @override
//   State<VideoAnimationButtonWidget> createState() =>
//       _VideoAnimationButtonWidgetState();
// }

// class _VideoAnimationButtonWidgetState extends State<VideoAnimationButtonWidget>
//     with SingleTickerProviderStateMixin {
//   late Animation<double> scaleAnimation;
//   late AnimationController animationController;
//   late VideoPlayerController _videoController;
//   bool isVideoPause = true;
//   @override
//   void initState() {
//     load();
//     super.initState();
//   }

//   load() {
//     widget.foregroundDecoration ??= BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       gradient: LinearGradient(
//         colors: [
//           themeblackcolor.withOpacity(0.3),
//           themeblackcolor.withOpacity(0.4),
//           themeblackcolor.withOpacity(0.5),
//           themeblackcolor.withOpacity(0.8),
//         ],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//       ),
//     );
//     isVideoPause = widget.pause;
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     if (widget.videoType == 0) {
//       _videoController = VideoPlayerController.networkUrl(
//         Uri.parse(
//           widget.path,
//         ),
//       );
//     } else if (widget.videoType == 1) {
//       _videoController = VideoPlayerController.file(
//         widget.path,
//       );
//     } else {
//       _videoController = VideoPlayerController.asset(
//         widget.path,
//       );
//     }

//     scaleAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: Curves.ease,
//         reverseCurve: Curves.ease,
//       ),
//     );
//     _videoController.addListener(() {
//       setState(() {});
//     });

//     _videoController.setLooping(true);
//     _videoController.initialize().then((_) => setState(() {}));
//     if (widget.pause) {
//       _videoController.pause();
//       animationController.forward();
//     } else {
//       _videoController.play();
//       animationController.reverse();
//     }
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         // playVideo();
//         setState(() {
//           if (_videoController.value.isPlaying) {
//             setState(() {
//               isVideoPause = true;
//             });
//             _videoController.pause();
//             animationController.forward().then(
//                   (value) => Timer(
//                     const Duration(milliseconds: 300),
//                     () {
//                       // setState(() {
//                       //   isVideoPause = false;
//                       // });
//                     },
//                   ),
//                 );
//           } else {
//             setState(() {
//               isVideoPause = true;
//             });
//             _videoController.play();
//             animationController.reverse().then(
//                   (value) => Timer(
//                     const Duration(milliseconds: 300),
//                     () {
//                       setState(() {
//                         isVideoPause = false;
//                       });
//                     },
//                   ),
//                 );
//           }
//         });
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             height: widget.height,
//             width: widget.width,
//             foregroundDecoration: widget.foregroundDecoration,
//             child: _videoController.value.isInitialized
//                 ? ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12),
//                     ),
//                     child: Stack(
//                       alignment: AlignmentDirectional.center,
//                       children: [
//                         VideoPlayer(_videoController),
//                         _videoController.value.isBuffering
//                             ? Center(
//                                 child: CupertinoActivityIndicator(
//                                   color: widget.indicatorColor,
//                                   radius: widget.indicatorSize,
//                                 ),
//                               )
//                             : const SizedBox(),
//                       ],
//                     ),
//                   )
//                 : Center(
//                     child: CupertinoActivityIndicator(
//                       color: widget.indicatorColor,
//                       radius: widget.indicatorSize,
//                     ),
//                   ),
//           ),
//           widget.playButtonShow == false
//               ? const SizedBox()
//               : _videoController.value.isInitialized
//                   ? _videoController.value.isBuffering
//                       ? const SizedBox()
//                       : Visibility(
//                           visible: isVideoPause,
//                           child: ScaleTransition(
//                             scale: scaleAnimation,
//                             alignment: Alignment.center,
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: CircleAvatar(
//                                 radius: widget.playButtonSize + 5,
//                                 backgroundColor:
//                                     themeblackcolor.withOpacity(0.5),
//                                 child: Icon(
//                                   _videoController.value.isPlaying
//                                       ? Icons.pause
//                                       : Icons.play_arrow,
//                                   color: themewhitecolor,
//                                   size: widget.playButtonSize,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                   : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }
