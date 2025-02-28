import 'package:flutter/material.dart';
import 'package:sensor_tree/Classes/Utils/resources/resources.dart';

class CustomCheckBox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final String label;
  final Color activeColor;

  const CustomCheckBox({
    super.key,
    this.initialValue = false,
    required this.onChanged,
    required this.label,
    this.activeColor = Colors.blue,
  });

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue; // Set initial value
  }

  void _toggleCheck() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onChanged(_isChecked); // Notify parent widget
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheck,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              if (value != null) _toggleCheck();
            },
            activeColor: widget.activeColor,
          ),
          customText(widget.label, 14.0, context),
        ],
      ),
    );
  }
}
