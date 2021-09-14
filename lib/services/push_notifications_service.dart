
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationService {

  static FirebaseMessaging message = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

  
  static Future _onBackgroundHandler( RemoteMessage message ) async {

    print( message.data );

    _messageStream.add( message.data['producto'] ?? 'No data' );

  }

  static Future _onMessageHandler( RemoteMessage message ) async {

    print( message.data );

    _messageStream.add( message.data['producto'] ?? 'No data' );
    
  }


  static Future _onMessageOpenApp( RemoteMessage message ) async {

    print( message.data );

    _messageStream.add( message.data['producto'] ?? 'No data' );
    
  }


  static Future initializeApp() async {

    await Firebase.initializeApp();
    token = await message.getToken();
    print( 'Token $token');

    FirebaseMessaging.onBackgroundMessage( _onBackgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

  }

  static closeStreams() {

    _messageStream.close();

  }


}