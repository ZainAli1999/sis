import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/enums/message_enum.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/pick_file.dart';
import 'package:sis/features/chat/viewmodel/chat_viewmodel.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SendFileMessagePage extends ConsumerStatefulWidget {
  final String id;
  final bool isGroupChat;
  final List<String> receiverDeviceTokens;
  const SendFileMessagePage({
    super.key,
    required this.id,
    required this.isGroupChat,
    required this.receiverDeviceTokens,
  });

  @override
  ConsumerState<SendFileMessagePage> createState() =>
      _SendFileMessagePageState();
}

class _SendFileMessagePageState extends ConsumerState<SendFileMessagePage> {
  final TextEditingController _messageController = TextEditingController();

  File? file;

  Uint8List? webFile;

  String? fileName;
  String? fileExtension;

  void selectImage() async {
    var res = await pickFile(FileType.any);
    if (res != null) {
      fileName = res.files.first.name;
      fileExtension = fileName!.split('.').last.toLowerCase();
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
  void initState() {
    selectImage();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
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
          data: (data) {},
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
          backgroundColor: transparentcolor,
          body: _buildPageBody(),
        ),
        if (isLoading) const LoadingProgress(),
      ],
    );
  }

  Widget _buildPageBody() {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      Go.pop(context);
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: themedarkgreycolor,
                      child: Icon(
                        Icons.close,
                        color: themelightgreycolor,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // if ((file != null || webFile != null) && fileExtension == 'pdf')
              //   SizedBox(
              //     height: 400,
              //     width: double.infinity,
              //     child: kIsWeb
              //         ? SfPdfViewer.memory(
              //             webFile!,
              //           )
              //         : SfPdfViewer.file(
              //             file!,
              //           ),
              //   )
              if (file != null)
                Image.file(
                  file!,
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              else if (webFile != null)
                Image.memory(
                  webFile!,
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _messageController,
                        hintText: "Type Message",
                        hintTextStyle:
                            context.textTheme.bodySmall?.themeWhiteColor,
                        cursorTextStyle:
                            context.textTheme.bodySmall?.themeWhiteColor,
                        enabledBorderColor: context.colorScheme.surface,
                        focusedBorderColor: Palette.themecolor,
                        isOutlinedInputBorder: true,
                        outlineBorderRadius: 12,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                      ),
                    ),
                    10.kW,
                    CustomIconButton(
                      onTap: () async {
                        await ref
                            .read(chatViewModelProvider.notifier)
                            .sendFileMessage(
                              receiverId: widget.id,
                              messageEnum: MessageEnum.image,
                              text: _messageController.text,
                              file: file,
                              webFile: webFile,
                              isGroupChat: widget.isGroupChat,
                              deviceTokens: widget.receiverDeviceTokens,
                            );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Palette.themecolor,
                        child: Icon(
                          Icons.send_rounded,
                          color: themewhitecolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
