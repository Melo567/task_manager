import 'package:flutter/material.dart';
import 'package:task_manager/core/styles/theme.dart';
import 'package:task_manager/core/utils/date_time_extension.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    required this.onChange,
    this.defaultValue,
    this.style = defaultTextStyle,
  });

  final Function(DateTime dateTime) onChange;

  final DateTime? defaultValue;

  final TextStyle? style;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  DateTime? _dateTime;

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      _dateTime = widget.defaultValue;
      dateController.text = _dateTime!.humanDate;
      timeController.text = _dateTime!.humanTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Due date'),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: dateController,
                  focusNode: AlwaysDisabledFocusNode(),
                  autofocus: false,
                  onTapOutside: (pointer) => FocusScope.of(context).unfocus(),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _dateTime ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2050),
                    );
                    if (date != null) {
                      _dateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        _dateTime?.hour ?? date.hour,
                        _dateTime?.minute ?? date.minute,
                      );
                      dateController.text = _dateTime!.humanDate;
                      widget.onChange(_dateTime!);
                    }
                  },
                  style: widget.style,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'DD-MM-YYYY',
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: timeController,
                  autofocus: false,
                  focusNode: AlwaysDisabledFocusNode(),
                  onTapOutside: (pointer) => FocusScope.of(context).unfocus(),
                  onTap: () async {
                    final hour = await showTimePicker(
                      context: context,
                      initialTime: _dateTime != null
                          ? TimeOfDay(
                              hour: _dateTime!.hour,
                              minute: _dateTime!.minute,
                            )
                          : TimeOfDay.now(),
                    );
                    if (hour != null) {
                      final temp = DateTime.now();
                      _dateTime = DateTime(
                        _dateTime?.year ?? temp.year,
                        _dateTime?.month ?? temp.month,
                        _dateTime?.day ?? temp.day,
                        hour.hour,
                        hour.minute,
                      );
                      timeController.text = _dateTime!.humanTime;
                      widget.onChange(_dateTime!);
                    }
                  },
                  style: widget.style,
                  decoration: const InputDecoration(
                    labelText: 'Hour',
                    hintText: 'HH:mm',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dateTime ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                  );
                  if (date != null) {
                    _dateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      _dateTime?.hour ?? date.hour,
                      _dateTime?.minute ?? date.minute,
                    );
                    dateController.text = _dateTime!.humanDate;
                    widget.onChange(_dateTime!);
                  }
                  if (context.mounted) {
                    final hour = await showTimePicker(
                      context: context,
                      initialTime: _dateTime != null
                          ? TimeOfDay(
                              hour: _dateTime!.hour,
                              minute: _dateTime!.minute,
                            )
                          : TimeOfDay.now(),
                    );
                    if (hour != null) {
                      final temp = DateTime.now();
                      _dateTime = DateTime(
                        _dateTime?.year ?? temp.year,
                        _dateTime?.month ?? temp.month,
                        _dateTime?.day ?? temp.day,
                        hour.hour,
                        hour.minute,
                      );
                      timeController.text = _dateTime!.humanTime;
                      widget.onChange(_dateTime!);
                    }
                  }
                },
                icon: const Icon(
                  Icons.date_range,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timeController.dispose();
    dateController.dispose();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
