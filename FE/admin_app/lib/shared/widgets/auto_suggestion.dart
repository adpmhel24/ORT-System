import 'package:fluent_ui/fluent_ui.dart';

class CustomAutoSuggestionBox<T> extends StatefulWidget {
  final List<T> items;
  final void Function(T)? onSelected;
  final String label;
  final bool isHeader;

  const CustomAutoSuggestionBox({
    super.key,
    required this.items,
    required this.label,
    this.isHeader = true,
    this.onSelected,
  });

  @override
  State<CustomAutoSuggestionBox<T>> createState() =>
      _CustomAutoSuggestionBoxState<T>();
}

class _CustomAutoSuggestionBoxState<T>
    extends State<CustomAutoSuggestionBox<T>> {
  final FocusNode _focusNode = FocusNode();
  final asgbKey = GlobalKey<AutoSuggestBoxState>(
    debugLabel: 'Manually controlled AutoSuggestBox',
  );

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        asgbKey.currentState?.showOverlay();
      } else {
        asgbKey.currentState?.dismissOverlay();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: widget.label,
      isHeader: widget.isHeader,
      child: AutoSuggestBox<T>(
        key: asgbKey,
        focusNode: _focusNode,
        items: widget.items
            .map((e) => AutoSuggestBoxItem<T>(value: e, label: e.toString()))
            .toList(),
        onSelected: (item) => widget.onSelected?.call(item.value as T),
      ),
    );
  }
}
