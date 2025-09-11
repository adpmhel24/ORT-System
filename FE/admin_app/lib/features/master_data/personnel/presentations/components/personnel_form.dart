import 'package:admin_app/shared/string_ext.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/custom_text_form_box.dart';
import '../../../../../shared/utils/utils.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../../data/models/personnel_model.dart';
import '../../domain/enum/personnel_role_enum.dart';
import '../bloc/personnel_bloc.dart';

class PersonnelForm extends StatefulWidget {
  const PersonnelForm({super.key, this.existingPersonnel});
  final PersonnelModel? existingPersonnel;

  @override
  State<PersonnelForm> createState() => _PersonnelFormState();
}

class _PersonnelFormState extends State<PersonnelForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameContr = TextEditingController();
  final _driverLicenseContr = TextEditingController();

  bool isActive = true;
  PersonnelRoleEnum? roleValue;
  @override
  void initState() {
    super.initState();
    // widget.personnelNotifier.addListener(_updateFormFields);
    if (widget.existingPersonnel != null) {
      _updateFormFields(); // Load initial value if available
    }
  }

  void _updateFormFields() {
    final personnel = widget.existingPersonnel;

    if (personnel == null) {
      _fullNameContr.clear();
      _driverLicenseContr.clear();
      roleValue = null;
      isActive = true;
    } else {
      _fullNameContr.text = personnel.fullName ?? '';
      _driverLicenseContr.text = personnel.licenseNumber ?? '';
      roleValue = personnel.role != null
          ? PersonnelRoleEnum.values.byName(personnel.role!)
          : null;
      isActive = personnel.isActive ?? true;
    }

    // Must trigger setState to update the form
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonnelBloc, PersonnelState>(
      listener: (context, state) {
        if (state is PersonnelsPostedSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: ContentDialog(
        title: const Text("Personnel Form"),
        actions: [
          CustomButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CustomFilledButton(
            child: Text(widget.existingPersonnel != null ? "Update" : "Add"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                CustomDialogBox.warningMessage(
                  context,
                  onPositiveClick: (_) {
                    if (widget.existingPersonnel == null) {
                      context.read<PersonnelBloc>().add(
                            PostPersonnel(
                              {
                                "fullName": _fullNameContr.text.trim(),
                                "licenseNumber":
                                    _driverLicenseContr.text.trim(),
                                "role": roleValue!.name,
                                "isActive": isActive,
                              },
                            ),
                          );
                    }
                  },
                );
              }
            },
          )
        ],
        content: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormBox(
                  label: "Personnel Name *",
                  controller: _fullNameContr,
                  validator: (v) =>
                      _fullNameContr.text.isEmpty ? "Required field." : null,
                ),
                Constant.heightSpacer,
                CustomTextFormBox(
                  label: "License #",
                  controller: _driverLicenseContr,
                ),
                Constant.heightSpacer,
                RoleDropdown(
                  value: roleValue,
                  onChanged: (v) {
                    roleValue = v;
                  },
                ),
                Constant.heightSpacer,
                Checkbox(
                    checked: isActive,
                    content: const Text("Active"),
                    onChanged: (v) {
                      setState(() {
                        isActive = !isActive;
                      });
                    }),
              ],
            )),
      ),
    );
  }
}

class RoleDropdown extends StatelessWidget {
  final PersonnelRoleEnum? value;
  final void Function(PersonnelRoleEnum?) onChanged;

  const RoleDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: "Role",
      child: ComboboxFormField<PersonnelRoleEnum>(
        value: value,
        items: PersonnelRoleEnum.values.map((role) {
          return ComboBoxItem(
            value: role,
            child: Text(role.name.capitalize()),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (text) {
          if (text == null) {
            return 'Please provide a value';
          }

          return null;
        },
      ),
    );
  }
}
