import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_player/pages/home_page.dart';
import 'package:music_player/pages/profile_page.dart';
import 'package:music_player/pages/search_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      
    );
  }
} 

class Structure extends StatefulWidget {
  const Structure({Key? key}) : super(key: key);
  @override
  State<Structure> createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  int index = 0;
  final screens = [
    const Homepage(),
    const Searchpage(),
    const Profilepage(),
  ];
  final items = [
    const Icon(
      Icons.home,
      size: 30,
    ),
    const Icon(
      Icons.saved_search,
      size: 30,
    ),
    const Icon(
      Icons.account_circle_rounded,
      size: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/dark background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: screens[index],
              ),
              CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: const Color.fromARGB(255, 77, 231, 187),
                buttonBackgroundColor: Colors.lightBlue,
                animationDuration: const Duration(milliseconds: 350),
                height: 60,
                index: index,
                items: items,
                onTap: (selectedindex) {
                  setState(() {
                    index = selectedindex;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getselectedwidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const Homepage();
        break;
      case 1:
        widget = const SearchPage();
        break;
      case 2:
        widget = const Profilepage();
        break;
      default:
        widget = const Homepage();
        break;
    }
    return widget;
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => const Structure()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 600,
              width: 400,
              child: Image(
                image: AssetImage('images/phoenix logo.jpg'),
                fit: BoxFit.fill,
                width: 300,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            SpinKitSpinningLines(
              color: Colors.orange,
              lineWidth: 5,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
