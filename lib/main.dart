import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/firebase_options.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/responsive/mobilescreen_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/webscreen_layout.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider_base_tools/provider_base_tools.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: "Instagram",
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData.light().copyWith(scaffoldBackgroundColor: primaryColor),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                }
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('(snapshot.error)'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
              return const LoginPage();
            }),
      ),
    );
  }
}
