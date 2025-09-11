import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

import '../utils/utils.dart';

class LargeDialog extends StatelessWidget {
  const LargeDialog({
    super.key,
    required this.child,
    this.constraints,
  });
  final Widget child;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints:
            constraints ?? const BoxConstraints(maxWidth: 1100, maxHeight: 600),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              right: 0,
              bottom: 0,
              left: 0,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Constant.modalBackground,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromARGB(255, 54, 52, 52),
                          blurRadius: 0.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ]),
                  child: child),
            ),
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(material.Icons.close, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
