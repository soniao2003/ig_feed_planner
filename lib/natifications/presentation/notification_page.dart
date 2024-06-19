import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:instagram_planner/natifications/data/notification_class.dart';

class ScheduleNotificationScreen extends StatefulWidget {
  const ScheduleNotificationScreen({Key? key}) : super(key: key);

  @override
  _ScheduleNotificationScreenState createState() =>
      _ScheduleNotificationScreenState();
}

class _ScheduleNotificationScreenState
    extends State<ScheduleNotificationScreen> {
  List<NotificationItem> scheduledNotifications = [];

  _resetStyle() {
    InAppNotifications.instance
      ..titleFontSize = 14.0
      ..descriptionFontSize = 14.0
      ..textColor = Colors.black
      ..backgroundColor = Colors.white
      ..shadow = true
      ..animationStyle = InAppNotificationsAnimationStyle.scale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule Notification',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 45, 44, 44),
      ),
      body: Container(
        color: Color.fromARGB(255, 45, 44, 44),
        padding: const EdgeInsets.only(top: 50.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "You can schedule notification here to remind you to post you photo",
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  _resetStyle();
                  final DateTime? pickedDateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );

                  if (pickedDateTime != null) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      final pickedDateTimeWithTime = DateTime(
                        pickedDateTime.year,
                        pickedDateTime.month,
                        pickedDateTime.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      _scheduleNotification(
                        'Scheduled Notification',
                        'Time to post your photo',
                        pickedDateTimeWithTime,
                      );
                    }
                  }
                },
                child: const Text("schedule",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scheduleNotification(
    String title,
    String description,
    DateTime scheduledDateTime,
  ) {
    final newItem = NotificationItem(
      title: title,
      description: description,
      scheduledDateTime: scheduledDateTime,
    );

    setState(() {
      scheduledNotifications.add(newItem);
    });

    // Schedule a timer to check if notifications need to be shown.
    _startNotificationTimer();
  }

  void _startNotificationTimer() {
    // Schedule a timer to check if any notifications need to be shown.
    const duration = Duration(seconds: 30); // Adjust as needed
    Timer.periodic(duration, (timer) {
      final now = DateTime.now();
      final notificationsToShow = scheduledNotifications
          .where((item) => item.scheduledDateTime.isBefore(now))
          .toList();

      notificationsToShow.forEach((item) {
        InAppNotifications.show(
          title: item.title,
          description: item.description,
          onTap: () {},
        );
        scheduledNotifications.remove(item);
      });

      if (scheduledNotifications.isEmpty) {
        timer
            .cancel(); // Stop the timer if there are no more notifications to show
      }
    });
  }
}

// class MainScreen extends StatelessWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter In-App Notifications'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(top: 50.0),
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ScheduleNotificationScreen()),
//                 );
//               },
//               child: const Text("Schedule Notification"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: MainScreen(),
//   ));
// }
