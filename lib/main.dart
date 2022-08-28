import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/pages/Acount_Page.dart';
import 'package:graduation_project/pages/CategoryPage.dart';
import 'package:graduation_project/pages/MainScreen.dart';
import 'package:graduation_project/pages/MessagePage.dart';
import 'package:graduation_project/pages/loginScreen.dart';
import 'package:graduation_project/pages/rulesPage.dart';
import 'package:graduation_project/providers/userStateProvider.dart';
import 'package:graduation_project/services/auth.dart';
import 'package:graduation_project/wrapper.dart';
import 'package:provider/provider.dart';

import 'defaults.dart';

// firebase options
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UserState())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<UserState>(
          create: (_) => UserState(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Cairo', primaryColor: Color(0xff48A9C5)),
        // home: HomePage(),
        home: Wrapper(),
        routes: {
          '/home': ((context) => HomePage()),
          '/login': ((context) => LoginScreen()),
          '/rules': ((context) => RulesPage()),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var indexClicked = 0;
  final pages = [MainScreen(), CategoryPage(), MessagesPage(), AccountPage()];
  final pageTitle = ['الصفحة الرئيسية', 'الفئات', 'الرسائل', 'الحساب'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: pages[indexClicked] //pages[indexClicked]
        ,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexClicked,
          backgroundColor: Color(0xff48A9C5),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          elevation: 60,
          onTap: (value) {
            setState(() {
              if (FirebaseAuth.instance.currentUser == null && value == 2)
                indexClicked = 3;
              else
                indexClicked = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Defaults.bottomNavigationIcons[0],
                  color: Colors.white,
                ),
                activeIcon: Icon(
                  Defaults.bottomNavigationIcons[0],
                  color: Colors.black12,
                ),
                label: Defaults.bottomNavigationText[0]),
            BottomNavigationBarItem(
                icon: Icon(Defaults.bottomNavigationIcons[1],
                    color: Colors.white),
                activeIcon: Icon(
                  Defaults.bottomNavigationIcons[1],
                  color: Colors.black12,
                ),
                label: Defaults.bottomNavigationText[1]),
            BottomNavigationBarItem(
                icon: Icon(Defaults.bottomNavigationIcons[2],
                    color: Colors.white),
                activeIcon: Icon(
                  Defaults.bottomNavigationIcons[2],
                  color: Colors.black12,
                ),
                label: Defaults.bottomNavigationText[2]),
            BottomNavigationBarItem(
                icon: Icon(Defaults.bottomNavigationIcons[3],
                    color: Colors.white),
                activeIcon: Icon(
                  Defaults.bottomNavigationIcons[3],
                  color: Colors.black12,
                ),
                label: Defaults.bottomNavigationText[3]),
          ],
        ),
      ),
    );
  }
}
