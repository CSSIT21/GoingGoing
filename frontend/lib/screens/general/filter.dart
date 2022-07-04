import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/provider/schedule_provider.dart';
import '../../services/provider/search_provider.dart';
import '../../widgets/common/date_picker_field.dart';
import '../../widgets/common/dropdown_field.dart';
import '../../widgets/filter/filter_section.dart';
import '../../widgets/filter/time_picker.dart';
import '../../widgets/filter/bottom_button.dart';
import '../../widgets/filter/header.dart';
import '../../widgets/common/close_app_bar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  void _onFilter(BuildContext context) {
    final searchSchedules = context.read<ScheduleProvider>().searchSchedules;
    var temp = [...searchSchedules];

    final date = context.read<SearchProvider>().date;
    final time = context.read<SearchProvider>().time;
    final partySize = context.read<SearchProvider>().partySize;
    final filters = context.read<SearchProvider>().filters;

    if (date != null) {
      temp.retainWhere((el) =>
          el.startTripDateTime.year == date.year &&
          el.startTripDateTime.month == date.month &&
          el.startTripDateTime.day == date.day);
    }
    if (time != null) {
      temp.retainWhere((el) =>
          el.startTripDateTime.hour == time.hour &&
          el.startTripDateTime.minute > (time.minute - 31) &&
          el.startTripDateTime.minute < (time.minute + 31));
    }
    if (partySize != '-') {
      temp.retainWhere((el) =>
          (el.party.maximumPassengers + 1).compareTo(int.parse(partySize)) ==
          0);
    }

    final List<String> selected = filters.getFilterNames(true);
    if (selected.isNotEmpty) {
      var original = <String>[];
      temp.retainWhere((el) {
        original = el.filter.getFilterNames();
        return selected.every((key) => original.contains(key));
      });
    }

    if (temp.length == searchSchedules.length) {
      Navigator.pop(context, null);
    } else {
      Navigator.pop(context, temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _pickedDate =
        context.select((SearchProvider provider) => provider.date);
    final _pickedTime =
        context.select((SearchProvider provider) => provider.time);
    final _partySize =
        context.select((SearchProvider provider) => provider.partySize);
    final _filters =
        context.select((SearchProvider provider) => provider.filters);

    return Scaffold(
      appBar: CloseAppBar(
        title: 'Refine',
        onPressed: () => Navigator.pop(context, false),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 32),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.81,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterHeader(onClear: () {
                context.read<SearchProvider>().clearAll();
                setState(() {});
              }),
              DatePickerField(
                labelText: 'Appointment Date',
                pickedDate: _pickedDate,
                onPickedDate: (DateTime date) =>
                    context.read<SearchProvider>().date = date,
              ),
              TimePicker(
                labelText: 'Appointment Time',
                pickedTime: _pickedTime,
                onPickedTime: (TimeOfDay time) =>
                    context.read<SearchProvider>().time = time,
              ),
              DropdownField(
                  hintText: 'Select Party Size',
                  labelText: 'Party',
                  selectedValue: _partySize,
                  list: const ['-', '2', '3', '4', '5', '6'],
                  onChanged: (value) {
                    if (value == '-') {
                      context.read<SearchProvider>().partySize = null;
                    } else {
                      context.read<SearchProvider>().partySize = value;
                    }
                  }),
              FilterSection(
                _filters.filters,
                onTap: (String key, bool value) {
                  context.read<SearchProvider>().setFilters(key, value);
                  setState(() {});
                },
              ),
              BottomButton(() => _onFilter(context)),
            ],
          ),
        ),
      ),
    );
  }
}
