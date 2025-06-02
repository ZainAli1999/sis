import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/features/chat/model/message_model.dart';
import 'package:sis/features/chat/viewmodel/chat_viewmodel.dart';

class EditMessagePage extends ConsumerStatefulWidget {
  final MessageModel message;
  const EditMessagePage({super.key, required this.message});

  @override
  ConsumerState<EditMessagePage> createState() => _EditMessagePageState();
}

class _EditMessagePageState extends ConsumerState<EditMessagePage> {
  late final TextEditingController _messageController;
  late final String _originalMessage;

  @override
  void initState() {
    super.initState();
    _originalMessage = widget.message.text;
    _messageController = TextEditingController(text: _originalMessage)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  bool get _hasChanges => _messageController.text != _originalMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeblackcolor.withValues(alpha: 0.1),
      appBar: AppBar(title: const Text("Edit Message")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildOriginalMessage(),
          _buildEditFooter(),
        ],
      ),
    );
  }

  Widget _buildOriginalMessage() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FilledBox(
        innerBoxPadding: const EdgeInsets.all(8),
        color:context.colorScheme.surface,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 60, bottom: 20),
              child: Text(
                widget.message.text,
                style: context.textTheme.labelLarge,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 2,
              child: Row(
                children: [
                  Text(
                     Helpers.messageTime(widget.message.timeSent),
                    style: context.textTheme.labelMedium,
                  ),
                  5.kW,
                  Icon(
                    widget.message.isSeen ? Icons.done_all : Icons.done,
                    size: 20,
                    color: widget.message.isSeen
                        ? Palette.themecolor
                        : context.colorScheme.secondary.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditFooter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FilledBox(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.zero,
        innerBoxPadding: const EdgeInsets.all(12),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.surface,
            blurRadius: 5,
          ),
        ],
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _messageController,
                maxLines: null,
                hintText: "Type Message",
                enabledBorderColor: context.colorScheme.surface,
                focusedBorderColor: Palette.themecolor,
                isOutlinedInputBorder: true,
                outlineBorderRadius: 12,
                fillColor: context.colorScheme.surface,
                filled: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
              ),
            ),
            10.kW,
            CustomIconButton(
              onTap: () => _onSubmit(),
              child: !_hasChanges
                  ? CircleAvatar(
                      backgroundColor: context.colorScheme.surface,
                      child: Icon(
                        Icons.check,
                        color: context.colorScheme.secondary,
                      ),
                    )
                  : const CircleAvatar(
                      backgroundColor: Palette.themecolor,
                      child: Icon(
                        Icons.check,
                        color: themewhitecolor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _onSubmit() async {
    if (!_hasChanges) {
      showToast(
        content: "Nothing to change",
        context: context,
        toastType: ToastType.error,
      );
      return;
    }

    Go.pop(context);

    await ref.read(chatViewModelProvider.notifier).editMyMessage(
          messageId: widget.message.messageId,
          receiverId: widget.message.receiverId,
          text: _messageController.text,
          isGroupChat: false,
        );
  }
}
