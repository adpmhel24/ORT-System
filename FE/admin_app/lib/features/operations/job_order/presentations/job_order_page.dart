import 'package:admin_app/features/operations/job_order/presentations/components/list_of_job_orders.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../shared/global_variable.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../data/models/job_order_model.dart';
import 'bloc/job_order_bloc.dart';
import 'components/job_order_form.dart';

class JobOrderPage extends StatefulWidget {
  const JobOrderPage({super.key});
  static const routeName = "job-order";
  static const routePath = '/operations/job-order';
  @override
  State<JobOrderPage> createState() => _JobOrderPageState();
}

class _JobOrderPageState extends State<JobOrderPage> {
  void formDialog(BuildContext context, [JobOrderModel? data]) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<JobOrderBloc>(),
          child: JobOrderForm(
            bloc: context.read<JobOrderBloc>(),
            onSubmit: (v) {
              CustomDialogBox.warningMessage(context,
                  message: "Are you sure you want to proceed?",
                  onPositiveClick: (_) {
                context.read<JobOrderBloc>().add(
                      CreateJobOrderEvent(v),
                    );
              });
            },
          ),
        );
      },
    );
  }

  void fetchData(JobOrderBloc bloc) {
    bloc.add(const GetAllJobOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<JobOrderBloc>()..add(const GetAllJobOrdersEvent()),
      child: BlocListener<JobOrderBloc, JobOrderState>(
        listener: (context, state) {
          if (state is JobOrderLoading) {
            context.loaderOverlay.show();
          } else if (state is JobOrderFailure) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state is JobOrderListSuccess) {
            context.loaderOverlay.hide();
          } else if (state is JobOrderPostSuccess) {
            context.loaderOverlay.hide();
            context.read<JobOrderBloc>().add(const GetAllJobOrdersEvent());
          }
        },
        child: ScaffoldPage.withPadding(
          header: const PageHeader(
            title: Text("Job Order"),
          ),
          content: Builder(builder: (context) {
            return Column(
              children: [
                _buildCommandBar(context),
                Constant.heightSpacer,
                Expanded(
                  child: ListOfJobOrders(
                    onSelection: (v) {
                      // formDialog.call(context, v);
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
              fetchData(context.read<JobOrderBloc>());
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
