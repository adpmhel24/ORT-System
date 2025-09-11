import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../shared/global_variable.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../data/models/personnel_model.dart';
import 'bloc/personnel_bloc.dart';
import 'components/personnel_form.dart';
import 'components/list_of_personnel.dart';

class PersonnelPage extends StatefulWidget {
  const PersonnelPage({super.key});
  static const routeName = "personnel";
  static const routePath = '/masterdata/personnel';
  @override
  State<PersonnelPage> createState() => _PersonnelPageState();
}

class _PersonnelPageState extends State<PersonnelPage> {
  Future<void> showSnackbar(BuildContext context, String message) {
    return displayInfoBar(
      context,
      builder: (context, close) => InfoBar(
        title: RichText(
          text: TextSpan(
            text: 'Message: ',
            style: const TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: message,
                style: TextStyle(
                  color: FluentTheme.of(context).accentColor.defaultBrushFor(
                        FluentTheme.of(context).brightness,
                      ),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void personnelDialog(BuildContext context, [PersonnelModel? personnel]) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<PersonnelBloc>(),
          child: PersonnelForm(
            existingPersonnel: personnel,
          ),
        );
      },
    );
  }

  void fetchData(PersonnelBloc bloc) {
    bloc.add(const GetAllPersonnels());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PersonnelBloc>()..add(const GetAllPersonnels()),
      child: BlocListener<PersonnelBloc, PersonnelState>(
        listener: (context, state) {
          if (state is PersonnelLoadingState) {
            context.loaderOverlay.show();
          } else if (state is PersonnelErrorState) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state is PersonnelsLoadedState) {
            context.loaderOverlay.hide();
          } else if (state is PersonnelsPostedSuccess) {
            context.loaderOverlay.hide();
            context.read<PersonnelBloc>().add(const GetAllPersonnels());
          }
        },
        child: ScaffoldPage.withPadding(
          header: const PageHeader(
            title: Text("Personnels"),
          ),
          content: SingleChildScrollView(
            child: Builder(builder: (context) {
              return Column(
                children: [
                  _buildCommandBar(context),
                  Constant.heightSpacer,
                  ListOfPersonnels(
                    onSelection: (v) {
                      personnelDialog.call(context, v);
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
              fetchData(context.read<PersonnelBloc>());
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
              personnelDialog(context);
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
