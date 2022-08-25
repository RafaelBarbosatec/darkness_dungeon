import 'package:flutter/material.dart';

class DefectorRadio<T> extends StatelessWidget {
  final T value;
  final T? group;
  final String? label;
  final ValueChanged<T>? onChange;

  const DefectorRadio(
      {Key? key, required this.value, this.group, this.label, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange?.call(value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.all(2),
              color: value == group ? Colors.white : Colors.transparent,
            ),
          ),
          if (label != null) ...[
            SizedBox(
              width: 10,
            ),
            Text(
              label!,
              style: TextStyle(color: Colors.white),
            ),
          ]
        ],
      ),
    );
  }
}