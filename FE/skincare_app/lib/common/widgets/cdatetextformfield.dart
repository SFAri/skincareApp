import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CDateTimePickerFormField extends FormField<DateTime> {
  CDateTimePickerFormField({
    Key? key,
    DateTime? initialValue,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    ValueChanged<DateTime?>? onChanged,
    String? label,
    bool pickTime = false,
  }) : super(
         key: key,
         initialValue: initialValue,
         onSaved: onSaved,
         validator: validator,
         builder: (FormFieldState<DateTime> state) {
           return _DateTimePickerField(
             state: state,
             label: label,
             pickTime: pickTime,
             onChanged: onChanged,
           );
         },
       );
}

class _DateTimePickerField extends StatelessWidget {
  final FormFieldState<DateTime> state;
  final String? label;
  final bool pickTime;
  final ValueChanged<DateTime?>? onChanged;

  const _DateTimePickerField({
    required this.state,
    required this.label,
    required this.pickTime,
    this.onChanged,
  });

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: state.value ?? now,
    );

    if (pickedDate == null) return;

    DateTime finalDate = pickedDate;

    if (pickTime) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(state.value ?? now),
      );
      if (pickedTime != null) {
        finalDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }

    state.didChange(finalDate);
    onChanged?.call(finalDate);
  }

  @override
  Widget build(BuildContext context) {
    final value = state.value;

    final text = value == null
        ? ""
        : pickTime
        ? DateFormat("dd/MM/yyyy HH:mm").format(value)
        : DateFormat("dd/MM/yyyy").format(value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _pickDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              errorText: state.errorText,
              border: OutlineInputBorder(),
            ),
            child: Text(
              text.isEmpty ? "Chọn ngày" : text,
              style: TextStyle(
                color: text.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
