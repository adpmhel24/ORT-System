import 'dart:async';

import 'package:admin_app/shared/custom_text_form_box.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({super.key, this.onChanged, this.onSubmit});
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  Timer? _debounce;
  final _controller = TextEditingController();
  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      _performAction(value); // Function called after delay
    });
  }

  void _performAction(String text) {
    widget.onChanged?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormBox(
      label: "Search",
      controller: _controller,
      autofocus: true,
      onChanged: _onSearchChanged,
      suffix: IconButton(
        icon: const Icon(FluentIcons.search),
        onPressed: () {
          widget.onSubmit?.call(_controller.text);
        },
      ),
    );
  }
}
