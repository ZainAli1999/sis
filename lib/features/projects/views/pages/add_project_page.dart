// import 'dart:developer';
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:sis/core/common_widgets/custom_button.dart';
// import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
// import 'package:sis/core/common_widgets/custom_text_field.dart';
// import 'package:sis/core/common_widgets/outlined_box.dart';
// import 'package:sis/core/common_widgets/slider_view.dart';
// import 'package:sis/core/common_widgets/snack_bar.dart';
// import 'package:sis/core/extensions/spacing_extension.dart';
// import 'package:sis/core/extensions/text_style_extension.dart';
// import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:sis/core/route_structure/go_navigator.dart';
// import 'package:sis/core/route_structure/go_router.dart';
// import 'package:sis/core/theme/colors.dart';
// import 'package:sis/core/utils/constants.dart';
// import 'package:sis/core/utils/fields_validation.dart';
// import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
// import 'package:sis/features/projects/viewmodel/project_viewmodel.dart';

// class CreateTaskPage extends ConsumerStatefulWidget {
//   const CreateTaskPage({super.key});

//   @override
//   ConsumerState<CreateTaskPage> createState() => _CreateTaskPageState();
// }

// class _CreateTaskPageState extends ConsumerState<CreateTaskPage> {
//   final _titleController = TextEditingController();
//   final _descController = TextEditingController();
//   final _organizationController = TextEditingController();
//   final _priorityController = TextEditingController();

//   DateTime? _dueDate;
//   DateTime? _deadline;

//   final List<String> _priority = [
//     'High',
//     'Medium',
//     'Low',
//   ];

//   String? _selectedPriority;

//   List<String> _selectAssignedTo = [];

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descController.dispose();
//     _organizationController.dispose();
//     _priorityController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildPageHeader(),
//       body: _buildPageBody(),
//     );
//   }

//   PreferredSizeWidget _buildPageHeader() {
//     final isLoading = ref
//         .watch(projectViewModelProvider.select((val) => val?.isLoading == true));
//     ref.listen(
//       projectViewModelProvider,
//       (_, next) {
//         next?.when(
//           data: (data) {
//             _titleController.clear();
//             _descController.clear();
//             _organizationController.clear();
//             _selectedPriority = null;
//             _dueDate = null;
//             _deadline = null;
//             _selectAssignedTo = [];
//             showSnackBar(context, 'Task Created Successfully!');
//           },
//           error: (error, st) {
//             showSnackBar(context, error.toString());
//           },
//           loading: () {},
//         );
//       },
//     );
//     return AppBar(
//       title: const Text('Create Task'),
//       actions: [
//         CustomButton(
//           height: 40,
//           width: 140,
//           buttoncolor: Palette.themecolor,
//           borderRadius: BorderRadius.circular(30),
//           onTap: () async {
//             if (_formKey.currentState!.validate() &&
//                 _selectedPriority != null &&
//                 _deadline != null &&
//                 _selectAssignedTo.isNotEmpty) {
//               await ref.read(projectViewModelProvider.notifier).createTask(
//                     title: _titleController.text,
//                     desc: _descController.text,
//                     organization: _organizationController.text,
//                     priority: _selectedPriority!,
//                     dueDate: _dueDate,
//                     deadline: _deadline,
//                     assignedTo: _selectAssignedTo,
//                   );
//             } else if (_selectedPriority == null) {
//               showSnackBar(context, 'Please Select Priority');
//             } else if (_deadline == null) {
//               showSnackBar(context, 'Please Select Deadline');
//             } else if (_selectAssignedTo.isEmpty) {
//               showSnackBar(context, 'Please Select Assigned to');
//             } else {
//               showSnackBar(context, 'Please Enter All Required Fields');
//             }
//           },
//           child: isLoading
//               ? const Center(
//                   child: CircularProgressIndicator(
//                     color: themewhitecolor,
//                   ),
//                 )
//               : Text(
//                   "Create Task",
//                   style: context.textTheme.labelLarge?.themeWhiteColor.bold,
//                 ),
//         ),
//         15.kW,
//       ],
//     );
//   }

//   Widget _buildPageBody() {
//     ref.listen(
//       taskViewModelProvider,
//       (_, next) {
//         next?.when(
//           data: (data) {
//             showSnackBar(context, 'Task Created Successfully!');
//             Go.namedReplace(
//               context,
//               RouteName.homePage,
//             );
//           },
//           error: (error, st) {
//             showSnackBar(context, error.toString());
//           },
//           loading: () {},
//         );
//       },
//     );
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.only(bottom: 80),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // const CustomHorizontalCalendar(),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Title *',
//                     style: context.textTheme.bodySmall?.bold,
//                   ),
//                   10.kH,
//                   CustomTextField(
//                     controller: _titleController,
//                     validator: validateField,
//                     hintText: "Title",
//                     filled: true,
//                     fillColor: context.colorScheme.primary,
//                     boxShadow: [
//                       BoxShadow(
//                         color: context.colorScheme.surface,
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   24.kH,
//                   Text(
//                     'Organization *',
//                     style: context.textTheme.bodySmall?.bold,
//                   ),
//                   10.kH,
//                   CustomTextField(
//                     controller: _organizationController,
//                     validator: validateField,
//                     hintText: "Organization",
//                     filled: true,
//                     fillColor: context.colorScheme.primary,
//                     boxShadow: [
//                       BoxShadow(
//                         color: context.colorScheme.surface,
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   24.kH,
//                   Text(
//                     'Description *',
//                     style: context.textTheme.bodySmall?.bold,
//                   ),
//                   10.kH,
//                   CustomTextField(
//                     controller: _descController,
//                     validator: validateField,
//                     maxLines: 4,
//                     hintText: "Description",
//                     filled: true,
//                     fillColor: context.colorScheme.primary,
//                     boxShadow: [
//                       BoxShadow(
//                         color: context.colorScheme.surface,
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   24.kH,
//                   Text(
//                     'Priority *',
//                     style: context.textTheme.bodySmall?.bold,
//                   ),
//                   10.kH,
//                   CustomDropdown(
//                     hintText: 'Select Priority',
//                     items: _priority,
//                     closedHeaderPadding: const EdgeInsets.all(16),
//                     expandedHeaderPadding: const EdgeInsets.all(16),
//                     // initialItem: _list[0],
//                     decoration: CustomDropdownDecoration(
//                       closedFillColor: context.colorScheme.primary,
//                       closedShadow: [
//                         BoxShadow(
//                           color: context.colorScheme.surface,
//                           blurRadius: 10,
//                         ),
//                       ],
//                       expandedFillColor: context.colorScheme.primary,
//                       headerStyle: context.textTheme.bodySmall,
//                       hintStyle: context.textTheme.bodySmall,
//                       listItemStyle: context.textTheme.bodySmall,
//                       closedSuffixIcon: Icon(
//                         Icons.expand_more,
//                         color: context.colorScheme.secondary,
//                       ),
//                       expandedSuffixIcon: Icon(
//                         Icons.expand_less,
//                         color: context.colorScheme.secondary,
//                       ),
//                     ),
//                     onChanged: (value) {
//                       log('changing value to: $value');
//                       _selectedPriority = value;
//                     },
//                   ),
//                   24.kH,
//                   Text(
//                     'Due Date',
//                     style: context.textTheme.bodySmall?.bold,
//                   ),
//                   10.kH,
//                   GestureDetector(
//                     onTap: () async {
//                       final selectedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (selectedDate != null) {
//                         setState(() {
//                           _dueDate = selectedDate;
//                         });
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 16, horizontal: 12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade400),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             _dueDate != null
//                                 ? "${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}"
//                                 : "Select Due Date",
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                           const Icon(Icons.calendar_today),
//                         ],
//                       ),
//                     ),
//                   ),
//                   24.kH,
//                   Text(
//                     'Deadline *',
//                     style: context.textTheme.bodySmall?.bold,
//                   ),
//                   10.kH,
//                   GestureDetector(
//                     onTap: () async {
//                       final selectedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (selectedDate != null) {
//                         setState(() {
//                           _deadline = selectedDate;
//                         });
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 16, horizontal: 12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade400),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             _deadline != null
//                                 ? "${_deadline!.day}/${_deadline!.month}/${_deadline!.year}"
//                                 : "Select Deadline",
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                           const Icon(Icons.calendar_today),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // 24.kH,
//                   // Text(
//                   //   'Time',
//                   //   style: context.textTheme.bodySmall?.bold,
//                   // ),
//                   // 10.kH,
//                   // const TimePickerScreen(),
//                   24.kH,
//                   Text(
//                     'Assigned to',
//                     style: context.textTheme.bodySmall?.bold,
//                   ),
//                   10.kH,
//                   Row(
//                     children: [
//                       Column(
//                         children: [
//                           const OutlinedBox(
//                             height: 50,
//                             width: 50,
//                             shape: BoxShape.circle,
//                             child: Icon(Icons.add),
//                           ),
//                           5.kH,
//                           Text(
//                             'Add',
//                             style: context.textTheme.labelLarge,
//                           ),
//                         ],
//                       ),
//                       Expanded(
//                         child: ref.watch(fetchUsersProvider).when(
//                               data: (users) => SliderView(
//                                 childBuilder: (context, index) {
//                                   final user = users[index];
//                                   final isSelected =
//                                       _selectAssignedTo.contains(user.uid);
//                                   return GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         // selectQualified = value;
//                                         if (isSelected) {
//                                           _selectAssignedTo.remove(user.uid);
//                                         } else {
//                                           _selectAssignedTo.add(user.uid);
//                                         }
//                                       });
//                                     },
//                                     child: Column(
//                                       children: [
//                                         user.profileImage.isEmpty
//                                             ? isSelected
//                                                 ? Container(
//                                                     height: 50,
//                                                     width: 50,
//                                                     decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                         color: context
//                                                             .colorScheme
//                                                             .secondary,
//                                                         width: 2.5,
//                                                       ),
//                                                       shape: BoxShape.circle,
//                                                       image:
//                                                           const DecorationImage(
//                                                         image: AssetImage(
//                                                           Constants
//                                                               .defaultProfileImage,
//                                                         ),
//                                                         fit: BoxFit.cover,
//                                                         opacity: 0.5,
//                                                       ),
//                                                     ),
//                                                     child: Icon(
//                                                       Icons.check,
//                                                       color: context.colorScheme
//                                                           .secondary,
//                                                       size: 30,
//                                                     ),
//                                                   )
//                                                 : Image.asset(
//                                                     Constants
//                                                         .defaultProfileImage,
//                                                     height: 50,
//                                                     width: 50,
//                                                   )
//                                             : isSelected
//                                                 ? Container(
//                                                     height: 50,
//                                                     width: 50,
//                                                     decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                         color: context
//                                                             .colorScheme
//                                                             .secondary,
//                                                         width: 2.5,
//                                                       ),
//                                                       shape: BoxShape.circle,
//                                                       image: DecorationImage(
//                                                         image: NetworkImage(
//                                                           user.profileImage,
//                                                         ),
//                                                         fit: BoxFit.cover,
//                                                         opacity: 0.5,
//                                                       ),
//                                                     ),
//                                                     child: Icon(
//                                                       Icons.check,
//                                                       color: context.colorScheme
//                                                           .secondary,
//                                                       size: 30,
//                                                     ),
//                                                   )
//                                                 : CustomCachedNetworkImage(
//                                                     imageUrl: user.profileImage,
//                                                     imageBuilder: (context,
//                                                         imageProvider) {
//                                                       return CircleAvatar(
//                                                         radius: 25,
//                                                         backgroundImage:
//                                                             imageProvider,
//                                                       );
//                                                     },
//                                                     animChild:
//                                                         const CircleAvatar(
//                                                       radius: 25,
//                                                       backgroundColor:
//                                                           themegreycolor,
//                                                     ),
//                                                   ),
//                                         5.kH,
//                                         Text(
//                                           "${user.firstName} ${user.lastName}",
//                                           style: context.textTheme.labelLarge,
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 items: users.length,
//                               ),
//                               error: (error, st) {
//                                 return Center(
//                                   child: Text(
//                                     error.toString(),
//                                   ),
//                                 );
//                               },
//                               loading: () => Shimmer.fromColors(
//                                 baseColor: themelightgreycolor,
//                                 highlightColor: themegreycolor,
//                                 child: Column(
//                                   children: [
//                                     const CircleAvatar(
//                                       radius: 25,
//                                       backgroundColor: themegreycolor,
//                                     ),
//                                     5.kH,
//                                     Container(
//                                       height: 15,
//                                       width: 100,
//                                       decoration: BoxDecoration(
//                                         color: themegreycolor,
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TimePickerScreen extends StatefulWidget {
//   const TimePickerScreen({super.key});

//   @override
//   State<TimePickerScreen> createState() => _TimePickerScreenState();
// }

// class _TimePickerScreenState extends State<TimePickerScreen> {
//   TimeOfDay? startTime;
//   TimeOfDay? endTime;

//   // Helper function to format TimeOfDay to string
//   String formatTimeOfDay(TimeOfDay time) {
//     return MaterialLocalizations.of(context)
//         .formatTimeOfDay(time, alwaysUse24HourFormat: false);
//   }

//   Future<void> pickStartTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: startTime ?? TimeOfDay.now(),
//       builder: (BuildContext context, Widget? child) {
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != startTime) {
//       setState(() {
//         startTime = picked;
//       });
//     }
//   }

//   Future<void> pickEndTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: endTime ?? TimeOfDay.now(),
//       builder: (BuildContext context, Widget? child) {
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != endTime) {
//       setState(() {
//         endTime = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => pickStartTime(context),
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade400),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         startTime != null
//                             ? formatTimeOfDay(startTime!)
//                             : "Starts",
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                       const Icon(Icons.access_time),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             16.kW,
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => pickEndTime(context),
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade400),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         endTime != null ? formatTimeOfDay(endTime!) : "Ends",
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                       const Icon(Icons.access_time),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
