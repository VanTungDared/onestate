// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//   final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     const AndroidInitializationSettings androidInitSettings =
//         AndroidInitializationSettings(
//             'ic_notification'); // Đảm bảo icon tồn tại

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitSettings);

//     await _localNotifications.initialize(initializationSettings);
//   }

//   Future<void> showNotification(
//       {required String title, required String body}) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'channel_id', 'channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: 'app_icon', // Đặt đúng tên icon
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     await _localNotifications.show(0, title, body, notificationDetails);
//   }
// }
