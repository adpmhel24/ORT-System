import 'package:admin_app/shared/widgets/custom_button.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';
import 'custom_large_dialog.dart';

class CustomDialogBox {
  static void warningMessage(
    BuildContext context, {
    String? title,
    String? message,
    Function(BuildContext context)? onPositiveClick,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (cntx) {
        return ContentDialog(
          title: Wrap(
            children: [
              Text(title ?? "Warning"),
              const SizedBox(
                width: Constant.minPadding,
              ),
              const Icon(FluentIcons.warning),
            ],
          ),
          content: Text(message ??
              "⚠️ Kindly ensure all information provided is correct before clicking submit."),
          actions: [
            CustomFilledButton(
              onPressed: () {
                Navigator.of(cntx).pop();
                onPositiveClick?.call(cntx);
              },
              child: const Text('OK'),
            ),
            CustomButton(
              onPressed: () => Navigator.of(cntx).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  static void errorMessage(
    BuildContext context, {
    String? title,
    String? message,
    Function(BuildContext context)? onPositiveClick,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (cntx) {
        return SingleChildScrollView(
          child: ContentDialog(
            title: Text(title ?? "Error Message"),
            content: Text(
              message ?? "Something wrong, please check.",
            ),
            actions: [
              CustomFilledButton(
                onPressed: () {
                  Navigator.of(cntx).pop();
                  if (onPositiveClick != null) {
                    onPositiveClick(cntx);
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  static void successMessage(
    BuildContext context, {
    String? title,
    String? message,
    Function(BuildContext context)? onPositiveClick,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (cntx) {
        return ContentDialog(
          title: Text(title ?? "Success Message"),
          content: Text(message ?? "Congrats"),
          actions: [
            CustomFilledButton(
              onPressed: () {
                Navigator.of(cntx).pop();
                onPositiveClick?.call(cntx);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static warningWithRemarks(
    context, {
    String? title,
    String? message,
    Function(BuildContext context, String remarks)? onPositiveClick,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (cntx) {
        return WarningWithRemarksDialog(
          title: title,
          warningMessage: message,
          onPositiveClick: onPositiveClick,
        );
      },
    );
  }

  static void withTextField(
    BuildContext context, {
    String? title,
    String? message,
    String? placeHolder,
    bool isNumeric = false,
    bool isDecimal = false,
    Function(BuildContext context, String value)? onPositiveClick,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (cntx) {
        return WitTextField(
          title: title,
          warningMessage: message,
          onPositiveClick: onPositiveClick,
          placeHolder: placeHolder,
          isNumeric: isNumeric,
          isDecimal: isDecimal,
        );
      },
    );
  }

  static void selectable(BuildContext context,
      {required Widget Function(BuildContext) builder}) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return LargeDialog(
          child: Navigator(
            onGenerateInitialRoutes: (navigator, initialRoute) => [
              FluentPageRoute(
                builder: builder,
              )
            ],
          ),
        );
      },
    );
  }
}

class WarningWithRemarksDialog extends StatefulWidget {
  const WarningWithRemarksDialog({
    super.key,
    this.title,
    this.warningMessage,
    this.onPositiveClick,
  });
  final String? title;
  final String? warningMessage;
  final Function(BuildContext context, String remarks)? onPositiveClick;
  @override
  State<WarningWithRemarksDialog> createState() =>
      _WarningWithRemarksDialogState();
}

class _WarningWithRemarksDialogState extends State<WarningWithRemarksDialog> {
  TextEditingController remarks = TextEditingController();
  @override
  void dispose() {
    remarks.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Wrap(
        children: [
          Text(widget.title ?? "Warning"),
          const SizedBox(
            width: Constant.minPadding,
          ),
          const Icon(FluentIcons.warning),
          const SizedBox(
            height: Constant.minPadding,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.warningMessage ?? ""),
          const SizedBox(
            height: Constant.minPadding,
          ),
          TextFormBox(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: true,
            placeholder: "Remarks",
            maxLines: 5,
            onChanged: (value) {
              setState(() {
                remarks.text = value;
              });
            },
            validator: (value) {
              return value == null || value.isEmpty
                  ? "Remarks is required"
                  : null;
            },
          ),
        ],
      ),
      actions: [
        CustomFilledButton(
          onPressed: remarks.text.isEmpty
              ? null
              : () {
                  widget.onPositiveClick?.call(context, remarks.text);
                },
          child: const Text('OK'),
        ),
        Button(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

class WitTextField extends StatefulWidget {
  const WitTextField({
    super.key,
    this.title,
    this.warningMessage,
    this.onPositiveClick,
    this.placeHolder = "",
    this.isNumeric = false,
    this.isDecimal = false,
  });
  final String? title;
  final String? placeHolder;
  final String? warningMessage;
  final Function(BuildContext context, String remarks)? onPositiveClick;
  final bool isNumeric;
  final bool isDecimal;

  @override
  State<WitTextField> createState() => _WitTextFieldState();
}

class _WitTextFieldState extends State<WitTextField> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Wrap(
        children: [
          Text(widget.title ?? "Warning"),
          const SizedBox(
            width: Constant.minPadding,
          ),
          const Icon(FluentIcons.warning),
          const SizedBox(
            height: Constant.minPadding,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.warningMessage ?? ""),
          const SizedBox(
            height: Constant.minPadding,
          ),
          TextFormBox(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: true,
            placeholder: widget.placeHolder,
            textAlign: (widget.isNumeric || widget.isDecimal)
                ? TextAlign.right
                : TextAlign.start,
            inputFormatters: widget.isNumeric
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                  ]
                : widget.isDecimal
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^-?\d{0,12}\.?\d{0,2}')),
                      ]
                    : null,
            onChanged: (value) {
              setState(() {
                controller.text = value;
              });
            },
            validator: (value) {
              return value == null || value.isEmpty
                  ? "Field is required"
                  : null;
            },
          ),
        ],
      ),
      actions: [
        CustomFilledButton(
          onPressed: controller.text.isEmpty
              ? null
              : () {
                  widget.onPositiveClick?.call(context, controller.text);
                },
          child: const Text('OK'),
        ),
        Button(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
