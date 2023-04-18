import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/dark background.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 60,
                  child: Icon(
                    Icons.people_sharp,
                    size: 80,
                    color: Color.fromARGB(255, 4, 251, 230),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 30,
                    ),
                    
                    Icon(
                      Icons.login,
                      size: 50,
                      color: Color.fromARGB(255, 23, 195, 238),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 30, color: Colors.lime),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      Icons.logout_outlined,
                      size: 50,
                      color: Color.fromARGB(255, 23, 195, 238),
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 30, color: Colors.lime),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
