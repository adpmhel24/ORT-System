import 'package:clipboard/clipboard.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autoFocus = false,
    this.style,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autoFocus;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Button(
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autoFocus,
        style: style,
        child: child,
      ),
    );
  }
}

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autoFocus = false,
    this.style,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autoFocus;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autoFocus,
        style: style,
        child: child,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autoFocus = false,
    this.style,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autoFocus;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: HyperlinkButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autoFocus,
        style: style,
        child: child,
      ),
    );
  }
}

class CopyButton extends StatefulWidget {
  const CopyButton({super.key, required this.value, this.style});

  final String value;
  final TextStyle? style;

  @override
  State<CopyButton> createState() => _CopyWidgetStateProperty();
}

class _CopyWidgetStateProperty extends State<CopyButton> {
  Future<void> showCopiedSnackbar(BuildContext context, String copiedText) {
    return displayInfoBar(context, builder: (context, close) {
      return InfoBar(
        title: const Text("Copy"),
        content: RichText(
          text: TextSpan(
            text: 'Copied ',
            style: FluentTheme.maybeOf(context)?.typography.body,
            children: [
              TextSpan(
                text: copiedText,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () async {
        final copyText = widget.value;
        await FlutterClipboard.copy(copyText);
        if (mounted) showCopiedSnackbar(context, copyText);
      },
      cursor: SystemMouseCursors.copy,
      builder: (context, states) {
        return FocusBorder(
          focused: states.isFocused,
          renderOutside: false,
          child: Tooltip(
            useMousePosition: false,
            message: '\n${widget.value}\n(tap to copy to clipboard)\n',
            // child: RepaintBoundary(
            //   child: AnimatedContainer(
            //     duration: FluentTheme.of(context).fasterAnimationDuration,
            //     decoration: BoxDecoration(
            //       color: ButtonThemeData.uncheckedInputColor(
            //         FluentTheme.of(context),
            //         states,
            //       ),
            //       // borderRadius: BorderRadius.circular(20.0),
            //     ),
            //     padding: const EdgeInsets.all(6.0),
            //     child: Text(
            //       widget.value,
            //       style: widget.style,
            //       overflow: TextOverflow.fade,
            //     ),
            //   ),
            // ),
            child: Text(
              widget.value,
              style: widget.style,
              // overflow: TextOverflow.fade,
            ),
          ),
        );
      },
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autoFocus = false,
    this.style,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autoFocus;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autoFocus,
        style: style,
        icon: icon,
      ),
    );
  }
}
