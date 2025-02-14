import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';
import '../Controllers/AssignedTabTripController.dart';
import '../Controllers/CollectedSubmittedCancelledTabTripsControllers.dart';
import '../Models/AssignedTabTripsModels.dart';
import '../Models/CollectedSubmittedCancelledTabTripsModels.dart';
import '../Widgets/AppBarWidget.dart';
import '../Widgets/CustomDateRange.dart';
import '../Widgets/ResponsiveBodyFontWidget.dart';
import 'TabTripDetails/AssignedTripsTabs.dart';
import 'TabTripDetails/CancelledTripsTabs.dart';
import 'TabTripDetails/CollectedTripTabs.dart';
import 'TabTripDetails/SubmittedTripsTabs.dart';

class LogisticsHome extends StatefulWidget {
  const LogisticsHome({super.key});

  @override
  State<LogisticsHome> createState() => _LogisticsHomeState();
}

class _LogisticsHomeState extends State<LogisticsHome>
    with SingleTickerProviderStateMixin {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now();
  }

  void _onDateRangeChanged(DateTime? start, DateTime? end) {
    setState(() {
      _startDate = start;
      _endDate = end;
    });
    // // Ensure both dates are selected before making the API call
    // if (_startDate != null && _endDate != null) {
    //   fetchAllTabReportsData(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            HeaderBar(
              height: responsive.screenHeight * 0.26,
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            size: 35,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Hi Balaji Swaminathan',
                                style: TextStyle(
                                  fontSize: responsive.getTitleFontSize(),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Suvarna Diagnostics',
                                style: TextStyle(
                                  fontSize: responsive.getBodyFontSize(),
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomDateRangePicker(
                      onDateRangeChanged: _onDateRangeChanged,
                      initialStartDate: _startDate,
                      initialEndDate: _endDate,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TabBar(
                tabs: const [
                  Tab(text: 'Assigned'),
                  Tab(text:'Collected'),
                  Tab(text: 'Submitted'),
                  Tab(text: 'Cancelled'),
                ],
                indicatorColor: Color.fromARGB(255, 68, 115, 162),
                labelColor: Color.fromARGB(255, 68, 115, 162),
                unselectedLabelColor: Color.fromARGB(255, 153, 152, 152),
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 153, 152, 152),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AssignedTripsTabs(
                    startDate: "${_startDate}",
                    endDATE: "${_endDate}",
                  ),
                  CollectedTripsTabs(
                    startDate: "${_startDate}",
                    endDATE: "${_endDate}",
                  ),
                  SubmittedTripsTabs(
                    startDate: "${_startDate}",
                    endDATE: "${_endDate}",
                  ),
                  CancelledTripsTabs(
                    startDate: "${_startDate}",
                    endDATE: "${_endDate}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
