import 'package:admin_app/shared/string_ext.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../shared/models/column_model.dart';
import '../../../../../shared/widgets/non_paginated_sfds.dart';
import '../../data/models/vehicle_model.dart';
import '../bloc/vehicle_bloc.dart';

class ListOfVehicles extends StatefulWidget {
  const ListOfVehicles({super.key, this.onSelection});

  final Function(VehicleModel)? onSelection;

  @override
  State<ListOfVehicles> createState() => _ListOfVehiclesState();
}

class _ListOfVehiclesState extends State<ListOfVehicles> {
  static final _tblColumns = VehicleModel.headers
      .map(
        (e) => ColumnModel(
          colName: e.toSpacedTitleCase(),
          mapName: e,
          width: double.nan,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, List<VehicleModel>>(
      selector: (state) => state is VehiclesLoadedState ? state.datas : [],
      builder: (context, datas) {
        final dataSource = NonPaginationationDataGridSource(
          dataGridRows: datas.asMap().entries.map((data) {
            final int index = data.key; // get the index
            var value = data.value; //get the value
            return _buildDataGrid(
              context,
              index,
              value.toMap(),
            );
          }).toList(),
        );
        return Card(
          child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: dataSource,
            allowMultiColumnSorting: true,
            selectionMode: SelectionMode.single,
            navigationMode: GridNavigationMode.cell,
            allowColumnsResizing: true,
            isScrollbarAlwaysShown: true,
            allowFiltering: true,
            onQueryRowHeight: (details) {
              return details.getIntrinsicRowHeight(details.rowIndex);
            },
            onCellTap: (DataGridCellTapDetails details) {
              if (details.rowColumnIndex.rowIndex == 0) {
                return;
              } else {
                final rowIndex = details.rowColumnIndex.rowIndex -
                    1; // -1 because row 0 is header
                widget.onSelection?.call(datas[rowIndex]);
              }
            },
            onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
              var column = _tblColumns
                  .firstWhere((e) => e.colName == details.column.columnName);
              setState(
                () {
                  column.width = details.width;
                },
              );

              return true;
            },
            columns: _tblColumns.map(
              (e) {
                return GridColumn(
                  allowEditing: false,
                  width: e.width,
                  columnName: e.colName,
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e.colName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ).toList(),
            columnWidthMode: ColumnWidthMode.auto,
          ),
        );
      },
    );
  }

  DataGridRow _buildDataGrid(
      BuildContext context, int index, Map<String, dynamic> data) {
    return DataGridRow(
      cells: _tblColumns.map(
        (e) {
          if (e.mapName == "driverName") {
            return DataGridCell(columnName: e.colName, value: data[e.mapName]);
          }
          return DataGridCell(
            columnName: e.colName,
            value: data[e.mapName],
          );
        },
      ).toList(),
    );
  }
}
