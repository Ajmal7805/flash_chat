import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screen/chatscreen.dart';
import 'package:flash_chat/screen/loginscreen.dart';
import 'package:flash_chat/screen/registration.dart';
import 'package:flash_chat/screen/welcomScreen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        Registration.id: (context) => const Registration(),
        Loginscreen.id: (context) => const Loginscreen(),
        Chatscreen.id: (context) => const Chatscreen()
      },
      initialRoute: WelcomeScreen.id,
    );
  }
}
