import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class CustomTextFormBox extends StatelessWidget {
  final bool readOnly;
  final BoxDecoration? decoration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final bool obscureText;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final FormFieldValidator<String>? validator;
  final String label;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;

  const CustomTextFormBox({
    super.key,
    this.readOnly = false,
    this.decoration,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.placeholder,
    this.obscureText = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.validator,
    required this.label,
    this.autovalidateMode,
    this.inputFormatters,
    this.suffix,
    this.onFieldSubmitted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: label,
      child: TextFormBox(
          readOnly: readOnly,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          placeholder: placeholder,
          autovalidateMode: autovalidateMode,
          obscureText: obscureText,
          autofocus: autofocus,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          validator: validator,
          inputFormatters: inputFormatters,
          onTap: onTap,
          suffix: suffix,
          onFieldSubmitted: onFieldSubmitted,
          decoration: WidgetStatePropertyAll(
              BoxDecoration(color: readOnly ? const Color(0xFFFCE9F1) : null))),
    );
  }
}

class DoubleFormBox extends StatelessWidget {
  const DoubleFormBox({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.autovalidateMode,
    this.maxDecimalPlaces = 2,
  });
  final String label;
  final TextEditingController? controller;
  final ValueChanged<double>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final int maxDecimalPlaces;

  @override
  Widget build(BuildContext context) {
    final pattern = r'^\d+\.?\d{0,' + maxDecimalPlaces.toString() + r'}';
    return CustomTextFormBox(
      label: label,
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      autovalidateMode: autovalidateMode,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      onChanged: (value) => onChanged?.call(double.tryParse(value) ?? 0.0),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(pattern)),
      ],
    );
  }
}

class IntFormBox extends StatelessWidget {
  const IntFormBox({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.autovalidateMode,
    this.maxDecimalPlaces = 2,
  });
  final String label;
  final TextEditingController? controller;
  final ValueChanged<int>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final int maxDecimalPlaces;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormBox(
      label: label,
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      autovalidateMode: autovalidateMode,
      onChanged: (value) => onChanged?.call(int.tryParse(value) ?? 0),
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("^-?[0-9]+")),
      ],
    );
  }
}
