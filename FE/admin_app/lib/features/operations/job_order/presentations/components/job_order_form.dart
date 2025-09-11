import 'package:admin_app/shared/custom_text_form_box.dart';
import 'package:admin_app/shared/widgets/custom_button.dart';
import 'package:admin_app/shared/widgets/custom_date_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../shared/utils/utils.dart';
import '../../../../../shared/widgets/bp_field_choices.dart';
import '../../../../../shared/widgets/custom_large_dialog.dart';
import '../../../../../shared/widgets/map.dart';
import '../bloc/job_order_bloc.dart';

class JobOrderForm extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onSubmit;
  final JobOrderBloc bloc;
  const JobOrderForm({super.key, this.onSubmit, required this.bloc});

  @override
  State<JobOrderForm> createState() => _JobOrderFormState();
}

class _JobOrderFormState extends State<JobOrderForm> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final _bpNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _remarksController = TextEditingController();
  final _jobDescriptionController = TextEditingController();

  final _pickupAddressController = TextEditingController();
  final _deliveryAddressController = TextEditingController();

  final _jobDate = DateTime.now();

  double? _pickupLat;
  double? _pickupLong;
  double? _deliveryLat;
  double? _deliveryLong;
  final Map<String, dynamic> _formData = {};
  @override
  void dispose() {
    _bpNameController.dispose();
    _remarksController.dispose();
    _contactNumberController.dispose();
    _jobDescriptionController.dispose();
    _pickupAddressController.dispose();
    _deliveryAddressController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobOrderBloc, JobOrderState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is JobOrderPostSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: ContentDialog(
        title: const Text("Job Order Form"),
        actions: [
          CustomButton(
              child: const Text("Close"),
              onPressed: () => Navigator.of(context).pop()),
          CustomFilledButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                widget.onSubmit?.call(_formData);
              }
            },
            child: const Text('Submit'),
          ),
        ],
        content: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CustomDateField(
                labelText: 'Job Date',
                initialDate: _jobDate,
                onStringDateSelected: (val, dateSelected) =>
                    _formData['jobDate'] = dateSelected,
              ),
              Constant.heightSpacer,
              CustomTextFormBox(
                label: 'Customer Name',
                controller: _bpNameController,
                onChanged: (val) => _formData['bpName'] = val,
                onTap: () => showDialog(
                    context: context,
                    builder: (_) {
                      return BusinessPartnerChoices(onSelected: (v) {
                        _bpNameController.text = v.bpName;
                        _contactNumberController.text = v.contactNumber ?? '';
                        _formData['bpName'] = v.bpName;
                        _formData['contactNumber'] = v.contactNumber;
                      });
                    }),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              Constant.heightSpacer,
              CustomTextFormBox(
                label: 'Conctact Number',
                controller: _contactNumberController,
                onChanged: (val) => _formData['contactNumber'] = val,
              ),
              Constant.heightSpacer,
              CustomTextFormBox(
                controller: _pickupAddressController,
                label: "Pickup Address",
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
                            initialLatLang:
                                (_pickupLat != null && _pickupLong != null)
                                    ? LatLng(_pickupLat!, _pickupLong!)
                                    : null,
                            onLocationSelected:
                                (selectedLatLong, selectedAddress) {
                              _pickupAddressController.text =
                                  selectedAddress ?? '';
                              if (selectedLatLong != null) {
                                _pickupLat = selectedLatLong.latitude;
                                _pickupLong = selectedLatLong.longitude;
                                _formData["pickupLat"] =
                                    selectedLatLong.latitude;
                                _formData["pickupLong"] =
                                    selectedLatLong.longitude;
                                _formData["pickupAddress"] = selectedAddress;
                              }
                            },
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Constant.heightSpacer,
              CustomTextFormBox(
                controller: _deliveryAddressController,
                label: "Drop-off Address",
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
                            initialLatLang:
                                (_deliveryLat != null && _deliveryLong != null)
                                    ? LatLng(_deliveryLat!, _deliveryLong!)
                                    : null,
                            onLocationSelected:
                                (selectedLatLong, selectedAddress) {
                              if (selectedLatLong != null) {
                                _deliveryLat = selectedLatLong.latitude;
                                _deliveryLong = selectedLatLong.longitude;
                                _formData["deliveryLat"] =
                                    selectedLatLong.latitude;
                                _formData["deliveryLong"] =
                                    selectedLatLong.longitude;
                                _formData["deliveryAddress"] = selectedAddress;
                              }
                            },
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Constant.heightSpacer,
              CustomTextFormBox(
                label: 'Remarks',
                onChanged: (val) => _formData['remarks'] = val,
              ),
              Constant.heightSpacer,
              CustomTextFormBox(
                label: 'Job Description',
                controller: _jobDescriptionController,
                onChanged: (val) => _formData['jobDescription'] = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
                minLines: 3,
                maxLines: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
