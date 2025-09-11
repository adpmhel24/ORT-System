import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../shared/global_variable.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../data/models/vehicle_model.dart';
import 'bloc/vehicle_bloc.dart';
import 'components/list_of_vehicle.dart';
import 'components/vehicle_form.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});
  static const routeName = "vehicle";
  static const routePath = '/masterdata/vehicle';
  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  void vehicleDialog(BuildContext context, [VehicleModel? vehicle]) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<VehicleBloc>(),
          child: VehicleForm(
            existingVehicle: vehicle,
            onSubmit: (v) {
              context.read<VehicleBloc>().add(
                  // vehicle == null
                  //     ? PostVehicleEvent(v)
                  //     : UpdateVehicleEvent(v, vehicle.id!),
                  PostVehicleEvent(v));
            },
          ),
        );
      },
    );
  }

  void fetchData(VehicleBloc bloc) {
    bloc.add(const GetAllVehiclesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<VehicleBloc>()..add(const GetAllVehiclesEvent()),
      child: BlocListener<VehicleBloc, VehicleState>(
        listener: (context, state) {
          if (state is VehicleLoadingState) {
            context.loaderOverlay.show();
          } else if (state is VehicleErrorState) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state is VehiclesLoadedState) {
            context.loaderOverlay.hide();
          } else if (state is VehiclePostedSuccess) {
            context.loaderOverlay.hide();
            context.read<VehicleBloc>().add(const GetAllVehiclesEvent());
          }
        },
        child: ScaffoldPage.withPadding(
          header: const PageHeader(
            title: Text("Vehicles"),
          ),
          content: SingleChildScrollView(
            child: Builder(builder: (context) {
              return Column(
                children: [
                  _buildCommandBar(context),
                  Constant.heightSpacer,
                  ListOfVehicles(
                    onSelection: (v) {
                      vehicleDialog.call(context, v);
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  CommandBar _buildCommandBar(BuildContext context) {
    return CommandBar(
      primaryItems: [
        CommandBarBuilderItem(
          builder: (_, mode, w) => Tooltip(
            message: "Search",
            child: w,
          ),
          wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.search),
            label: const Text('Search'),
            onPressed: () {
              // _fetchData();
            },
          ),
        ),
        CommandBarBuilderItem(
          builder: (_, mode, w) => Tooltip(
            message: "Refresh.",
            child: w,
          ),
          wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.refresh),
            label: const Text('Refresh'),
            onPressed: () {
              fetchData(context.read<VehicleBloc>());
            },
          ),
        ),
        CommandBarBuilderItem(
          builder: (_, mode, w) => Tooltip(
            message: "Add New.",
            child: w,
          ),
          wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.add),
            label: const Text('Add New'),
            onPressed: () {
              vehicleDialog(context);
            },
          ),
        ),
      ],
    );
  }

  // Flexible _buildLeftFiltering() {
  //   return Flexible(
  //     child: Wrap(
  //       runSpacing: 10.0,
  //       spacing: 10.0,
  //       children: [
  //         CustomDateField(
  //           labelText: "Start date",
  //           initialDate: startDate,
  //           onStringDateSelected: (_, v) => {startDate = v, _fetchData()},
  //         ),
  //         CustomDateField(
  //           labelText: "End date",
  //           initialDate: endDate,
  //           onStringDateSelected: (_, v) => {endDate = v, _fetchData()},
  //         ),
  //         InfoLabel(
  //           label: "Document Status",
  //           child: ComboBox(
  //             placeholder: const Text("Document Status"),
  //             value: docstatus,
  //             items: listOfStatus,
  //             onChanged: (v) {
  //               setState(() {
  //                 docstatus = v;
  //               });
  //               _fetchData();
  //             },
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
