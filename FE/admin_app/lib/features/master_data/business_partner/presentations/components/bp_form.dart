import 'package:admin_app/features/master_data/business_partner/data/models/bp_model.dart';
import 'package:admin_app/shared/string_ext.dart';
import 'package:admin_app/shared/widgets/custom_large_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../shared/custom_text_form_box.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/map.dart';
import '../../domain/enum/bp_type_enum.dart';
import '../bloc/bp_bloc.dart';

class BusinessPartnerForm extends StatefulWidget {
  final void Function(Map<String, dynamic> values)? onSubmit;
  final BusinessPartnerModel? initialValues;

  const BusinessPartnerForm({super.key, this.onSubmit, this.initialValues});

  @override
  State<BusinessPartnerForm> createState() => _BusinessPartnerFormState();
}

class _BusinessPartnerFormState extends State<BusinessPartnerForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'bpName': TextEditingController(),
    'contactPerson': TextEditingController(),
    'bpType': TextEditingController(),
    'contactNumber': TextEditingController(),
    'address': TextEditingController(),
  };
  bool isActive = true;

  final requiredFields = [
    'bpName',
    'bpType',
  ];

  double? lat;
  double? long;

  BusinessTypeEnum? bpTypeValue;

  @override
  void initState() {
    super.initState();
    final values = widget.initialValues?.toMap();
    if (values != null) {
      _controllers['bpName']?.text = values['bpName'] ?? '';
      _controllers['contactPerson']?.text = values['contactPerson'] ?? '';
      _controllers['bpType']?.text = values['bpType'] ?? '';
      _controllers['address']?.text = values['address'] ?? '';
      _controllers['contactNumber']?.text = values['contactNumber'] ?? '';
      bpTypeValue = BusinessTypeEnum.values.byName(values['bpType']);
      lat = values['lat'];
      long = values['long'];
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
    return BlocListener<BpBloc, BpState>(
      listener: (context, state) {
        if (state is PostBpSuccessState) {
          Navigator.of(context).pop();
        }
      },
      child: ContentDialog(
        title: const Text("Bp Form"),
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
                values['lat'] = lat;
                values['long'] = long;
                values['isActive'] = isActive;
                values['bpType'] = bpTypeValue?.name;
                if (widget.onSubmit != null) {
                  widget.onSubmit!(values);
                }
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
                    controller: _controllers['bpName']!,
                    label: "Business Partner Name",
                    isRequired: true),
                _buildTextFormBox(
                    controller: _controllers['contactPerson']!,
                    label: "Contact Person",
                    isRequired: true),
                _buildTextFormBox(
                    controller: _controllers['contactNumber']!,
                    label: "Contact Number"),
                Row(
                  children: [
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
                    const Spacer(),
                    EnumDropdown<BusinessTypeEnum>(
                      label: "BP Type",
                      value: bpTypeValue,
                      items: BusinessTypeEnum.values
                          .map((e) => ComboBoxItem<BusinessTypeEnum>(
                                value: e,
                                child: Text(e.name.capitalize()),
                              ))
                          .toList(),
                      onChanged: (v) {
                        bpTypeValue = v;
                      },
                    ),
                  ],
                ),
                CustomTextFormBox(
                  controller: _controllers['address']!,
                  label: "Address",
                  minLines: 2,
                  maxLines: 4,
                  suffix: IconButton(
                    icon: const Icon(FluentIcons.map_directions),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            LayoutBuilder(builder: (context, constraints) {
                          return LargeDialog(
                            constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight,
                                maxWidth: constraints.maxWidth),
                            child: DesktopMapPage(
                              initialLatLang: (lat != null && long != null)
                                  ? LatLng(lat!, long!)
                                  : null,
                              onLocationSelected:
                                  (selectedLatLong, selectedAddress) {
                                setState(() {
                                  _controllers['address']?.text =
                                      selectedAddress ?? '';
                                  if (selectedLatLong != null) {
                                    lat = selectedLatLong.latitude;
                                    long = selectedLatLong.longitude;
                                  }
                                });
                              },
                            ),
                          );
                        }),
                      );
                    },
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

class EnumDropdown<T extends Enum> extends StatelessWidget {
  final T? value;
  final void Function(T?) onChanged;
  final String label;
  final List<ComboBoxItem<T>>? items;

  const EnumDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: label,
      child: ComboboxFormField<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        validator: (selected) =>
            selected == null ? 'Please provide a value' : null,
      ),
    );
  }
}
