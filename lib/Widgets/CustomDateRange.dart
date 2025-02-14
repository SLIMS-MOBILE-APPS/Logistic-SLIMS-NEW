import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateRangePicker extends StatefulWidget {
  final Function(DateTime? startDate, DateTime? endDate) onDateRangeChanged;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  const CustomDateRangePicker({
    Key? key,
    required this.onDateRangeChanged,
    this.initialStartDate,
    this.initialEndDate,
  }) : super(key: key);

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  String? _displayedDateRange;
  String? _selectedRange;

  final List<String> _dateRangeOptions = [
    'Today',
    'Yesterday',
    'This Week',
    'Last Week',
    'This Month',
    'Custom'
  ];

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate ?? DateTime.now();
    _endDate = widget.initialEndDate ?? DateTime.now();
    _updateDisplayedDateRange(); // Initialize with today's date range
  }

  void _updateDisplayedDateRange() {
    if (_startDate != null && _endDate != null) {
      DateFormat dateFormat = DateFormat('MMM d');
      DateFormat yearFormat = DateFormat(', yyyy');

      if (_selectedRange == 'Today' || _selectedRange == 'Yesterday') {
        _displayedDateRange =
            '${dateFormat.format(_startDate!)}${yearFormat.format(_startDate!)}';
      } else {
        _displayedDateRange =
            '${dateFormat.format(_startDate!)} - ${dateFormat.format(_endDate!)}${yearFormat.format(_endDate!)}';
      }
    }
  }

  void _onDateRangeSelected(String? selectedRange) {
    if (selectedRange == null) return;
    _selectedRange = selectedRange;

    DateTime? newStartDate;
    DateTime? newEndDate;

    switch (selectedRange) {
      case 'Today':
        newStartDate = DateTime.now();
        newEndDate = DateTime.now();
        break;
      case 'Yesterday':
        newStartDate = DateTime.now().subtract(const Duration(days: 1));
        newEndDate = DateTime.now().subtract(const Duration(days: 1));
        break;
      case 'This Week':
        DateTime now = DateTime.now();
        newStartDate = now.subtract(Duration(days: now.weekday - 1));
        newEndDate = now;
        break;
      case 'Last Week':
        DateTime now = DateTime.now();
        newStartDate = now.subtract(Duration(days: now.weekday + 6));
        newEndDate = now.subtract(Duration(days: now.weekday));
        break;
      case 'This Month':
        DateTime now = DateTime.now();
        newStartDate = DateTime(now.year, now.month, 1);
        newEndDate = now;
        break;
      case 'Custom':
        _showCustomDateRangePicker(context);
        return;
      default:
        return;
    }

    setState(() {
      _startDate = newStartDate;
      _endDate = newEndDate;
      _updateDisplayedDateRange();
    });

    widget.onDateRangeChanged(_startDate, _endDate);
  }

  Future<void> _showCustomDateRangePicker(BuildContext context) async {
    final ThemeData customTheme = ThemeData(
      primaryColor:
          const Color.fromARGB(255, 11, 102, 195), // Customize primary color
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 11, 102, 195), // Selected range color
        onPrimary: Colors.white, // Text color on selected range
        surface: Colors.white, // Calendar background color
        onSurface: Colors.black, // Text color on calendar days
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(color: Colors.white), // Header text color
        bodyText2: TextStyle(color: Colors.black), // Days text color
      ),
    );

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now(),
        end: _endDate ?? DateTime.now(),
      ),
      builder: (context, child) {
        return Theme(
          data: customTheme,
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _updateDisplayedDateRange();
      });

      widget.onDateRangeChanged(_startDate, _endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 11, 102, 195),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            _displayedDateRange ?? 'Select Date Range',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          DropdownButton<String>(
            value: null,
            dropdownColor: Colors.white.withOpacity(0.9),
            onChanged: _onDateRangeSelected,
            underline: const SizedBox.shrink(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 24,
            ),
            borderRadius: BorderRadius.circular(10),
            items: _dateRangeOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0),
                      child: Row(
                        children: [
                          // Add an icon only if the value is "Custom"
                          if (value == 'Custom') ...[
                            const Icon(
                              Icons.calendar_today,
                              color: Color.fromARGB(255, 11, 102, 195),
                              size: 16,
                            ),
                            const SizedBox(
                                width: 8), // Space between icon and text
                          ],
                          Text(
                            value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add a divider except for the last item
                    if (value != _dateRangeOptions.last)
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Divider(
                            height: 1,
                            color: Color.fromARGB(255, 11, 102, 195)),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
