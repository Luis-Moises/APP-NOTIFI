import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:app_notificaciones3/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value) {
      print("Device token");
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF02AAB0),
              Color(0xFF00CDAC),
              Color(0xFF02AAB0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.6, 0.9],
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              notificationServices.getDeviceToken().then((value) async {
                var movil =
                    "femspFOkQEajXuTIz9IwQE:APA91bHKPnvfBVz3rmVIUkf3-uCCVN3a7rxPiqQbve5kYVCeWSQsYxeHKrIWYxCy1WpaDJHIkUps7rrO-LrYAYu8ZXw7ZiiO18ozOWM1yfV9hor5fJY-PWwzD46AT5EjI4TdqMSp7ujJ";
                var wear =
                    "cYnHU1CvQla-AZslyzSkCH:APA91bH3kxcxU0vPs8gzYCOV93PSIH2Y8uhcw94uS7C6a4-IFLgdbHkhbcAuM9rwpT7yDtS3gLqAfZkheUsAyaZUYi4qsmd6UrZn-dR2FhZ_9-66YXaLZhvv28nhktoQYkOKMbahc5e4";
                var data = {
                  "to": movil,
                  "priority": "high",
                  "notification": {
                    "title": "Moises Molina Rocha",
                    "body": "Notificacion Enviada",
                  },
                  "data":
                   {"type":
                    "msj", 
                    "id": 
                    "8995748"}
                };
                await http.post(
                    Uri.parse("https://fcm.googleapis.com/fcm/send"),
                    body: jsonEncode(data),
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                      "Authorization":
                          "key=AAAAx_CoI7w:APA91bFg4kxmhMLjc334SBFcJwiEkOpR8MlsWejqDQG45ICQCrHoqVKvC3jRTeAKW-VR2JKPqE9c5jI696BjOKjenwug_kQugqWibLEBKc0brNjCZ2uH0voA60vN4QJIW0ZsO_6L_omZ"
                    });
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 10,
              primary: Colors.white,
              onPrimary: Color(0xFF02AAB0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              shadowColor: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                'Enviar Notificación',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
