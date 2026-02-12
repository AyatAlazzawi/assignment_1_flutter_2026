import 'dart:math'; //this is the library that is used as the base for the random number generator
import 'package:flutter/material.dart';

//This app was built by Ayat Al-Azzawi for Mobile Web App course in Winter 2026
//Please not that I am also using this assinment to understand how flutter works so it may have some extra comments

/*Ayat Flutter Info
-In flutter screens and components = classes*/

void main() {
  runApp(const MyApp());
}

//var intValue = Random().nextInt(10); //this variable has an integer vaue greater or equal to one but less than 10, dart math also allows you to do this fir doubles or bools

//Root widget of the app
//Root widget = app wide setup = themedata, material app, App title, initial page/ home page, and any routes
//How will my WHOLE app look and behave?
/*so basic app structure is this basically:
main()
 └── MyApp (root widget)
     └── MaterialApp
         ├── ThemeData
         ├── HomePage (Page 1)
         │    └── Scaffold
         │         ├── AppBar
         │         └── Body
         └── SecondPage (Page 2)
              └── Scaffold
                   ├── AppBar
                   └── Body
  

  //themedata map
  ThemeData
├── AppBar colors
├── Page (Scaffold) background color
├── Button colors
├── Text colors
└── Overall color scheme

 */
class MyApp extends StatelessWidget {
  //create a new class MyApp which will not have a changing state since this is a root app widget which only sets up global things like themes
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Number Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFF147CD3),
          foregroundColor: Colors.white, //title and icon color
        ),
        scaffoldBackgroundColor: const Color(0xFF2196F3),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A237E),
            foregroundColor: Colors.white,
          ),
        ),
      ),

      // First page that shows when the app starts
      home: const HomePage(),

      // Optional: named route for the second page
      //routes: {'/second': (context) => const StatisticsPage()},
    );
  }
}

//for pages each page will have its own scaffold, appbar, and body
//basically every page is another widget
//keep in mind flutter doesn't automatically switch pages so we need to use Navigator.push(......) to go next, and pop to go back
// -------------------- PAGE 1 --------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result = Random().nextInt(
    10,
  ); //this variable has an integer vaue greater or equal to one but less than 10, dart math also allows you to do this fir doubles or bools
  bool displayRandomNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number Generator'),
        centerTitle: false,
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  //answer = 5 + 3;
                  displayRandomNumber = true;
                });
              },
              child: const Text('Generate'),
            ),

            const SizedBox(height: 20),

            if (displayRandomNumber)
              Text('Answer: $result', style: const TextStyle(fontSize: 28)),
          ],
        ),
      ),
    );
  }
}
