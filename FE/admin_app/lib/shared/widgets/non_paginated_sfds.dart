import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/utils.dart';

class NonPaginationationDataGridSource extends DataGridSource {
  List<DataGridRow> dataGridRows;
  final void Function()? onRefresh;

  NonPaginationationDataGridSource(
      {this.dataGridRows = const [], this.onRefresh});

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateDataGridMainDataSource() {
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    onRefresh?.call();
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    if (summaryColumn?.columnName == null) {
      return Container(
        padding: const EdgeInsets.all(15.0),
        alignment: Alignment.centerRight,
        child: Text(summaryValue),
      );
    }
    double tempValue = (double.tryParse(summaryValue) ?? 0);
    tempValue = tempValue < 0 ? tempValue * -1 : tempValue;
    double value = double.parse(tempValue.toStringAsFixed(2));
    return Container(
      padding: const EdgeInsets.all(15.0),
      alignment: Alignment.centerRight,
      child: Text(Utils.formatAmount(value)),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Container(
            alignment: dataGridCell.value.runtimeType == double ||
                    dataGridCell.value.runtimeType == int
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding: const EdgeInsets.all(5.0),
            child: dataGridCell.value.runtimeType == String
                ? (dataGridCell.value.isNotEmpty
                    ? Text(dataGridCell.value.toString())
                    : null)
                : dataGridCell.value.runtimeType == double
                    ? Text(Utils.formatAmount(dataGridCell.value))
                    : dataGridCell.value.runtimeType == DateTime
                        ? Text(Utils.formatDate(dataGridCell.value))
                        : dataGridCell.value.runtimeType == int
                            ? Text("${dataGridCell.value}")
                            : dataGridCell.value.runtimeType == bool
                                ? Icon(dataGridCell.value
                                    ? FluentIcons.checkbox_composite
                                    : FluentIcons.checkbox)
                                : dataGridCell.value,
          );
        },
      ).toList(),
    );
  }
}
