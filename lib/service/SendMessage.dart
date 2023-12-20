import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendFriendRequestNotification(String friendFCMToken) async {
  final String serverKey = 'AAAAfnMmmno:APA91bFZmXrGrg-0P4lg39YHqIam-TLJzZiP6okbOBMhS9XOFuq98Y2NyMbkqu1tjrf00bLCyMrfCCy08-rqVSyeAL0J5KbqHxomYh5YgE4CYXB-GrrlJaOz3zZOcsfKWKg8nKc93EdR';

  final String url = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final Map<String, dynamic> notification = {
    'body': 'You have a new friend request!',
    'title': 'Friend Request',
    'sound': 'default',
    'priority': 'high',
  };

  final Map<String, dynamic> data = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'id': '1',
    'status': 'done',
  };

  final Map<String, dynamic> bodyData = {
    'to': friendFCMToken,
    'notification': notification,
    'data': data,
  };

  final http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(bodyData),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification. Error: ${response.reasonPhrase}');
  }
}