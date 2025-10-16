import 'package:admin_app/features/master_data/employee_position/data/models/employee_position_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/custom_text_form_box.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../bloc/empl_position_bloc.dart';

class EmployeePositionForm extends StatefulWidget {
  final void Function(Map<String, dynamic> values)? onSubmit;
  final EmployeePositionModel? initialValues;

  const EmployeePositionForm({super.key, this.onSubmit, this.initialValues});

  @override
  State<EmployeePositionForm> createState() => _EmployeePositionFormState();
}

class _EmployeePositionFormState extends State<EmployeePositionForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'code': TextEditingController(),
    'description': TextEditingController(),
  };
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    final values = widget.initialValues?.toMap();
    if (values != null) {
      _controllers['code']?.text = values['code'] ?? '';
      _controllers['description']?.text = values['description'] ?? '';
      isActive = values['isActive'] ?? true;
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmplPositionBloc, EmplPositionState>(
      listener: (context, state) {
        if (state is PostEmplPositionSuccessState) {
          Navigator.of(context).pop();
        }
      },
      child: ContentDialog(
        title: const Text("Employee Position Form"),
        actions: [
          CustomButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CustomFilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final Map<String, dynamic> values = {
                  for (final entry in _controllers.entries)
                    entry.key: entry.value.text,
                };
                values['isActive'] = isActive;
                print(values);
                widget.onSubmit?.call(values);
              }
            },
            child: const Text('Submit'),
          ),
        ],
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormBox(
                    controller: _controllers['code']!,
                    label: "Position Code",
                    isRequired: true),
                _buildTextFormBox(
                    controller: _controllers['description']!,
                    label: "Description",
                    isRequired: false),
                InfoLabel(
                  label: "Status",
                  child: ToggleSwitch(
                    checked: isActive,
                    onChanged: (value) {
                      setState(() {
                        isActive = value;
                      });
                    },
                    content: Text(isActive ? "Active" : "Inactive"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormBox({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomTextFormBox(
        label: label,
        controller: controller,
        autovalidateMode:
            isRequired ? AutovalidateMode.onUserInteraction : null,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Required';
          }
          return null;
        },
      ),
    );
  }
}
