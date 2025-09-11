import 'package:admin_app/features/master_data/business_partner/data/models/bp_model.dart';
import 'package:admin_app/features/master_data/business_partner/presentations/components/bp_form.dart';
import 'package:admin_app/features/master_data/business_partner/presentations/components/list_of_bps.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../shared/global_variable.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../data/models/employee_position_model.dart';
import 'bloc/empl_position_bloc.dart';

class EmployeePositionPage extends StatefulWidget {
  const EmployeePositionPage({super.key});
  static const routeName = "employee-position";
  static const routePath = '/masterdata/employee-position';
  @override
  State<EmployeePositionPage> createState() => _EmployeePositionPageState();
}

class _EmployeePositionPageState extends State<EmployeePositionPage> {
  void formDialog(BuildContext context, [EmployeePositionModel? data]) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<EmplPositionBloc>(),
          child: EmployeePositionForm(
            initialValues: data,
            onSubmit: (v) {
              context.read<EmplPositionBloc>().add(
                  // vehicle == null
                  //     ? PostVehicleEvent(v)
                  //     : UpdateVehicleEvent(v, vehicle.id!),
                  PostBpEvent(v));
            },
          ),
        );
      },
    );
  }

  void fetchData(EmplPositionBloc bloc) {
    bloc.add(const FetchAllEmplPositionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<EmplPositionBloc>()..add(const FetchAllEmplPositionEvent()),
      child: BlocListener<EmplPositionBloc, EmplPositionState>(
        listener: (context, state) {
          if (state is EmployeePositionLoadingState) {
            context.loaderOverlay.show();
          } else if (state is EmployeePositionErrorState) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state is EmployeePositionsLoadedState) {
            context.loaderOverlay.hide();
          } else if (state is PostEmplPositionSuccessState) {
            context.loaderOverlay.hide();
            context
                .read<EmplPositionBloc>()
                .add(const FetchAllEmplPositionEvent());
          }
        },
        child: ScaffoldPage.withPadding(
          header: const PageHeader(
            title: Text("Employee Positions"),
          ),
          content: Builder(builder: (context) {
            return Column(
              children: [
                _buildCommandBar(context),
                Constant.heightSpacer,
                Expanded(
                  child: ListOfBps(
                    onSelection: (v) {
                      formDialog.call(context, v);
                    },
                  ),
                ),
              ],
            );
          }),
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
              fetchData(context.read<EmplPositionBloc>());
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
              formDialog(context);
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
