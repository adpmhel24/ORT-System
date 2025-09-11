import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../shared/models/column_model.dart';
import '../../../../../shared/widgets/non_paginated_sfds.dart';
import '../../data/models/job_order_model.dart';
import '../bloc/job_order_bloc.dart';

class ListOfJobOrders extends StatefulWidget {
  const ListOfJobOrders({super.key, this.onSelection});

  final Function(JobOrderModel)? onSelection;

  @override
  State<ListOfJobOrders> createState() => _ListOfJobOrdersState();
}

class _ListOfJobOrdersState extends State<ListOfJobOrders> {
  static final _tblColumns = JobOrderModel.headers
      .map(
        (e) => ColumnModel(
          colName: e,
          mapName: e,
          width: double.nan,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<JobOrderBloc, JobOrderState, List<JobOrderModel>>(
      selector: (state) => state is JobOrderListSuccess ? state.orders : [],
      builder: (context, datas) {
        final dataSource = NonPaginationationDataGridSource(
          dataGridRows: datas.asMap().entries.map((data) {
            final int index = data.key;
            var value = data.value;
            return _buildDataGrid(context, index, value.toMap());
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
                final rowIndex = details.rowColumnIndex.rowIndex - 1;
                widget.onSelection?.call(datas[rowIndex]);
              }
            },
            onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
              var column = _tblColumns
                  .firstWhere((e) => e.colName == details.column.columnName);
              setState(() {
                column.width = details.width;
              });
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
      cells: _tblColumns
          .map(
            (e) => DataGridCell(
              columnName: e.colName,
              value: data[e.mapName],
            ),
          )
          .toList(),
    );
  }
}
