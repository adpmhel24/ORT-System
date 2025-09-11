import 'package:admin_app/shared/string_ext.dart';
import 'package:admin_app/shared/widgets/custom_button.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/custom_text_form_box.dart';
import '../../../../../shared/utils/utils.dart';
import '../../data/models/vehicle_enum.dart';
import '../../data/models/vehicle_model.dart';
import '../bloc/vehicle_bloc.dart';

class VehicleForm extends StatefulWidget {
  final void Function(Map<String, String> values)? onSubmit;
  final VehicleModel? existingVehicle;

  const VehicleForm({super.key, this.onSubmit, this.existingVehicle});

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'plateNumber': TextEditingController(),
    'yearModel': TextEditingController(),
    'maker': TextEditingController(),
    'category': TextEditingController(),
    'orNumber': TextEditingController(),
    'crNumber': TextEditingController(),
    'fuelLevel': TextEditingController(),
    'currentMileage': TextEditingController(),
    'minDiesel': TextEditingController(),
    'withLoadConsumption': TextEditingController(),
    'withoutLoadConsumption': TextEditingController(),
  };
  VehicleStatusEnum? statusValue;
  final requiredFields = [
    'plateNumber',
    'yearModel',
    'maker',
    'category',
    'orNumber',
    'crNumber',
    'fuelLevel',
    'currentMileage',
    'minDiesel',
    'withLoadConsumption',
    'withoutLoadConsumption',
  ];
  @override
  void initState() {
    if (widget.existingVehicle != null) {
      _assignVehicleValues(widget.existingVehicle!);
    }
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _assignVehicleValues(VehicleModel vehicle) {
    _controllers['plateNumber']?.text = vehicle.plateNumber ?? '';
    _controllers['yearModel']?.text = vehicle.yearModel?.toString() ?? '';
    _controllers['maker']?.text = vehicle.maker ?? '';
    _controllers['category']?.text = vehicle.category ?? '';
    _controllers['orNumber']?.text = vehicle.orNumber ?? '';
    _controllers['crNumber']?.text = vehicle.crNumber ?? '';
    _controllers['fuelLevel']?.text = vehicle.fuelLevel?.toString() ?? '';
    _controllers['currentMileage']?.text =
        vehicle.currentMileage?.toString() ?? '';
    _controllers['minDiesel']?.text = vehicle.minDiesel?.toString() ?? '';
    _controllers['withLoadConsumption']?.text =
        vehicle.withLoadConsumption?.toString() ?? '';
    _controllers['withoutLoadConsumption']?.text =
        vehicle.withoutLoadConsumption?.toString() ?? '';
    statusValue = VehicleStatusEnum.values.byName(vehicle.status!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleBloc, VehicleState>(
      listener: (context, state) {
        if (state is VehiclePostedSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: ContentDialog(
        title: const Text("Vehicle Form"),
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
                final values = {
                  for (final entry in _controllers.entries)
                    entry.key: entry.value.text,
                };
                values['status'] =
                    statusValue?.name ?? VehicleStatusEnum.available.name;
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
                ..._controllers.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextFormBox(
                        label: entry.key.toSpacedTitleCase(),
                        controller: entry.value,
                        autovalidateMode: (requiredFields.contains(entry.key))
                            ? AutovalidateMode.onUserInteraction
                            : null,
                        validator: (value) {
                          if (requiredFields.contains(entry.key)) {
                            return (value == null || value.isEmpty)
                                ? 'Required'
                                : null;
                          }
                          return null;
                        }),
                  ),
                ),
                Constant.heightSpacer,
                VehicleStatusDropdown(
                  value: statusValue,
                  onChanged: (v) {
                    statusValue = v;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VehicleStatusDropdown extends StatelessWidget {
  final VehicleStatusEnum? value;
  final void Function(VehicleStatusEnum?) onChanged;

  const VehicleStatusDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: "Status",
      child: ComboboxFormField<VehicleStatusEnum>(
        value: value,
        items: VehicleStatusEnum.values.map((role) {
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
