import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

import '../utils/utils.dart';
import 'custom_date_picker.dart';

class CustomDateField extends StatefulWidget {
  final String labelText;
  final Function(String, DateTime?)? onStringDateSelected;
  final double width;
  final DateTime? initialDate;
  final bool closeButtonVisibility;

  const CustomDateField({
    super.key,
    required this.labelText,
    Widget? suffixIcon,
    this.onStringDateSelected,
    this.width = 200,
    this.initialDate,
    this.closeButtonVisibility = true,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialDate != null) {
      controller.text = DateFormat("MM/dd/yyyy")
          .format(DateTime.parse(widget.initialDate.toString()));
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }

  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: InfoLabel(
        label: widget.labelText,
        child: StatefulBuilder(
          builder: (context, setState) {
            return TextBox(
              controller: controller,
              readOnly: true,
              suffix: widget.closeButtonVisibility
                  ? IconButton(
                      icon: const Icon(FluentIcons.clear),
                      onPressed: controller.text.isNotEmpty
                          ? () {
                              setState(() {
                                controller.clear();
                                selectedDate = null;
                                widget.onStringDateSelected
                                    ?.call(controller.text, selectedDate);
                              });
                            }
                          : null,
                    )
                  : null,
              onTap: () {
                CustomDatePicker.singleDatePicker(
                  context,
                  initialSelectedDate: widget.initialDate ?? DateTime.now(),
                  onSubmit: (value) {
                    setState(() {
                      controller.text =
                          Utils.formatDate(DateTime.tryParse(value.toString()));
                      selectedDate = DateTime.tryParse(value.toString());
                    });
                    widget.onStringDateSelected
                        ?.call(controller.text, selectedDate);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
