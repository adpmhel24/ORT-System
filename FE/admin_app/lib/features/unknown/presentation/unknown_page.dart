import 'package:fluent_ui/fluent_ui.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(title: Text('404')),
      content: Center(
        child: Text('Page not found'),
      ),
    );
  }
}
