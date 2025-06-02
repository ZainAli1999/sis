
// import 'package:flutter/material.dart';
// import 'package:sis/core/theme/colors.dart';

// class ActiveDot extends StatelessWidget {
//   const ActiveDot({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 3, right: 3),
//       height: 7,
//       width: 7,
//       decoration: BoxDecoration(
//         color: Palette.themecolor,
//         borderRadius: BorderRadius.circular(50),
//       ),
//     );
//   }
// }

// class InactiveDot extends StatelessWidget {
//   const InactiveDot({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 3, right: 3),
//       height: 7,
//       width: 7,
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(50),
//       ),
//     );
//   }
// }

// class ImageSlider extends StatefulWidget {
//   final double viewportFraction;
//   final double height;
//   final double leftMargin;
//   final double rightMargin;
//   final bool enlargeCenterPage;
//   final bool isShowIndicator;
//   final bool showText;
//   final List images;
//   final bool autoPlay;
//   final double borderRadius;
//   final bool isVideo;
//   final bool isNetworkImage;
//   final bool enableInfiniteScroll;
//   final String videoLink;
//   final bool useShadow;
//   final double? indicatorPositionTop;
//   final double indicatorPositionLeft;
//   final double indicatorPositionRight;
//   final double indicatorPositionBottom;
//   const ImageSlider({
//     Key? key,
//     this.viewportFraction = 1,
//     this.height = 180,
//     this.leftMargin = 20,
//     this.rightMargin = 20,
//     this.enlargeCenterPage = false,
//     this.isShowIndicator = true,
//     this.showText = false,
//     this.images = const [],
//     this.autoPlay = true,
//     this.borderRadius = 12,
//     this.isVideo = false,
//     this.isNetworkImage = true,
//     this.enableInfiniteScroll = true,
//     this.videoLink = '',
//     this.useShadow = true,
//     this.indicatorPositionTop,
//     this.indicatorPositionLeft = 0,
//     this.indicatorPositionRight = 0,
//     this.indicatorPositionBottom = -20,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _ImageSliderState createState() => _ImageSliderState();
// }

// class _ImageSliderState extends State<ImageSlider>
//     with SingleTickerProviderStateMixin {
//   int activeIndex = 0;
//   late Animation<double> scaleAnimation;
//   late AnimationController animationController;
//   // late VideoPlayerController _videoController;
//   bool isVideoPause = true;
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   animationController = AnimationController(
//   //     vsync: this,
//   //     duration: const Duration(milliseconds: 500),
//   //   );
//   //   _videoController = VideoPlayerController.networkUrl(
//   //     Uri.parse(widget.videoLink),
//   //   );
//   //   scaleAnimation = Tween<double>(
//   //     begin: 0,
//   //     end: 1,
//   //   ).animate(
//   //     CurvedAnimation(
//   //       parent: animationController,
//   //       curve: Curves.ease,
//   //       reverseCurve: Curves.ease,
//   //     ),
//   //   );
//   //   _videoController.addListener(() {
//   //     setState(() {});
//   //   });

//   //   _videoController.setLooping(true);
//   //   _videoController.initialize().then((_) => setState(() {}));
//   //   _videoController.pause();
//   //   animationController.forward();
//   // }

//   // @override
//   // void dispose() {
//   //   _videoController.dispose();
//   //   super.dispose();
//   // }

//   setActiveDot(index) {
//     setState(() {
//       activeIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       alignment: Alignment.topCenter,
//       children: <Widget>[
//         CarouselSlider(
//           options: CarouselOptions(
//             autoPlayInterval: const Duration(seconds: 5),
//             autoPlay: widget.autoPlay,
//             height: widget.height,
//             enlargeCenterPage: widget.enlargeCenterPage,
//             autoPlayCurve: Curves.fastLinearToSlowEaseIn,
//             autoPlayAnimationDuration: const Duration(seconds: 2),
//             viewportFraction: widget.viewportFraction,
//             enableInfiniteScroll: widget.enableInfiniteScroll,
//             onPageChanged: (index, reason) {
//               setActiveDot(index);
//             },
//           ),
//           items: List.generate(
//             widget.images.length,
//             (index) {
//               return widget.isNetworkImage
//                   ? CustomCachedNetworkImage(
//                       imageUrl: widget.images[index],
//                       imageBuilder: (context, imageProvider) {
//                         return Container(
//                           margin: EdgeInsets.only(
//                             left: widget.leftMargin,
//                             right: widget.rightMargin,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius:
//                                 BorderRadius.circular(widget.borderRadius),
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.circular(widget.borderRadius),
//                               gradient: widget.useShadow
//                                   ? LinearGradient(
//                                       colors: [
//                                         themeblackcolor.withOpacity(0.4),
//                                         themeblackcolor.withOpacity(0.4),
//                                         themeblackcolor.withOpacity(0.4),
//                                         themeblackcolor.withOpacity(0.4),
//                                       ],
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                     )
//                                   : null,
//                             ),
//                             child: widget.showText
//                                 ? Padding(
//                                     padding: const EdgeInsets.all(20.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         const Text(
//                                           "Live Auction",
//                                           style: TextStyle(
//                                             color: themewhitecolor,
//                                             fontSize: largefontsize1,
//                                             fontWeight: boldfontweight,
//                                           ),
//                                         ),
//                                         10.kH,
//                                         const Text(
//                                           "A live auction is an event where participants bid in real-time on items or properties, with an auctioneer facilitating the process. It often involves competitive bidding and immediate sales.",
//                                           style: TextStyle(
//                                             color: themewhitecolor,
//                                             fontWeight: boldfontweight,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 : null,
//                             // child: widget.isVideo
//                             //     ? InkWell(
//                             //         onTap: () {
//                             //           // playVideo();
//                             //           setState(() {
//                             //             if (_videoController.value.isPlaying) {
//                             //               setState(() {
//                             //                 isVideoPause = true;
//                             //               });
//                             //               _videoController.pause();
//                             //               animationController.forward().then(
//                             //                     (value) => Timer(
//                             //                       const Duration(milliseconds: 300),
//                             //                       () {
//                             //                         // setState(() {
//                             //                         //   isVideoPause = false;
//                             //                         // });
//                             //                       },
//                             //                     ),
//                             //                   );
//                             //             } else {
//                             //               setState(() {
//                             //                 isVideoPause = true;
//                             //               });
//                             //               _videoController.play();
//                             //               animationController.reverse().then(
//                             //                     (value) => Timer(
//                             //                       const Duration(milliseconds: 300),
//                             //                       () {
//                             //                         setState(() {
//                             //                           isVideoPause = false;
//                             //                         });
//                             //                       },
//                             //                     ),
//                             //                   );
//                             //             }
//                             //           });
//                             //         },
//                             //         child: Stack(
//                             //           children: [
//                             //             Container(
//                             //               height: 275,
//                             //               foregroundDecoration: BoxDecoration(
//                             //                 borderRadius: BorderRadius.only(
//                             //                   topLeft:
//                             //                       Radius.circular(widget.borderRadius),
//                             //                   topRight:
//                             //                       Radius.circular(widget.borderRadius),
//                             //                 ),
//                             //                 gradient: LinearGradient(
//                             //                   colors: [
//                             //                     themeblackcolor.withOpacity(0.3),
//                             //                     themeblackcolor.withOpacity(0.4),
//                             //                     themeblackcolor.withOpacity(0.5),
//                             //                     themeblackcolor.withOpacity(0.8),
//                             //                   ],
//                             //                   begin: Alignment.topCenter,
//                             //                   end: Alignment.bottomCenter,
//                             //                 ),
//                             //               ),
//                             //               child: VideoPlayer(_videoController),
//                             //             ),
//                             //             Visibility(
//                             //               visible: isVideoPause,
//                             //               child: ScaleTransition(
//                             //                 scale: scaleAnimation,
//                             //                 alignment: Alignment.center,
//                             //                 child: Align(
//                             //                   alignment: Alignment.center,
//                             //                   child: CircleAvatar(
//                             //                     radius: 35,
//                             //                     backgroundColor:
//                             //                         themeblackcolor.withOpacity(0.5),
//                             //                     child: Icon(
//                             //                       _videoController.value.isPlaying
//                             //                           ? Icons.pause
//                             //                           : Icons.play_arrow,
//                             //                       color: themewhitecolor,
//                             //                       size: 30,
//                             //                     ),
//                             //                   ),
//                             //                 ),
//                             //               ),
//                             //             ),
//                             //           ],
//                             //         ),
//                             //       )
//                             //     : Container(),
//                           ),
//                         );
//                       },
//                       animChild: Container(
//                         height: widget.height,
//                         width: double.infinity,
//                         color: themegreycolor,
//                       ),
//                     )
//                   : Container(
//                       margin: EdgeInsets.only(
//                         left: widget.leftMargin,
//                         right: widget.rightMargin,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             BorderRadius.circular(widget.borderRadius),
//                         image: widget.isVideo
//                             ? null
//                             : DecorationImage(
//                                 image: AssetImage(
//                                   widget.images[index],
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(widget.borderRadius),
//                           gradient: widget.useShadow
//                               ? LinearGradient(
//                                   colors: [
//                                     themeblackcolor.withOpacity(0.4),
//                                     themeblackcolor.withOpacity(0.4),
//                                     themeblackcolor.withOpacity(0.4),
//                                     themeblackcolor.withOpacity(0.4),
//                                   ],
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                 )
//                               : null,
//                         ),
//                         child: widget.showText
//                             ? Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "Live Auction",
//                                       style: TextStyle(
//                                         color: themewhitecolor,
//                                         fontSize: largefontsize1,
//                                         fontWeight: boldfontweight,
//                                       ),
//                                     ),
//                                     10.kH,
//                                     const Text(
//                                       "A live auction is an event where participants bid in real-time on items or properties, with an auctioneer facilitating the process. It often involves competitive bidding and immediate sales.",
//                                       style: TextStyle(
//                                         color: themewhitecolor,
//                                         fontWeight: boldfontweight,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : null,
//                         // child: widget.isVideo
//                         //     ? InkWell(
//                         //         onTap: () {
//                         //           // playVideo();
//                         //           setState(() {
//                         //             if (_videoController.value.isPlaying) {
//                         //               setState(() {
//                         //                 isVideoPause = true;
//                         //               });
//                         //               _videoController.pause();
//                         //               animationController.forward().then(
//                         //                     (value) => Timer(
//                         //                       const Duration(milliseconds: 300),
//                         //                       () {
//                         //                         // setState(() {
//                         //                         //   isVideoPause = false;
//                         //                         // });
//                         //                       },
//                         //                     ),
//                         //                   );
//                         //             } else {
//                         //               setState(() {
//                         //                 isVideoPause = true;
//                         //               });
//                         //               _videoController.play();
//                         //               animationController.reverse().then(
//                         //                     (value) => Timer(
//                         //                       const Duration(milliseconds: 300),
//                         //                       () {
//                         //                         setState(() {
//                         //                           isVideoPause = false;
//                         //                         });
//                         //                       },
//                         //                     ),
//                         //                   );
//                         //             }
//                         //           });
//                         //         },
//                         //         child: Stack(
//                         //           children: [
//                         //             Container(
//                         //               height: 275,
//                         //               foregroundDecoration: BoxDecoration(
//                         //                 borderRadius: BorderRadius.only(
//                         //                   topLeft:
//                         //                       Radius.circular(widget.borderRadius),
//                         //                   topRight:
//                         //                       Radius.circular(widget.borderRadius),
//                         //                 ),
//                         //                 gradient: LinearGradient(
//                         //                   colors: [
//                         //                     themeblackcolor.withOpacity(0.3),
//                         //                     themeblackcolor.withOpacity(0.4),
//                         //                     themeblackcolor.withOpacity(0.5),
//                         //                     themeblackcolor.withOpacity(0.8),
//                         //                   ],
//                         //                   begin: Alignment.topCenter,
//                         //                   end: Alignment.bottomCenter,
//                         //                 ),
//                         //               ),
//                         //               child: VideoPlayer(_videoController),
//                         //             ),
//                         //             Visibility(
//                         //               visible: isVideoPause,
//                         //               child: ScaleTransition(
//                         //                 scale: scaleAnimation,
//                         //                 alignment: Alignment.center,
//                         //                 child: Align(
//                         //                   alignment: Alignment.center,
//                         //                   child: CircleAvatar(
//                         //                     radius: 35,
//                         //                     backgroundColor:
//                         //                         themeblackcolor.withOpacity(0.5),
//                         //                     child: Icon(
//                         //                       _videoController.value.isPlaying
//                         //                           ? Icons.pause
//                         //                           : Icons.play_arrow,
//                         //                       color: themewhitecolor,
//                         //                       size: 30,
//                         //                     ),
//                         //                   ),
//                         //                 ),
//                         //               ),
//                         //             ),
//                         //           ],
//                         //         ),
//                         //       )
//                         //     : Container(),
//                       ),
//                     );
//             },
//           ),
//         ),
//         widget.isShowIndicator == true
//             ? Positioned(
//                 top: widget.indicatorPositionTop,
//                 bottom: widget.indicatorPositionBottom,
//                 right: widget.indicatorPositionRight,
//                 left: widget.indicatorPositionLeft,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     widget.images.length,
//                     (idx) {
//                       return activeIndex == idx
//                           ? const ActiveDot()
//                           : const InactiveDot();
//                     },
//                   ),
//                 ),
//               )
//             : Container(),
//       ],
//     );
//   }
// }

// // class ImageSliderModel {
// //   final String image;
// //   ImageSliderModel({
// //     required this.image,
// //   });
// // }

// // List<ImageSliderModel> imageslidercontent = [
// //   ImageSliderModel(
// //     image:
// //         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/ea/99/11/exterior.jpg?w=700&h=-1&s=1",
// //   ),
// //   ImageSliderModel(
// //     image:
// //         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/23/b2/2e/64/atlantis-the-palm.jpg?w=700&h=-1&s=1",
// //   ),
// //   ImageSliderModel(
// //     image:
// //         "https://cf.bstatic.com/xdata/images/hotel/max1024x768/445419839.jpg?k=6278d7b2759917b85b4f9cb75210ad7861f64426986a76d077c2ce5dd3023529&o=&hp=1",
// //   ),
// // ];
