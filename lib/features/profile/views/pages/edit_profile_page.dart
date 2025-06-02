import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/core/utils/pick_file.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cnicController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  File? profileImage;

  late String currentFirstName;
  late String currentLastName;
  late String currentProfileImage;

  void selectImage() async {
    var res = await pickFile(FileType.image);
    if (res != null) {
      setState(() {
        profileImage = File(res.files.first.path!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final user = ref.read(currentUserNotifierProvider)!;
    _firstNameController.text = currentFirstName = user.firstName;
    _lastNameController.text = currentLastName = user.lastName;
    _emailController.text = user.email;
    _cnicController.text = user.cnic;
    _phoneNumberController.text = user.phoneNumber;
    currentProfileImage = user.profileImage;

    _firstNameController.addListener(_onTextChanged);
    _lastNameController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_onTextChanged);
    _lastNameController.removeListener(_onTextChanged);
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  bool _hasChanges() {
    return (_firstNameController.text != currentFirstName) ||
        (_lastNameController.text != currentLastName) ||
        profileImage != null;
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              content: 'Profile Updated Successfully!',
              context: context,
              toastType: ToastType.success,
            );
            Go.namedReplace(
              context,
              RouteName.profilePage,
            );
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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              "Edit Profile",
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomButton(
              height: 55,
              borderRadius: BorderRadius.circular(12),
              buttoncolor: _hasChanges()
                  ? Palette.themecolor
                  : context.colorScheme.surface,
              onTap: () async {
                if (_formKey.currentState!.validate() && _hasChanges()) {
                  await ref.read(authViewModelProvider.notifier).editProfile(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        profileImage: profileImage,
                      );
                } else {
                  showToast(
                    content: "No changes to update",
                    context: context,
                    toastType: ToastType.error,
                  );
                }
              },
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: themewhitecolor,
                      ),
                    )
                  : Text(
                      "Save Changes",
                      style: _hasChanges()
                          ? context.textTheme.bodyMedium?.themeWhiteColor.bold
                          : context
                              .textTheme.bodyMedium?.themeGreyTextColor.bold,
                    ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          profileImage != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(profileImage!),
                                )
                              : currentProfileImage.isEmpty
                                  ? Image.asset(
                                      Constants.defaultProfileImage,
                                      height: 100,
                                      width: 100,
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: currentProfileImage,
                                      imageBuilder: (context, imageProvider) {
                                        return CircleAvatar(
                                          radius: 50,
                                          backgroundImage: imageProvider,
                                        );
                                      },
                                      animChild: CircleAvatar(
                                        radius: 50,
                                        backgroundColor:
                                            context.colorScheme.surface,
                                      ),
                                    ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: CustomIconButton(
                              onTap: selectImage,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: context.colorScheme.secondary,
                                child: Icon(
                                  Icons.add,
                                  color: context.colorScheme.primary,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: _firstNameController,
                            validator: validateName,
                            hintText: "First Name",
                            labelText: "First Name",
                            filled: true,
                            fillColor: context.colorScheme.surface,
                            prefix: const Icon(Icons.person),
                          ),
                          20.kH,
                          CustomTextField(
                            controller: _lastNameController,
                            validator: validateName,
                            hintText: "Last Name",
                            labelText: "Last Name",
                            filled: true,
                            fillColor: context.colorScheme.surface,
                            prefix: const Icon(Icons.person),
                          ),
                          20.kH,
                          CustomTextField(
                            controller: _cnicController,
                            textInputType: TextInputType.number,
                            readOnly: true,
                            hintText: "CNIC",
                            labelText: "CNIC",
                            filled: true,
                            fillColor: context.colorScheme.surface,
                            prefix: const Padding(
                              padding: EdgeInsets.only(
                                left: 12,
                                right: 10,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.idCard,
                                size: 15,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                          ),
                          20.kH,
                          CustomTextField(
                            controller: _emailController,
                            readOnly: true,
                            hintText: "Email",
                            labelText: "Email",
                            filled: true,
                            fillColor: context.colorScheme.surface,
                            prefix: const Icon(Icons.email),
                          ),
                          20.kH,
                          CustomTextField(
                            controller: _phoneNumberController,
                            readOnly: true,
                            hintText: "Phone Number",
                            labelText: "Phone Number",
                            filled: true,
                            fillColor: context.colorScheme.surface,
                            prefix: const Icon(Icons.phone),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
