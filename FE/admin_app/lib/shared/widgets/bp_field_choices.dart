import 'package:admin_app/shared/widgets/custom_button.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../core/usecases/usecase.dart';
import '../../features/master_data/business_partner/data/models/bp_model.dart';
import '../../features/master_data/business_partner/domain/usecases/get_all_bp.dart';
import '../global_variable.dart';
import '../utils/utils.dart';
import 'custom_search_field.dart';

class BusinessPartnerChoices extends StatefulWidget {
  const BusinessPartnerChoices({super.key, this.onSelected});

  final ValueChanged<BusinessPartnerModel>? onSelected;

  @override
  State<BusinessPartnerChoices> createState() => _BusinessPartnerChoicesState();
}

class _BusinessPartnerChoicesState extends State<BusinessPartnerChoices> {
  final ValueNotifier<List<BusinessPartnerModel>> _itemsNotefier =
      ValueNotifier([]);
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _itemsNotefier.dispose();
    super.dispose();
  }

  void fetchData([String? keyword]) async {
    final result =
        await getIt<GetAllBpUC>().call(QueryParams({"keyword": keyword ?? ""}));
    if (result.isRight()) {
      _itemsNotefier.value = result.getOrElse(() => []);
    } else {
      _itemsNotefier.value = [];
    }
  }

  BusinessPartnerModel? selectedItem;
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      actions: [
        CustomButton(
            child: const Text("Close"),
            onPressed: () => Navigator.of(context).pop()),
        CustomFilledButton(
          child: const Text("OK"),
          onPressed: () {
            if (selectedItem != null) {
              widget.onSelected?.call(selectedItem!);
              Navigator.of(context).pop();
            }
          },
        )
      ],
      content: Column(
        children: [
          CustomSearchField(
            onChanged: (value) => fetchData(value),
            onSubmit: (value) => fetchData(value),
          ),
          Constant.heightSpacer,
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: _itemsNotefier,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final item = _itemsNotefier.value[index];
                      return ListTile.selectable(
                        selected: selectedItem?.id == item.id,
                        title: Text(item.bpName),
                        subtitle: Text(item.contactNumber ?? ''),
                        onPressed: () {
                          setState(() {
                            selectedItem = item;
                          });
                        },
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
